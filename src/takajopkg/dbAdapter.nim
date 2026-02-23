import db_connector/db_sqlite
import strutils

# =============================================================================
# DuckDB C API bindings (minimal subset needed for this project)
# =============================================================================

when defined(macosx):
  {.passC: "-I/opt/homebrew/include -I/usr/local/include".}
  {.passL: "-L/opt/homebrew/lib -L/usr/local/lib -lduckdb".}
elif defined(windows):
  {.passL: "-lduckdb".}
else:
  {.passL: "-lduckdb".}

type
  DuckDBDatabase {.importc: "struct _duckdb_database", header: "<duckdb.h>".} = object
    internal_ptr: pointer
  DuckDBDatabasePtr = ptr DuckDBDatabase

  DuckDBConnection {.importc: "struct _duckdb_connection", header: "<duckdb.h>".} = object
    internal_ptr: pointer
  DuckDBConnectionPtr = ptr DuckDBConnection

  DuckDBPreparedStatement {.importc: "struct _duckdb_prepared_statement", header: "<duckdb.h>".} = object
    internal_ptr: pointer
  DuckDBPreparedStatementPtr = ptr DuckDBPreparedStatement

  DuckDBResult {.importc: "duckdb_result", header: "<duckdb.h>".} = object
    deprecated_column_count: uint64
    deprecated_row_count: uint64
    deprecated_rows_changed: uint64
    deprecated_columns: pointer
    deprecated_error_message: cstring
    internal_data: pointer

  DuckDBState {.importc: "duckdb_state", header: "<duckdb.h>".} = enum
    DuckDBSuccess = 0
    DuckDBError = 1

proc duckdb_open(path: cstring, out_database: ptr DuckDBDatabasePtr): DuckDBState {.importc, header: "<duckdb.h>".}
proc duckdb_close(database: ptr DuckDBDatabasePtr) {.importc, header: "<duckdb.h>".}
proc duckdb_connect(database: DuckDBDatabasePtr, out_connection: ptr DuckDBConnectionPtr): DuckDBState {.importc, header: "<duckdb.h>".}
proc duckdb_disconnect(connection: ptr DuckDBConnectionPtr) {.importc, header: "<duckdb.h>".}
proc duckdb_query(connection: DuckDBConnectionPtr, query: cstring, out_result: ptr DuckDBResult): DuckDBState {.importc, header: "<duckdb.h>".}
proc duckdb_destroy_result(result: ptr DuckDBResult) {.importc, header: "<duckdb.h>".}
proc duckdb_column_count(result: ptr DuckDBResult): uint64 {.importc, header: "<duckdb.h>".}
proc duckdb_row_count(result: ptr DuckDBResult): uint64 {.importc, header: "<duckdb.h>".}
proc duckdb_value_varchar(result: ptr DuckDBResult, col: uint64, row: uint64): cstring {.importc, header: "<duckdb.h>".}
proc duckdb_value_is_null(result: ptr DuckDBResult, col: uint64, row: uint64): bool {.importc, header: "<duckdb.h>".}
proc duckdb_free(p: pointer) {.importc, header: "<duckdb.h>".}
proc duckdb_result_error(result: ptr DuckDBResult): cstring {.importc, header: "<duckdb.h>".}

proc duckdb_prepare(connection: DuckDBConnectionPtr, query: cstring, out_prepared_statement: ptr DuckDBPreparedStatementPtr): DuckDBState {.importc, header: "<duckdb.h>".}
proc duckdb_destroy_prepare(prepared_statement: ptr DuckDBPreparedStatementPtr) {.importc, header: "<duckdb.h>".}
proc duckdb_bind_varchar(prepared_statement: DuckDBPreparedStatementPtr, param_idx: uint64, val: cstring): DuckDBState {.importc, header: "<duckdb.h>".}
proc duckdb_execute_prepared(prepared_statement: DuckDBPreparedStatementPtr, out_result: ptr DuckDBResult): DuckDBState {.importc, header: "<duckdb.h>".}
proc duckdb_prepare_error(prepared_statement: DuckDBPreparedStatementPtr): cstring {.importc, header: "<duckdb.h>".}

# =============================================================================
# DbAdapter abstraction layer
# =============================================================================

type
  DbBackend* = enum
    backendDuckDB
    backendSQLite

  DbAdapter* = object
    case backend*: DbBackend
    of backendSQLite:
      sqliteConn*: db_sqlite.DbConn
    of backendDuckDB:
      duckDbPtr: DuckDBDatabasePtr
      duckConn: DuckDBConnectionPtr

