# Basic info
cmake_minimum_required(VERSION 3.30)
project(polar_frankie_transpiler)

# Include micros
include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/micros.cmake)

# Manage dependencies
include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/dependencies.cmake)

# C++ compiler must be 17
set(CMAKE_CXX_STANDARD 17)

# message(STATUS "Building transpiler...")
# include_directories(${ANTLR4_RUNTIME_SRC_DIR})
# add_executable(MyExecutable ${CMAKE_CURRENT_SOURCE_DIR}/source/parser/main-debug.cpp)
# target_link_libraries(MyExecutable PRIVATE ${ANTLR4_RUNTIME_SRC_DIR})

# if(NOT STATUS EQUAL 0)
#    message(FATAL_ERROR "Failed to download file: ${ERROR_MESSAGES}")
#endif()
