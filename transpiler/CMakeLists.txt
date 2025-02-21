# Basic info
cmake_minimum_required(VERSION 3.10 FATAL_ERROR)
project(polar_frankie_transpiler)

# Directories
set(FRANKIE_CMAKE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
set(FRANKIE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/source)

# CMake modules path
set(CMAKE_MODULE_PATH
    # CMake files folder
    ${FRANKIE_CMAKE_DIR}
    # Append existing paths
    ${CMAKE_MODULE_PATH}
)

# Include functions/micros
include(${FRANKIE_CMAKE_DIR}/transpiler-build-extra.cmake)

# Manage dependencies
include(${FRANKIE_CMAKE_DIR}/transpiler-build-dependencies.cmake)

# ANTLR4 files generation configuration
set(FRANKIE_ANTLR4_LEXER_PATH ${FRANKIE_SOURCE_DIR}/ANTLR4/PolarFrankieLexer.g4)
set(FRANKIE_ANTLR4_PARSER_PATH ${FRANKIE_SOURCE_DIR}/ANTLR4/PolarFrankieParser.g4)
set(FRANKIE_MAIN_CPP_PATH ${FRANKIE_SOURCE_DIR}/parser/parser.cpp)

# Build executable!
include(${FRANKIE_CMAKE_DIR}/transpiler-build-executable.cmake)
