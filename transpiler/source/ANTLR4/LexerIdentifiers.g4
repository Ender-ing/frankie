/**
 *
 * This is the ANTLR grammar file for the PolarFrankie Lexer!
 *
 * (Identifiers)
 *
**/

lexer grammar LexerIdentifiers;

// Options
options {
    language=Cpp;
}

import LexerFragments, LexerIdentifiersFragments;

// Identifiers
// Identifiers cannot start/end with a dash!
FUNCTION_IDENTIFIER
    : '@' VARIABLE_IDENTIFIER_CONTENT_
    ; /* All function identifiers must start with an at (@) sign! */
CONSTANT_IDENTIFIER
    : '$' '$'? CONSTANT_IDENTIFIER_CONTENT_
    ; /* All constant identifiers must start with a dollar ($) sign and not include small letters! */
VARIABLE_IDENTIFIER
    : '$' '$'? VARIABLE_IDENTIFIER_CONTENT_
    ; /* All variable identifiers must start with a dollar ($) sign! */
FLAG_IDENTIFIER
    : '%' '%'? VARIABLE_IDENTIFIER_CONTENT_
    ; /* All flag identifiers must start with a percentage (%) character! */
INPUT_IDENTIFIER
    : '^' VARIABLE_IDENTIFIER_CONTENT_
    ; /* All input identifiers must start with a (^caret) character! */
TYPE_IDENTIFIER
    : [A-Z] ((STANDARD_IDENTIFIER_CHARS_)* (STANDARD_IDENTIFIER_CHARS_EDGE_))?
    ; /* All type identifiers must start with a capital letter! */
COMMAND_IDENTIFIER
    : [a-z_] ((STANDARD_IDENTIFIER_CHARS_)* (STANDARD_IDENTIFIER_CHARS_EDGE_))?
    ; /* All type command identifiers must start with either a small letter or an underscore! */
