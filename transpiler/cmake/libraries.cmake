# PIC
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Create a library from / (the root directory of /transpiler)
add_library(root_library SHARED
    ${FRANKIE_SOURCE_DIR}/config.cpp
)

# Create a library from /comms
add_library(comms_library SHARED
    ${FRANKIE_SOURCE_DIR}/comms/CLI/basic.cpp
    ${FRANKIE_SOURCE_DIR}/comms/comms.cpp
)
# Link other public libraries to the library
target_link_libraries(comms_library PRIVATE fmt::fmt)

# Create a library from /common
add_library(common_library SHARED
    ${FRANKIE_SOURCE_DIR}/common/files.cpp
)
add_dependencies(common_library comms_library) # ANTLR4

# Create a library from /parser
add_library(parser_library SHARED
    ${FRANKIE_SOURCE_DIR}/parser/parser.cpp
    ${ANTLR4_SRC_FILES_FrankieGrammarLexer} # ANTLR4
    ${ANTLR4_SRC_FILES_FrankieGrammarParser} # ANTLR4
)
# ANTLR4
target_link_libraries(parser_library PRIVATE antlr4_shared)
add_dependencies(parser_library antlr4_shared)
add_custom_command(TARGET parser_library
                   POST_BUILD
                   COMMAND ${CMAKE_COMMAND}
                           -E copy ${ANTLR4_RUNTIME_LIBRARIES} .
                   WORKING_DIRECTORY ${FRANKIE_BINARY_DIR}/bin)

# Set the project libraries
set(PROJECT_LIBRARIES
    root_library
    common_library
    comms_library
    parser_library
)
