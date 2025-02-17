cmake_minimum_required(VERSION 3.31)
project(polar_frankie_transpiler)

# Run the generated ANTLR4 C++ code
add_executable(polar_frankie_transpiler source/parser/main-debug.cpp)
