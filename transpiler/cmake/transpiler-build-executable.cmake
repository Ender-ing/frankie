# Generate ANTLR4 grammar C++ files
include(${FRANKIE_CMAKE_DIR}/generateANTLR4Files.cmake)

# Add generated grammar to binary target
add_executable(FrankieTranspiler ${FRANKIE_MAIN_CPP_PATH}
               ${ANTLR_FrankieGrammarLexer_CXX_OUTPUTS}
               ${ANTLR_FrankieGrammarParser_CXX_OUTPUTS})
target_link_libraries(FrankieTranspiler antlr4_static)
