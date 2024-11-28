/**
 *
 * This is the ANTLR grammar file for the PolarFrankie Lexer!
 *
 * (Fragments)
 *
**/

lexer grammar LexerFragments;

// Options
options {
    language=Cpp;
}

// Identifier naming schemes
fragment STANDARD_IDENTIFIER_CHARS_
    : [a-zA-Z0-9_-]
    ; /* All supported identifier name characters */
fragment STANDARD_IDENTIFIER_CHARS_EDGE_
    : [a-zA-Z_]
    ; /* All supported identifier name edge (start/end) characters */
fragment STANDARD_IDENTIFIER_CHARS_CONSTANTS_
    : [A-Z0-9_-]
    ; /* All supported constant identifier name characters */
fragment STANDARD_IDENTIFIER_CHARS_CONSTANTS_EDGE_
    : [A-Z_]
    ; /* All supported constant identifier name edge (start/end) characters */

// Numbers-related
fragment DIGIT_
    : [0-9]
    ; /* Digits! */

// Ignored whitespace
fragment WHITESPACE_
    : [ \t\r]
    ;

// Strings-related
fragment ESCAPE_SEQUENCE_
    : '\\' [btnfrs"\\/$]
    ; /* Escape characters */
