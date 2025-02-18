# Find antlr4 packages
find_package(antlr4-runtime REQUIRED)
find_package(antlr4-generator REQUIRED)

# Set path to generator
set(ANTLR4_JAR_LOCATION ${FRANKIE_DEPENDENCIES_ANTLR4_JAR_PATH})

# generate lexer
antlr4_generate(
    antlrcpp_lexer
    ${FRANKIE_ANTLR4_LEXER_PATH}
    LEXER
    FALSE
    FALSE
)

# generate parser
antlr4_generate(
    antlrcpp_parser
    ${FRANKIE_ANTLR4_PARSER_PATH}
    PARSER
    FALSE
    TRUE
)

# add directories for generated include files
include_directories(${PROJECT_BINARY_DIR} ${ANTLR4_INCLUDE_DIR} ${ANTLR4_INCLUDE_DIR_antlrcpp_lexer} ${ANTLR4_INCLUDE_DIR_antlrcpp_parser})

# add generated source files
add_executable(FrankieANTLR4Parser main.cpp ${ANTLR4_SRC_FILES_antlrcpp_lexer} ${ANTLR4_SRC_FILES_antlrcpp_parser})

# add required runtime library
add_dependencies(FrankieANTLR4Parser antlr4_shared)

target_link_libraries(FrankieANTLR4Parser PRIVATE antlr4_shared)
