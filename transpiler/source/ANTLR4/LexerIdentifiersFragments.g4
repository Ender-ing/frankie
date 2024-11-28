/**
 *
 * This is the ANTLR grammar file for the PolarFrankie Lexer!
 *
 * (Identifiers)
 *
**/

lexer grammar LexerIdentifiersFragments;

// Options
options {
    language=Cpp;
}

import LexerFragments;

// Value identifier names
fragment CONSTANT_IDENTIFIER_CONTENT_
    : (STANDARD_IDENTIFIER_CHARS_CONSTANTS_EDGE_) ((STANDARD_IDENTIFIER_CHARS_CONSTANTS_)* (STANDARD_IDENTIFIER_CHARS_CONSTANTS_EDGE_))?
    ;
fragment VARIABLE_IDENTIFIER_CONTENT_
    : (STANDARD_IDENTIFIER_CHARS_EDGE_) ((STANDARD_IDENTIFIER_CHARS_)* (STANDARD_IDENTIFIER_CHARS_EDGE_))?
    ;
