/**
 *
 * This is the ANTLR grammar file for PolarFrankie!
 * All syntax and parser rules are defined here.
 *
 * (Only contains finalised implementations!)
 *
 * (ANTLR4: https://github.com/antlr/antlr4/blob/master/doc/lexicon.md#keywords)
 *
**/

parser grammar PolarFrankieParser;

// Manage options
options {
    tokenVocab=PolarFrankieLexer;
    language=Cpp;
}

//// Parser Rules

root
    : expression_full* EOF
    ; /* This is the start scope! */

// Expressions
expression
    : literals
    | expressions_group
    ; /* All supported expressions */
expression_end
    : SYM_SEMICOLON |
    | SYM_NEWLINE // New lines do matter!
    ; /* Expression end markers */
expression_full
    : expression expression_end
    ; /* Full expressions */

// Groups/zones
expressions_group
    :   SYM_PARENTHESIS_OPEN // Open
            expression_full* // All expressions are allowed here!
        SYM_PARENTHESIS_CLOSE // Close
    ; /* Parentheses grouping actually matters */
output_capture_expressions_group
    : SYM_DOLLAR
        expressions_group
    ; /* Used to capture command output values inside a zone */
script_capture_expressions_group
    : SYM_HASHTAG
        expressions_group
    ; /* Used to capture final command script string values inside a zone */
command_element_expressions_group
    : SYM_ASTERISK
        SYM_PARENTHESIS_OPEN
            // command_element_expression_full* // Only command element definitions are allowed in here!
        SYM_PARENTHESIS_CLOSE
    ; /* Used to group command definition elements */

// Literals
literal_boolean
    : LIT_BOOLEAN_TRUE
    | LIT_BOOLEAN_FALSE
    ; /* Booleans! */
literal_number
    : LIT_NUMBER
    ; /* Numbers! */
literal_text_reference
    : LIT_STRING_REFERENCE_CONSTANT
    | LIT_STRING_REFERENCE_VARIABLE
    | LIT_STRING_REFERENCE_TYPE_CONSTANT
    | LIT_STRING_REFERENCE_TYPE_VARIABLE
    ; /* Text value reference! */
literal_text_content
    : LIT_STRING_CONTENT_ESCAPED
    | LIT_STRING_CONTENT
    ; /* Text! */
literal_text
    :   LIT_STRING_START
            (
                literal_text_content |
                literal_text_reference
            )*
        LIT_STRING_END
    ; /* Text! */
literals
    : literal_boolean
    | literal_number
    | literal_text
    ; /* Group all literals */