proc openDb*(path: string, backend: DbBackend): DbAdapter =
  case backend
  of backendSQLite:
    let conn = db_sqlite.open(path, "", "", "")
    result = DbAdapter(backend: backendSQLite, sqliteConn: conn)
  of backendDuckDB:
    var dbPtr: DuckDBDatabasePtr
    var connPtr: DuckDBConnectionPtr
    let state = duckdb_open(path.cstring, addr dbPtr)
    if state != DuckDBSuccess:
      raise newException(IOError, "Failed to open DuckDB database: " & path)
    let connState = duckdb_connect(dbPtr, addr connPtr)
    if connState != DuckDBSuccess:
      duckdb_close(addr dbPtr)
      raise newException(IOError, "Failed to connect to DuckDB database: " & path)
    result = DbAdapter(backend: backendDuckDB, duckDbPtr: dbPtr, duckConn: connPtr)

proc closeDb*(db: var DbAdapter) =
  case db.backend
  of backendSQLite:
    db.sqliteConn.close()
  of backendDuckDB:
    duckdb_disconnect(addr db.duckConn)
    duckdb_close(addr db.duckDbPtr)

proc translateQuery*(query: string, backend: DbBackend): string =
  ## Translate SQLite-specific SQL to DuckDB-compatible SQL
  if backend == backendSQLite:
    return query

  result = query
  # date(datetime(timestamp, 'localtime')) -> SUBSTRING(timestamp, 1, 10)
  result = result.replace("date(datetime(timestamp, 'localtime'))", "SUBSTRING(timestamp, 1, 10)")
  result = result.replace("date(datetime(timestamp))", "SUBSTRING(timestamp, 1, 10)")
  # datetime(timestamp, 'localtime') -> timestamp
  result = result.replace("datetime(timestamp, 'localtime')", "timestamp")
  # datetime(timestamp) -> timestamp
  result = result.replace("datetime(timestamp)", "timestamp")
  # DATE(timestamp) -> SUBSTRING(timestamp, 1, 10)
  result = result.replace("DATE(timestamp)", "SUBSTRING(timestamp, 1, 10)")

proc exec*(db: DbAdapter, query: string) =
  case db.backend
  of backendSQLite:
    db.sqliteConn.exec(db_sqlite.sql(translateQuery(query, backendSQLite)))
  of backendDuckDB:
    let translated = translateQuery(query, backendDuckDB)
    var res: DuckDBResult
    let state = duckdb_query(db.duckConn, translated.cstring, addr res)
    if state != DuckDBSuccess:
      let err = duckdb_result_error(addr res)
      let errMsg = if err != nil: $err else: "unknown error"
      duckdb_destroy_result(addr res)
      raise newException(DbError, "DuckDB exec error: " & errMsg)
    duckdb_destroy_result(addr res)

proc getAllRows*(db: DbAdapter, query: string, args: varargs[string, `$`]): seq[seq[string]] =
  case db.backend
  of backendSQLite:
    let translated = translateQuery(query, backendSQLite)
    return db.sqliteConn.getAllRows(db_sqlite.sql(translated), args)
  of backendDuckDB:
    let translated = translateQuery(query, backendDuckDB)
    # Use prepared statement if we have args
    if args.len > 0:
      var stmtPtr: DuckDBPreparedStatementPtr
      let prepState = duckdb_prepare(db.duckConn, translated.cstring, addr stmtPtr)
      if prepState != DuckDBSuccess:
        let err = duckdb_prepare_error(stmtPtr)
        let errMsg = if err != nil: $err else: "unknown error"
        duckdb_destroy_prepare(addr stmtPtr)
        raise newException(DbError, "DuckDB prepare error: " & errMsg)

      for i, arg in args:
        let bindState = duckdb_bind_varchar(stmtPtr, uint64(i + 1), arg.cstring)
        if bindState != DuckDBSuccess:
          duckdb_destroy_prepare(addr stmtPtr)
          raise newException(DbError, "DuckDB bind error at param " & $(i + 1))

      var res: DuckDBResult
      let execState = duckdb_execute_prepared(stmtPtr, addr res)
      if execState != DuckDBSuccess:
        let err = duckdb_result_error(addr res)
        let errMsg = if err != nil: $err else: "unknown error"
        duckdb_destroy_result(addr res)
        duckdb_destroy_prepare(addr stmtPtr)
        raise newException(DbError, "DuckDB execute error: " & errMsg)

      let colCount = duckdb_column_count(addr res)
      let rowCount = duckdb_row_count(addr res)
      result = @[]
      for r in 0'u64 ..< rowCount:
        var row: seq[string] = @[]
        for c in 0'u64 ..< colCount:
          if duckdb_value_is_null(addr res, c, r):
            row.add("")
          else:
            let val = duckdb_value_varchar(addr res, c, r)
            if val != nil:
              row.add($val)
              duckdb_free(cast[pointer](val))
            else:
              row.add("")
        result.add(row)
      duckdb_destroy_result(addr res)
      duckdb_destroy_prepare(addr stmtPtr)
    else:
      var res: DuckDBResult
      let state = duckdb_query(db.duckConn, translated.cstring, addr res)
      if state != DuckDBSuccess:
        let err = duckdb_result_error(addr res)
        let errMsg = if err != nil: $err else: "unknown error"
        duckdb_destroy_result(addr res)
        raise newException(DbError, "DuckDB query error: " & errMsg)

      let colCount = duckdb_column_count(addr res)
      let rowCount = duckdb_row_count(addr res)
      result = @[]
      for r in 0'u64 ..< rowCount:
        var row: seq[string] = @[]
        for c in 0'u64 ..< colCount:
          if duckdb_value_is_null(addr res, c, r):
            row.add("")
          else:
            let val = duckdb_value_varchar(addr res, c, r)
            if val != nil:
              row.add($val)
              duckdb_free(cast[pointer](val))
            else:
              row.add("")
        result.add(row)
      duckdb_destroy_result(addr res)

