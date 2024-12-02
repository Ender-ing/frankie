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
    | statements
    | expressions_group
    ; /* All supported expressions */
expression_end
    : SYM_SEMICOLON |
    | SYM_NEWLINE // New lines do matter!
    ; /* Expression end markers */
expression_full
    : expression expression_end
    ; /* Full expressions */
command_element_expression_full
    :  command_element_expression expression_end
    ; /* Command definition full expressions */

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
    : command_element_expressions_mandatory_group
    | command_element_expressions_optional_group
    ; /* Used to group all command definition elements */

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

// Commands
// command --flag -f "input" 12

// Statements
statements
    : command_statement
    ; /* Group all statements */

// Command statement
command_targets
    :   KYW_BASH expressions_group KYW_BATCH expressions_group // Bash/Linux, Batch/Windows
    |   KYW_BATCH expressions_group KYW_BASH expressions_group // Batch/Windows, Bash/Linux
    ; /* Targets for commands! */
command_statement
    : KYW_COMMAND literal_text command_element_expressions_group* command_targets KYW_DEFAULT command_type_identifier
    ; /* "command" definition statement */
command_flag_optional_definition
    : short_flag_idenitifer long_flag_idenitifer SYM_QUESTION_MARK data_constant_idenitifer
    ; /* Flags definition */
command_flag_definition
    : short_flag_idenitifer long_flag_idenitifer data_constant_idenitifer
    ; /* Flags definition */
command_input_optional_definition
    : data_type_selector SYM_QUESTION_MARK data_constant_idenitifer
    ; /* Input definition */
command_input_definition
    : data_type_selector data_constant_idenitifer
    ; /* Input definition */
command_element_expression
    : command_flag_definition // Flag
    | command_flag_optional_definition // Optional flag
    | command_input_definition // Input
    | command_input_optional_definition // Optional input
    ; /* Command definition expressions */
command_element_expressions_mandatory_group
    : SYM_ASTERISK
        SYM_PARENTHESIS_OPEN
            command_element_expression_full+ // Only command element definitions are allowed in here!
        SYM_PARENTHESIS_CLOSE
    ; /* Used to group command definition elements */
command_element_expressions_optional_group
    : SYM_QUESTION_MARK SYM_ASTERISK
        SYM_PARENTHESIS_OPEN
            command_element_expression_full+ // Only command element definitions are allowed in here!
        SYM_PARENTHESIS_CLOSE
    ; /* Used to define an optional command elements group */

// Data types
data_type_selector
    : data_type_identifier
        (SYM_PIPE data_type_identifier)*
    ; /* Data type selector (only for built-in data types) */

// Idenitifers
command_constant_identifier
    : TYPE_CONSTANT_IDENTIFIER
    ; /* Command type constants */
data_constant_idenitifer
    : CONSTANT_IDENTIFIER
    ; /* Data/user constants */
constant_identifier
    : command_constant_identifier
    | data_constant_idenitifer
    ; /* Group constant identifiers */
short_flag_idenitifer
    : FLAG_IDENTIFIER
    ; /* Short flags */
long_flag_idenitifer
    : LONG_FLAG_IDENTIFIER
    ; /* Long flags */
flag_idenitifers
    : short_flag_idenitifer
    | long_flag_idenitifer
    ; /* Group all flag idenitifer */
command_type_identifier
    : TYPE_IDENTIFIER
    ; /* Command type identifiers */
data_type_identifier
    : TYPE_NUMBER
    | TYPE_TEXT
    | TYPE_COMMAND
    | TYPE_BOOLEAN
    | TYPE_ANY
    ; /* Data type identifiers */
no_type_identifier
    : TYPE_NONE
    ; /* No-type identifier */

/*RULE_IDENTIFIER
FUNCTION_IDENTIFIER
TYPE_CONSTANT_IDENTIFIER
CONSTANT_IDENTIFIER
TYPE_VARIABLE_IDENTIFIER
VARIABLE_IDENTIFIER
INPUT_IDENTIFIER
TYPE_IDENTIFIER
COMMAND_IDENTIFIER*/
