/**
 *
 * This is the ANTLR grammar file for the PolarFrankie Lexer!
 *
 * (Built-in keywords!)
 *
**/

lexer grammar LexerKeywords;

// Libraries and related elements
KYW_IMPORT
    : 'import'
    ; /* Used to import libraries */
KYW_FROM
    : 'from'
    ; /* Used to import libraries */
KYW_GROUP
    : 'group'
    ; /* Used to specify used namespace elements */
KYW_USE
    : 'use'
    ; /* Used to specify used library elements */


// Declarative keywords
KYW_TYPE
    : 'type'
    ; /* Used to define action types (not values, actions) */
KYW_COMMAND
    : 'command'
    ; /* Used to'define commands! */
KYW_FUNCTION
    : 'function'
    ; /* Used to define functions! */
KYW_RULE
    : 'rule'
    ; /* Used to define rule functions! */

// Generative keywords
KYW_BASH
    : 'bash'
    ; /* Used to contain Linux/Bash command syntax */
KYW_BATCH
    : 'batch'
    ; /* Used to contain Windows/Batch command syntax */

// Logic flow keywords
KYW_IF
    : 'if'
    ; /* Used to define an if statement! */
KYW_ELSE
    : 'else'
    ; /* Used to define an else statement! */
KYW_RETURN
    : 'return'
    ; /* Used to return a function value! */
