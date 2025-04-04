/**
 *
 * This is the ANTLR grammar file for the PolarFrankie Lexer!
 *
 * (Symbols)
 *
**/

lexer grammar LexerSymbols;

// Options
options {
    language=Cpp;
}

// New lines
SYM_NEWLINE
    : ('\r'? '\n')+
    ; // Newline characters need to have their own tokens!

// Expression-related symbols
SYM_PARENTHESIS_OPEN
    : '('
    ; /* Marks the start of a group/zone */
SYM_PARENTHESIS_CLOSE
    : ')'
    ; /* Marks the end of a group/zone */
SYM_SEMICOLON
    : ';'
    ; /* Marks the early end of a command! */
SYM_DOLLAR
    : '$'
    ; /* Marks the start of a command output capture! */
SYM_HASH
    : '#'
    ; /* Marks the start of a command script capture! */
