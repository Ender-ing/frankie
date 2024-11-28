/**
 *
 * This is the ANTLR grammar file for the PolarFrankie Lexer!
 *
 * (Comments and whitespace!)
 *
**/

lexer grammar LexerIgnores;

// Options
options {
    language=Cpp;
}

import LexerFragments;

// Whitespace
CHARS_IGNORE_LIST
    : WHITESPACE_
            -> channel(HIDDEN)
    ;

// Comments
COMMENT_BLOCK
    : ';;?' .*? '?;;'
            -> channel(HIDDEN)
    ; /* Multilinear comments are never processed for code generation */
COMMENT_LINE
    : ';;' ~[\n]* [\n]
            -> channel(HIDDEN)
    ; /* Comments end when a new line starts! */
