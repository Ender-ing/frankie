# Basic info
cmake_minimum_required(VERSION 3.10 FATAL_ERROR)
project(polar_frankie_transpiler)
enable_testing()

# Stop build when errors occur
set(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION ON)

# Directories
set(FRANKIE_BUILD_DIR ${CMAKE_BINARY_DIR})
set(FRANKIE_CMAKE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
set(FRANKIE_DEPENDENCIES_DIR ${CMAKE_CURRENT_SOURCE_DIR}/dependencies)
set(FRANKIE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/source)
set(FRANKIE_TESTS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/tests)
set(FRANKIE_BINARY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/dist)
set(FRANKIE_MANIFEST_FILE ${CMAKE_CURRENT_SOURCE_DIR}/manifest.ini)
set(FRANKIE_LICENSE_FILE ${CMAKE_CURRENT_SOURCE_DIR}/../LICENSE)

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
set(FRANKIE_ANTLR4_LEXER_PATH ${FRANKIE_SOURCE_DIR}/parser/ANTLR4/PolarFrankieLexer.g4)
set(FRANKIE_ANTLR4_PARSER_PATH ${FRANKIE_SOURCE_DIR}/parser/ANTLR4/PolarFrankieParser.g4)
set(FRANKIE_MAIN_CPP_PATH ${FRANKIE_SOURCE_DIR}/main.cpp)

include(FetchContent)

# CMake functions & macros
include(${FRANKIE_CMAKE_DIR}/utility.cmake)

# Manage compiler settings
include(${FRANKIE_CMAKE_DIR}/compiler/cpp.cmake)

# Manage binary output
include(${FRANKIE_CMAKE_DIR}/build-output.cmake)

# Manage dependencies
include(${FRANKIE_CMAKE_DIR}/dependencies.cmake)

# Build the transpiler executable!
include(${FRANKIE_CMAKE_DIR}/build-executable.cmake)

# Run tests on the transpiler executable!
option(FRANKIE_TESTS "Disable PolarFrankie custom tests" ON)
if(FRANKIE_TESTS)
    include(${FRANKIE_CMAKE_DIR}/test-executable.cmake)
else()
    message(WARNING "[TESTS] Custom tests have been disabled!")
endif()

# CMake files that are not related to the main building process
include(${FRANKIE_CMAKE_DIR}/other/other.cmake)
