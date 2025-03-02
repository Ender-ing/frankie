# Create a static library from / (the root directory of /transpiler)
add_library(static_root_library STATIC
    ${FRANKIE_SOURCE_DIR}/config.cpp
)

# Create a static library from /common
add_library(static_common_library STATIC
    ${FRANKIE_SOURCE_DIR}/common/files.cpp
)

# Create a static library from /comms
add_library(static_comms_library STATIC
    ${FRANKIE_SOURCE_DIR}/comms/comms.cpp
)

# Create a static library from /parser
add_library(static_parser_library STATIC
    ${ANTLR_FrankieGrammarLexer_CXX_OUTPUTS} # ANTLR4
    ${ANTLR_FrankieGrammarParser_CXX_OUTPUTS} # ANTLR4
    ${FRANKIE_SOURCE_DIR}/parser/parser.cpp
)

# Set the project static libraries
set(PROJECT_STATIC_LIBRARIES
    static_root_library
    static_common_library
    static_comms_library
    static_parser_library
)
