# Basic info
cmake_minimum_required(VERSION 3.30 FATAL_ERROR)
project(polar_frankie_transpiler)

# Directories
set(FRANKIE_CMAKE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
set(FRANKIE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/source)

# Include micros
include(${FRANKIE_CMAKE_DIR}/micros.cmake)

# Manage dependencies
include(${FRANKIE_CMAKE_DIR}/dependencies.cmake)

# ANTLR4 files generation configs
# (applys to "FrankieANTLR4Parser")
set(FRANKIE_ANTLR4_LEXER_PATH ${FRANKIE_SOURCE_DIR}/ANTLR4/PolarFrankieLexer.g4)
set(FRANKIE_ANTLR4_PARSER_PATH ${FRANKIE_SOURCE_DIR}/ANTLR4/PolarFrankieParser.g4)
include(${FRANKIE_CMAKE_DIR}/ANTLR4/generate.cmake)

# Compile "FrankieANTLR4Parser" files
message(STATUS "Building ANTLR4 parser...")
add_executable(FrankieANTLR4Parser ${FRANKIE_SOURCE_DIR}/parser/main-debug.cpp)
