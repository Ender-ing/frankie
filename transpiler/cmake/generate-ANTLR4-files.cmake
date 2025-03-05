# Bring in the required packages
find_package(antlr4-runtime REQUIRED)
find_package(antlr4-generator REQUIRED)

# Set path to generator
set(ANTLR4_JAR_LOCATION ${FRANKIE_DEPENDENCIES_ANTLR4_JAR_PATH})

# generate lexer
antlr4_generate(
    FrankieGrammarLexer
    ${FRANKIE_ANTLR4_LEXER_PATH}
    LEXER
    FALSE
    FALSE
    "frankie_parser"
)

 # generate parser
antlr4_generate(
    FrankieGrammarParser
    ${FRANKIE_ANTLR4_PARSER_PATH}
    PARSER
    FALSE
    TRUE
    "frankie_parser"
    "${ANTLR4_TOKEN_FILES_FrankieGrammarLexer}"
    "${ANTLR4_TOKEN_DIRECTORY_FrankieGrammarLexer}"
)

# add directories for generated include files
include_directories(${PROJECT_BINARY_DIR} ${ANTLR4_INCLUDE_DIR} ${ANTLR4_INCLUDE_DIR_FrankieGrammarLexer} ${ANTLR4_INCLUDE_DIR_FrankieGrammarParser})

# Check the libraries.cmake file for the remaining code!
