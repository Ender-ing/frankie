# PIC
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(BUILD_SHARED_LIBS ON)

# Files search
function(target_sources_search TARGET FILE_PATHS IS_RECURSIVE)
    # Choose search type
    if(IS_RECURSIVE)
        file(GLOB_RECURSE SEARCH_FILES ${FILE_PATHS})
    else()
        file(GLOB SEARCH_FILES ${FILE_PATHS})
    endif()
    # Add files to the target's sources
    foreach(file_path ${SEARCH_FILES})
        message(STATUS "[BUILD] Adding '${TARGET}' target source: '${file_path}'")
        target_sources(${TARGET}
            PRIVATE
            ${file_path}
        )
    endforeach()
endfunction()

# Create a library from / (the root directory of /transpiler)
add_library(FrankieBaseLibrary SHARED)
target_sources_search(FrankieBaseLibrary ${FRANKIE_SOURCE_DIR}/*.base.cpp FALSE)
# Expose library exports
target_compile_definitions(FrankieBaseLibrary PRIVATE FRANKIEBASELIBRARY_EXPORTS)
# Attach manifest data
attach_manifest_data(FrankieBaseLibrary)
# Add compiler flags
add_internal_target_cxx_flags(FrankieBaseLibrary)
# Link other libraries to the library
add_dependencies(FrankieBaseLibrary FrankieCommonLibrary)
target_link_libraries(FrankieBaseLibrary PUBLIC FrankieCommonLibrary)
add_dependencies(FrankieBaseLibrary FrankieCommsLibrary)
target_link_libraries(FrankieBaseLibrary PUBLIC FrankieCommsLibrary)

# Create a library from /comms
add_library(FrankieCommsLibrary SHARED)
target_sources_search(FrankieCommsLibrary ${FRANKIE_SOURCE_DIR}/comms/*.cpp TRUE)
# Expose library exports
target_compile_definitions(FrankieCommsLibrary PRIVATE FRANKIECOMMSLIBRARY_EXPORTS)
# Attach manifest data
attach_manifest_data(FrankieCommsLibrary)
# Add compiler flags
add_internal_target_cxx_flags(FrankieCommsLibrary)
# Link other libraries to the library
add_dependencies(FrankieCommsLibrary fmt::fmt)
target_link_libraries(FrankieCommsLibrary PUBLIC fmt::fmt)

# Create a library from /common
add_library(FrankieCommonLibrary SHARED)
target_sources_search(FrankieCommonLibrary ${FRANKIE_SOURCE_DIR}/common/*.cpp TRUE)
# Expose library exports
target_compile_definitions(FrankieCommonLibrary PRIVATE FRANKIECOMMONLIBRARY_EXPORTS)
# Attach manifest data
attach_manifest_data(FrankieCommonLibrary)
# Add compiler flags
add_internal_target_cxx_flags(FrankieCommonLibrary)

# Create a library from /parser
add_library(FrankieParserLibrary SHARED
    ${ANTLR_FrankieGrammarLexer_CXX_OUTPUTS} # ANTLR4
    ${ANTLR_FrankieGrammarParser_CXX_OUTPUTS} # ANTLR4
)
target_sources_search(FrankieParserLibrary ${FRANKIE_SOURCE_DIR}/parser/*.cpp TRUE)
# Expose library exports
target_compile_definitions(FrankieParserLibrary PRIVATE FRANKIEPARSERLIBRARY_EXPORTS)
# Attach manifest data
attach_manifest_data(FrankieParserLibrary)
# Add compiler flags
#add_internal_target_cxx_flags(FrankieParserLibrary) # MUST FIX THE GRAMMAR FILES!
# ANTLR4
add_dependencies(FrankieParserLibrary antlr4_shared)
target_link_libraries(FrankieParserLibrary PUBLIC antlr4_shared)
# Libraries
if(WIN32)
    set(ANTLR4_DYNAMIC_LIBRARY_COPY_NAME ${ANTLR4_RUNTIME_LIBRARIES})
elseif(CMAKE_SYSTEM_NAME MATCHES "Darwin")
    set(ANTLR4_DYNAMIC_LIBRARY_COPY_NAME ${ANTLR4_OUTPUT_DIR}/*.${ANTLR4_TAG}.dylib)
elseif(CMAKE_SYSTEM_NAME MATCHES "Linux")
    set(ANTLR4_DYNAMIC_LIBRARY_COPY_NAME ${ANTLR4_OUTPUT_DIR}/*.so.${ANTLR4_TAG})
endif()
add_custom_command(TARGET FrankieParserLibrary
                    POST_BUILD
                    COMMAND ${CMAKE_COMMAND}
                           -E copy ${ANTLR4_DYNAMIC_LIBRARY_COPY_NAME} .
                    WORKING_DIRECTORY ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
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
