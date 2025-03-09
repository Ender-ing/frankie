# PIC
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(BUILD_SHARED_LIBS ON)

# Create a library from / (the root directory of /transpiler)
add_library(FrankieBaseLibrary SHARED
    ${FRANKIE_SOURCE_DIR}/actions.cpp
    ${FRANKIE_SOURCE_DIR}/config.cpp
)
# Expose library exports
target_compile_definitions(FrankieBaseLibrary PRIVATE FRANKIEBASELIBRARY_EXPORTS)
# Link other libraries to the library
add_dependencies(FrankieBaseLibrary FrankieCommonLibrary)
target_link_libraries(FrankieBaseLibrary PUBLIC FrankieCommonLibrary)

# Create a library from /comms
add_library(FrankieCommsLibrary SHARED
    ${FRANKIE_SOURCE_DIR}/comms/CLI/basic.cpp
    ${FRANKIE_SOURCE_DIR}/comms/comms.cpp
)
# Expose library exports
target_compile_definitions(FrankieCommsLibrary PRIVATE FRANKIECOMMSLIBRARY_EXPORTS)
# Link other libraries to the library
add_dependencies(FrankieCommsLibrary fmt::fmt)
target_link_libraries(FrankieCommsLibrary PUBLIC fmt::fmt)

# Create a library from /common
add_library(FrankieCommonLibrary SHARED
    ${FRANKIE_SOURCE_DIR}/common/debug.cpp
    ${FRANKIE_SOURCE_DIR}/common/files.cpp
    ${FRANKIE_SOURCE_DIR}/common/strings.cpp
)
# Expose library exports
target_compile_definitions(FrankieCommonLibrary PRIVATE FRANKIECOMMONLIBRARY_EXPORTS)

# Create a library from /parser
add_library(FrankieParserLibrary SHARED
    ${ANTLR_FrankieGrammarLexer_CXX_OUTPUTS} # ANTLR4
    ${ANTLR_FrankieGrammarParser_CXX_OUTPUTS} # ANTLR4
    ${FRANKIE_SOURCE_DIR}/parser/parser.cpp
)
# Expose library exports
target_compile_definitions(FrankieParserLibrary PRIVATE FRANKIEPARSERLIBRARY_EXPORTS)
# ANTLR4
add_dependencies(FrankieParserLibrary antlr4_shared)
target_link_libraries(FrankieParserLibrary PUBLIC antlr4_shared)
add_custom_command(TARGET FrankieParserLibrary
                   POST_BUILD
                   COMMAND ${CMAKE_COMMAND}
                           -E copy ${ANTLR4_RUNTIME_LIBRARIES} .
                   WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
# Link other libraries to the library
add_dependencies(FrankieParserLibrary FrankieCommsLibrary) # TMP
target_link_libraries(FrankieParserLibrary PUBLIC FrankieCommsLibrary) # TMP

# Set the project libraries
set(PROJECT_LIBRARIES
    FrankieBaseLibrary
    FrankieCommonLibrary
    FrankieCommsLibrary
    FrankieParserLibrary
)
