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
    : (expression expression_end)* EOF
    ; /* This is the start scope! */

// Expressions
expression
    : TMP_TOKEN
    ; /* All supported expressions */
expression_end
    : SYM_SEMICOLON |
    | SYM_NEWLINE // New lines do matter!
    ; /* Expression end markers */
