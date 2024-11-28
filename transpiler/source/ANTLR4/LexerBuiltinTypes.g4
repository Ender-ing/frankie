/**
 *
 * This is the ANTLR grammar file for the PolarFrankie Lexer!
 *
 * (Built-in types)
 *
**/

lexer grammar LexerBuiltinTypes;

// Options
options {
    language=Cpp;
}

// Built-in types
TYPE_NUMBER
    : 'NUMBER'
    ;
TYPE_TEXT
    : 'TEXT'
    ;
TYPE_BOOLEAN
    : 'BOOLEAN'
    ;
TYPE_ANY
    : 'ANY'
    ;
TYPE_NONE
    : 'NONE'
    ;
