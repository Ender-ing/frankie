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
    : (STANDARD_IDENTIFIER_CHARS_CONSTANTS_START_) ((STANDARD_IDENTIFIER_CHARS_CONSTANTS_)* (STANDARD_IDENTIFIER_CHARS_CONSTANTS_END_))?
    ;
fragment VARIABLE_IDENTIFIER_CONTENT_
    : (STANDARD_IDENTIFIER_CHARS_START_) ((STANDARD_IDENTIFIER_CHARS_)* (STANDARD_IDENTIFIER_CHARS_END_))?
    ;
