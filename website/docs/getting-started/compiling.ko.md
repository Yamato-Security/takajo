# 고급: 소스에서 컴파일하기 (선택 사항)

먼저, [choosenim](https://github.com/nim-lang/choosenim)으로 Nim을 설치합니다.
또한 컴파일 시 DuckDB C 라이브러리가 필요하므로 DuckDB도 설치해야 합니다 ([요구 사항](index.md#requirements) 참조).
그런 다음 아래 명령으로 소스에서 컴파일할 수 있습니다:

```
> nimble update
> nimble build -d:release --threads:on
```
