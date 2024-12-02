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

// Literals
literal_boolean
    : LIT_BOOLEAN_TRUE
    | LIT_BOOLEAN_FALSE
    ; /* Booleans! */
literal_number
    : LIT_NUMBER
    ; /* Numbers! */
literal_text_reference
    :   LIT_STRING_REFERENCE_START
            (
                LIT_STRING_REFERENCE_CONSTANT |
                LIT_STRING_REFERENCE_VARIABLE |
                LIT_STRING_REFERENCE_TYPE_CONSTANT |
                LIT_STRING_REFERENCE_TYPE_VARIABLE
            )
    ; /* Text value reference! */
literal_text_reference_end
    :   literal_text_reference
        LIT_STRING_REFERENCE_END_STRING_END // Ends with a quote (end of string)
    ; /* Text! (ends with a reference) */
literal_text_reference_typical
    :   literal_text_reference
        (
            LIT_STRING_REFERENCE_END_STRING_CONTENT | // Normal end
            LIT_STRING_REFERENCE_ESCAPE_END_STRING_CONTENT // end with an escape character!
        )
    ; /* Text! */
literal_text
    :   LIT_STRING_START
            (
                LIT_STRING_CONTENT_ESCAPED |
                LIT_STRING_CONTENT |
                literal_text_reference_typical
            )*
        (
            LIT_STRING_END | // Normal end
            literal_text_reference_end // Ends with a reference
        )
    ; /* Text! */
literals
    : literal_boolean
    | literal_number
    | literal_text
    ; /* Group all literals */
