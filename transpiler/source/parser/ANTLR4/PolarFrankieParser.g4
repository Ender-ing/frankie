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
    : (expression (SYM_SEMICOLON | SYM_NEWLINE))* (expression? | SYM_NEWLINE*) EOF
    ; /* This is the start scope! */

// Expressions
expression
    : literal
    | statement
    | command
    | capture
    | expressions_group // TMP (remove later)
    | SYM_NEWLINE expression // Ignore extra newlines
    | expression SYM_NEWLINE // Ignore extra newlines
    // | SYM_PARENTHESIS_OPEN expression SYM_PARENTHESIS_CLOSE // Ignore superfluous parentheses
    ; /* All supported expressions */

// Groups/zones
expressions_group
    :   SYM_PARENTHESIS_OPEN
            (expression (SYM_SEMICOLON | SYM_NEWLINE))* (expression? | SYM_NEWLINE*) // Same as root:
        SYM_PARENTHESIS_CLOSE
    ; /* Parentheses grouping actually matters */

// Captures
capture_output
    :   SYM_DOLLAR SYM_PARENTHESIS_OPEN (
            command
        ) SYM_PARENTHESIS_CLOSE
    ; /* Used to capture runtime command output */
capture_script
    :   SYM_HASH SYM_PARENTHESIS_OPEN (
            command
        ) SYM_PARENTHESIS_CLOSE
    ; /* Used to capture final command script string value */
capture
    : capture_script
    | capture_output
    ; /* Command captures */

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
literal_text_escape
    : LIT_STRING_CONTENT_ESCAPED
    ; /* Text! */
literal_text_content
    : LIT_STRING_CONTENT
    ; /* Text! */
literal_text
    :   LIT_STRING_START
            (
                literal_text_content |
                literal_text_escape |
                literal_text_reference
            )*
        LIT_STRING_END
    ; /* Text! */
literal
    : literal_boolean
    | literal_number
    | literal_text
    ; /* Group all literals */

// Statements
statement
    : statement_command
    ; /* Group all statements */

// Command statement
statement_command
    : KYW_COMMAND // TMP
    ; /* "command" definition statement */

// Commands
command
    : COMMAND_IDENTIFIER // TMP
    ; /* Identify defined/runtime commands */
