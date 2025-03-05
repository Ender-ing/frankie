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
target_link_libraries(comms_library PUBLIC fmt::fmt)
add_dependencies(comms_library fmt::fmt)

# Create a library from /common
add_library(common_library SHARED
    ${FRANKIE_SOURCE_DIR}/common/files.cpp
)



GET_TARGET_PROPERTY(library_type antlr4_shared TYPE)
GET_TARGET_PROPERTY(library_suffix antlr4_shared SUFFIX)
GET_TARGET_PROPERTY(library_imported antlr4_shared IMPORTED)
message(STATUS "antlr4_shared type: ${library_type}")
message(STATUS "antlr4_shared suffix: ${library_suffix}")
message(STATUS "antlr4_shared imported: ${library_imported}")
GET_TARGET_PROPERTY(library_type_1 comms_library TYPE)
GET_TARGET_PROPERTY(library_suffix_1 comms_library SUFFIX)
GET_TARGET_PROPERTY(library_imported_1 comms_library IMPORTED)
message(STATUS "comms_library type: ${library_type_1}")
message(STATUS "comms_library suffix: ${library_suffix_1}")
message(STATUS "comms_library imported: ${library_imported_1}")



# Create a library from /parser
add_library(parser_library SHARED
    ${ANTLR_FrankieGrammarLexer_CXX_OUTPUTS} # ANTLR4
    ${ANTLR_FrankieGrammarParser_CXX_OUTPUTS} # ANTLR4
    ${FRANKIE_SOURCE_DIR}/parser/parser.cpp
)
# ANTLR4
target_link_libraries(parser_library PUBLIC antlr4_shared)
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
