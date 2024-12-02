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
TYPE_CONSTANT_IDENTIFIER
    : '$' '$' CONSTANT_IDENTIFIER_CONTENT_
    ; /* All type-related constant identifiers must start with double dollar ($$) signs and not include small letters! */
CONSTANT_IDENTIFIER
    : '$' CONSTANT_IDENTIFIER_CONTENT_
    ; /* All constant identifiers must start with a dollar ($) sign and not include small letters! */
TYPE_VARIABLE_IDENTIFIER
    : '$' '$' VARIABLE_IDENTIFIER_CONTENT_
    ; /* All type-related variable identifiers must start with double dollar ($$) signs! */
VARIABLE_IDENTIFIER
    : '$' VARIABLE_IDENTIFIER_CONTENT_
    ; /* All variable identifiers must start with a dollar ($) sign! */
LONG_FLAG_IDENTIFIER
    : '%' '%' VARIABLE_IDENTIFIER_CONTENT_
    ; /* All flag identifiers must start with a percentage (%) character! */
FLAG_IDENTIFIER
    : '%' VARIABLE_IDENTIFIER_CONTENT_
    ; /* All flag identifiers must start with a percentage (%) character! */
INPUT_IDENTIFIER
    : '^' VARIABLE_IDENTIFIER_CONTENT_
    ; /* All input identifiers must start with a (^caret) character! */
TYPE_IDENTIFIER
    : [A-Z] ((STANDARD_IDENTIFIER_CHARS_)* (STANDARD_IDENTIFIER_CHARS_END_))?
    ; /* All type identifiers must start with a capital letter! */
COMMAND_IDENTIFIER
    : [a-z_] ((STANDARD_IDENTIFIER_CHARS_)* (STANDARD_IDENTIFIER_CHARS_END_))?
    ; /* All type command identifiers must start with either a small letter or an underscore! */
