# `.frankie` Tests

## Failure Expressions

You may specify failure expressions like this: `*!(<letter>...).frankie` (e.g. `myfile!s.frankie` - syntax failure)

When you expect a file test to fail, you must change the file's name to match that:

- `s`: expecting syntax checks to fail.

## Test File Naming

All `.frankie` test files are processed as main input files!
You must prefix the file name with an underscore (`_`) if you wish to exclude it from automatic testing!
