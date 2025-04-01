# PolarFrankie

PolarFrankie, a command line scripting metaprogramming language in the planning!

> [!NOTE]
> You can check the docs [over here](https://docs.ender.ing/docs/frankie/intro/)!

## Progress

- [x] Add a basic VSCode Extension to support highlighting
- [x] Define basic *ANTLR4* Lexer and Parser files
- [x] Add *CMake* build scripts for the transpiler
- [x] Add GitHub Workflows for the Transpiler and VSCode Extension
- [x] Add a debug function to print lexer and parser output into the console
- [x] Add a GitHub test workflow
- [x] Add a GitHub release workflow

## Binaries distribution

- [x] Portable binaries
  - [x] Windows file information integration
  - [ ] Unix-like CLI Man(ual)
- [ ] Binaries installer

## CLI support

- [x] Introduction and summary
- [ ] Flags
  - [x] `--version`
  - [ ] `--protocol`
    - [x] CLI
    - [ ] LSP
  - [ ] `--input`
    - [x] Access and extension checks
    - [ ] Format checks
  - [x] `--debug-parser-antlr-syntax-test`
  - [ ] `--help`

## Language syntax support

- [ ] Basic data and types
  - [ ] Numbers
    - [x] Basic literals
    - [ ] Mathmatical operations
    - [ ] Type casting
  - [ ] Strings
    - [x] Basic literals
    - [x] Escape characters
    - [x] Variable references
    - [ ] String manipulation
    - [ ] Type casting
  - [ ] Booleans
    - [x] Basic literals
    - [ ] Type casting
- [ ] `command` statement
- [ ] `()` expression grouping
  - [ ] Basic expression grouping
  - [ ] Output capture
  - [ ] Script capture
