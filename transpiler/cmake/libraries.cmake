# PIC
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(BUILD_SHARED_LIBS ON)

# Create a library from / (the root directory of /transpiler)
add_library(root_library SHARED
    ${FRANKIE_SOURCE_DIR}/config.cpp
)
# Expose library exports
target_compile_definitions(root_library PUBLIC BUILD_DYNAMIC_LIBRARY)

# Create a library from /comms
add_library(comms_library SHARED
    ${FRANKIE_SOURCE_DIR}/comms/CLI/basic.cpp
    ${FRANKIE_SOURCE_DIR}/comms/comms.cpp
)
# Expose library exports
target_compile_definitions(comms_library PUBLIC BUILD_DYNAMIC_LIBRARY)
# Link other libraries to the library
add_dependencies(comms_library fmt::fmt)
target_link_libraries(comms_library PUBLIC fmt::fmt)

# Create a library from /common
add_library(common_library SHARED
    ${FRANKIE_SOURCE_DIR}/common/files.cpp
)
# Expose library exports
target_compile_definitions(common_library PUBLIC BUILD_DYNAMIC_LIBRARY)

# Create a library from /parser
add_library(parser_library SHARED
    ${ANTLR_FrankieGrammarLexer_CXX_OUTPUTS} # ANTLR4
    ${ANTLR_FrankieGrammarParser_CXX_OUTPUTS} # ANTLR4
    ${FRANKIE_SOURCE_DIR}/parser/parser.cpp
)
# Expose library exports
target_compile_definitions(parser_library PUBLIC BUILD_DYNAMIC_LIBRARY)
# ANTLR4
add_dependencies(parser_library antlr4_shared)
target_link_libraries(parser_library PUBLIC antlr4_shared)
add_custom_command(TARGET parser_library
                   POST_BUILD
                   COMMAND ${CMAKE_COMMAND}
                           -E copy ${ANTLR4_RUNTIME_LIBRARIES} .
                   WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
# Link other libraries to the library
add_dependencies(parser_library comms_library) # TMP
target_link_libraries(parser_library PUBLIC comms_library) # TMP

# Set the project libraries
set(PROJECT_LIBRARIES
    root_library
    common_library
    comms_library
    parser_library
)
