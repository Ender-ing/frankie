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
    ${FRANKIE_SOURCE_DIR}/comms/CLI/report.cpp
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
# Libraries
if(WIN32)
    set(ANTLR4_DYNAMIC_LIBRARY_COPY_NAME ${ANTLR4_RUNTIME_LIBRARIES})
elseif(CMAKE_SYSTEM_NAME MATCHES "Darwin")
    set(ANTLR4_DYNAMIC_LIBRARY_COPY_NAME ${ANTLR4_OUTPUT_DIR}/*.${ANTLR4_TAG}.dylib)
    # Fix macOS linking issue (POST BUILD)
    set(ANTLR4_DYNAMIC_LIBRARY_MACOS_NAME libantlr4-runtime.${ANTLR4_TAG}.dylib)
    add_custom_command(
        TARGET FrankieTranspiler # This will run AFTER the file is copied!
        POST_BUILD
        COMMAND install_name_tool -id "@rpath/libantlr4-runtime.${ANTLR4_TAG}.dylib" ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${ANTLR4_DYNAMIC_LIBRARY_MACOS_NAME}
    )
elseif(CMAKE_SYSTEM_NAME MATCHES "Linux")
    set(ANTLR4_DYNAMIC_LIBRARY_COPY_NAME ${ANTLR4_OUTPUT_DIR}/*.so.${ANTLR4_TAG})
endif()
add_custom_command(TARGET FrankieParserLibrary
                    POST_BUILD
                    COMMAND ${CMAKE_COMMAND}
                           -E copy ${ANTLR4_DYNAMIC_LIBRARY_COPY_NAME} .
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
