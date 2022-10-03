# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest
import std/tables

import takajopkg/submodule
test "csv file path import":
  let expect_content = """rule_path
  test1.yml
  test2.yml
  test3.yml
  """
  let expect_table = newTable[string, seq[string]]()
  expect_table["no_data"] = @[
    "",
    "",
    ""
  ]
  expect_table["part_space"] = @[
    "space_1",
    "",
    "space_3"
  ]
  expect_table["rule_path"] = @[
    "test1.yml",
    "test2.yml",
    "test3.yml"
  ]
  writeFile("temp.csv", expect_content)
  check getHayabusaCsvData("./tests/data/1.csv", "no_data") == expect_table
  check getHayabusaCsvData("./tests/data/1.csv", "part_space") == expect_table
  check getHayabusaCsvData("./tests/data/1.csv", "rule_path") == expect_table

test "check getYMLLists":
  let expect = @["1.yml"]
  check getTargetExtFileLists("./tests", ".yml") == expect