proc getRow*(db: DbAdapter, query: string, args: varargs[string, `$`]): seq[string] =
  let rows = db.getAllRows(query, args)
  if rows.len > 0:
    return rows[0]
  else:
    # Return empty strings matching column count (similar to db_sqlite behavior)
    return @[]

proc insertRow*(db: DbAdapter, query: string, args: varargs[string, `$`]): bool =
  case db.backend
  of backendSQLite:
    let translated = translateQuery(query, backendSQLite)
    var stmt = db.sqliteConn.prepare(translated)
    for i, arg in args:
      bindParam(stmt, i + 1, arg)
    result = db.sqliteConn.tryExec(stmt)
    finalize(stmt)
  of backendDuckDB:
    let translated = translateQuery(query, backendDuckDB)
    var stmtPtr: DuckDBPreparedStatementPtr
    let prepState = duckdb_prepare(db.duckConn, translated.cstring, addr stmtPtr)
    if prepState != DuckDBSuccess:
      let err = duckdb_prepare_error(stmtPtr)
      let errMsg = if err != nil: $err else: "unknown error"
      duckdb_destroy_prepare(addr stmtPtr)
      raise newException(DbError, "DuckDB prepare error: " & errMsg)

    for i, arg in args:
      let bindState = duckdb_bind_varchar(stmtPtr, uint64(i + 1), arg.cstring)
      if bindState != DuckDBSuccess:
        duckdb_destroy_prepare(addr stmtPtr)
        return false

    var res: DuckDBResult
    let execState = duckdb_execute_prepared(stmtPtr, addr res)
    if execState != DuckDBSuccess:
      duckdb_destroy_result(addr res)
      duckdb_destroy_prepare(addr stmtPtr)
      return false

    duckdb_destroy_result(addr res)
    duckdb_destroy_prepare(addr stmtPtr)
    return true

proc beginTransaction*(db: DbAdapter) =
  db.exec("BEGIN TRANSACTION")

proc commitTransaction*(db: DbAdapter) =
  db.exec("COMMIT")

proc quoteStr*(s: string): string =
  ## Quote a string for use in SQL (replacement for dbQuote)
  result = "'" & s.replace("'", "''") & "'"

proc createTimelinesTable*(db: DbAdapter) =
  case db.backend
  of backendSQLite:
    db.exec("""CREATE TABLE timelines (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      timestamp TEXT,
      rule_title TEXT,
      level TEXT,
      level_order INTEGER,
      computer TEXT,
      channel TEXT,
      event_id INTEGER,
      record_id TEXT,
      rule_file TEXT,
      evtx_file TEXT,
      rule_author TEXT,
      rule_modified_date TEXT,
      rule_creation_date TEXT,
      status TEXT
    )""")
  of backendDuckDB:
    db.exec("""CREATE SEQUENCE IF NOT EXISTS timelines_seq START 1""")
    db.exec("""CREATE TABLE timelines (
      id INTEGER DEFAULT nextval('timelines_seq'),
      timestamp VARCHAR,
      rule_title VARCHAR,
      level VARCHAR,
      level_order INTEGER,
      computer VARCHAR,
      channel VARCHAR,
      event_id INTEGER,
      record_id VARCHAR,
      rule_file VARCHAR,
      evtx_file VARCHAR,
      rule_author VARCHAR,
      rule_modified_date VARCHAR,
      rule_creation_date VARCHAR,
      status VARCHAR
    )""")

proc createRuleFilesTable*(db: DbAdapter) =
  case db.backend
  of backendSQLite:
    db.exec("""CREATE TABLE rule_files (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      alert_title TEXT,
      rule_path TEXT
    )""")
  of backendDuckDB:
    db.exec("""CREATE SEQUENCE IF NOT EXISTS rule_files_seq START 1""")
    db.exec("""CREATE TABLE rule_files (
      id INTEGER DEFAULT nextval('rule_files_seq'),
      alert_title VARCHAR,
      rule_path VARCHAR
    )""")

proc detectBackend*(path: string): DbBackend =
  ## Detect the database backend based on file extension
  if path.endsWith(".sqlite"):
    return backendSQLite
  else:
    return backendDuckDB

proc defaultDbExtension*(backend: DbBackend): string =
  case backend
  of backendSQLite: return ".sqlite"
  of backendDuckDB: return ".duckdb"
