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
# Link other libraries to the library
target_link_libraries(comms_library PRIVATE fmt::fmt)
add_dependencies(comms_library fmt::fmt)

# Create a library from /common
add_library(common_library SHARED
    ${FRANKIE_SOURCE_DIR}/common/files.cpp
)

# Create a library from /parser
add_library(parser_library SHARED
    ${ANTLR_FrankieGrammarLexer_CXX_OUTPUTS} # ANTLR4
    ${ANTLR_FrankieGrammarParser_CXX_OUTPUTS} # ANTLR4
    ${FRANKIE_SOURCE_DIR}/parser/parser.cpp
)
# ANTLR4
target_link_libraries(parser_library PRIVATE antlr4_shared)
add_dependencies(parser_library antlr4_shared)
add_custom_command(TARGET parser_library
                   POST_BUILD
                   COMMAND ${CMAKE_COMMAND}
                           -E copy ${ANTLR4_RUNTIME_LIBRARIES} .
                   WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
# Link other libraries to the library
target_link_libraries(parser_library PUBLIC comms_library) # TMP
add_dependencies(parser_library comms_library) # TMP

# Set the project libraries
set(PROJECT_LIBRARIES
    root_library
    common_library
    comms_library
    parser_library
)
