# Generate ANTLR4 grammar C++ files
include(${FRANKIE_CMAKE_DIR}/generate-ANTLR4-files.cmake)

# Add executable and include relevant files
add_executable(
    FrankieTranspiler ${FRANKIE_MAIN_CPP_PATH}
    ${ANTLR_FrankieGrammarLexer_CXX_OUTPUTS} # ANTLR4
    ${ANTLR_FrankieGrammarParser_CXX_OUTPUTS} # ANTLR4
    )

# Link C++ libraries
# {fmt}
target_link_libraries(FrankieTranspiler fmt::fmt)
# ANTLR4
target_link_libraries(FrankieTranspiler antlr4_static)
