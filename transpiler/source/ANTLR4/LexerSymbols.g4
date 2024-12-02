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
    : [\n]
            -> channel(HIDDEN)
    ; // Newline characters need to have their own tokens!

// Maths Symbols
SYM_ASTERISK
    : '*'
    ; /* Used to operate on some primitive types, and to mark command element groups! */
/*SYM_PLUS
    : '+'
    ; /* Used to operate on some primitive types! *\/
SYM_MINUS
    : '-'
    ; /* Used to operate on some primitive types! *\/
SYM_DOUBLE_FORWARD_SLASH
    : '//'
    ; /* Floor division, used to operate on some primitive types! *\/
SYM_FORWARD_SLASH
    : '/'
    ; /* Used to operate on some primitive types! *\/
SYM_MODULO
    : '%'
    ; /* Used to operate on some primitive types! *\/
SYM_DOUBLE_CARET
    : '^^'
    ; /* Square operation, used to operate on some primitive types! *\/
SYM_CARET
    : '^'
    ; /* Used to operate on some primitive types! *\/
*/

// Code logic symbols
SYM_QUESTION_EQUAL
    : '?='
    ; /* Loose value assignment */
SYM_QUESTION_MARK
    : '?'
    ; /* Used for loose assignment/types, or optional arguments */
SYM_EQUAL
    : '='
    ; /* Value assignment */
SYM_PARENTHESIS_OPEN
    : '('
    ; /* Marks the start of a group/zone */
SYM_PARENTHESIS_CLOSE
    : ')'
    ; /* Marks the end of a group/zone */
SYM_SEMICOLON
    : ';'
    ; /* Marks the early end of a command! */
SYM_COLON
    : ':'
    ; /* Marks the end of a group/namespace reference */
SYM_DOLLAR
    : '$'
    ; /* Marks output capture groups */
SYM_HASHTAG
    : '#'
    ; /* Marks script capture groups and command element strings */

/*SYM_COMMA
    : ','
    ;
SYM_DOT
    : '.'
    ;
SYM_QUOTE_SINGLE
    : '\''
    ;
SYM_QUOTE_DOUBLE
    : '"'
    ;
SYM_BACKTICK
    : '`'
    ;*/
