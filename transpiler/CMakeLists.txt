# Basic info
cmake_minimum_required(VERSION 3.10 FATAL_ERROR)
project(polar_frankie_transpiler)
enable_testing()

# Directories
set(FRANKIE_CMAKE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
set(FRANKIE_DEPENDENCIES_DIR ${CMAKE_CURRENT_SOURCE_DIR}/dependencies)
set(FRANKIE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/source)
set(FRANKIE_TESTS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/tests)
set(FRANKIE_BINARY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/dist)
set(FRANKIE_MANIFEST_FILE ${CMAKE_CURRENT_SOURCE_DIR}/manifest.ini)

# CMake modules path
set(CMAKE_MODULE_PATH
    # CMake files folder
    ${FRANKIE_CMAKE_DIR}/ANTLR4
    ${FRANKIE_CMAKE_DIR}
    # Build folder
    ${CMAKE_BINARY_DIR}
    # Append existing paths
    ${CMAKE_MODULE_PATH}
)

# ANTLR4 files generation configuration
set(FRANKIE_ANTLR4_LEXER_PATH ${FRANKIE_SOURCE_DIR}/ANTLR4/PolarFrankieLexer.g4)
set(FRANKIE_ANTLR4_PARSER_PATH ${FRANKIE_SOURCE_DIR}/ANTLR4/PolarFrankieParser.g4)
set(FRANKIE_MAIN_CPP_PATH ${FRANKIE_SOURCE_DIR}/main.cpp)

include(FetchContent)

# Manage compiler settings
include(${FRANKIE_CMAKE_DIR}/compiler/cpp.cmake)

# Manage binary output
include(${FRANKIE_CMAKE_DIR}/build-output.cmake)

# Manage dependencies
include(${FRANKIE_CMAKE_DIR}/dependencies.cmake)

# Build the transpiler executable!
include(${FRANKIE_CMAKE_DIR}/build-executable.cmake)

# Run tests on the transpiler executable!
include(${FRANKIE_CMAKE_DIR}/test-executable.cmake)
