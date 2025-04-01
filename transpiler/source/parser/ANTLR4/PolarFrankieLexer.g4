/**
 *
 * This is the ANTLR grammar file for the PolarFrankie Lexer!
 *
 * (Only contains finalised implementations!)
 *
**/

lexer grammar PolarFrankieLexer;

// Options
options {
    language=Cpp;
}

SYM_SEMICOLON
    : ';'
    ; /* Marks the early end of a command! */
SYM_NEWLINE
    : '\n'
    ; // Newline characters need to have their own tokens!
TMP_TOKEN
    : 'meow'
    ; /* Temporary token for testing purposes! */
