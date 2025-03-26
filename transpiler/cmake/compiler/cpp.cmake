# Force PIC
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Check for C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
include(CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG("-std=c++17" CXX_17_FLAG)
CHECK_CXX_COMPILER_FLAG("-std:c++17" CXX_17_FLAG_MSVC)
if(NOT (CXX_17_FLAG OR CXX_17_FLAG_MSVC))
    message(FATAL_ERROR "[DEPENDENCIES] C++17 is not supported by the compiler. Please use a compiler that supports C++17.")
endif()

# Treat compiler warnings as errors
set(CMAKE_COMPILE_WARNING_AS_ERROR ON)

# Check for VS
# (MSVC)
#find_package(Visual Studio)
#if(MSVC)
#    message(SEND_WARNING "[DEPENDENCIES] What version of Visual Studio version do you use? (Professional/Community - default is Community):")
#    set(BUILD_VS_EDITION "Community" CACHE STRING "Professional" FORCE)
#endif()

# Make adding global C/C++ flags easier
function(add_c_cpp_global_flag flag)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${flag}")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${flag}")
endfunction()

# Make adding global compile definitions easier
function(add_global_compile_definition definition)
    get_property(targets GLOBAL PROPERTY ALL_TARGETS)
    foreach(target ${targets})
        if(TARGET ${target})
            target_compile_definitions(${target} PRIVATE ${definition})
        endif()
    endforeach()
endfunction()

include(CheckCCompilerFlag)

# Test for address sanitizer support
set(CMAKE_REQUIRED_FLAGS "-fsanitize=address")
check_c_compiler_flag("-fsanitize=address" CMAKE_CXX_SUPPORTS_FSANITIZE_ADDRESS)
# Test for undefined behavior sanitizer support
set(CMAKE_REQUIRED_FLAGS "-fsanitize=undefined")
check_c_compiler_flag("-fsanitize=undefined" CMAKE_CXX_SUPPORTS_FSANITIZE_UNDEFINED)
# Test for thread sanitizer support
set(CMAKE_REQUIRED_FLAGS "-fsanitize=thread")
check_c_compiler_flag("-fsanitize=thread" CMAKE_CXX_SUPPORTS_FSANITIZE_THREAD)
# Test for memory sanitizer support
set(CMAKE_REQUIRED_FLAGS "-fsanitize=memory")
check_c_compiler_flag("-fsanitize=memory" CMAKE_CXX_SUPPORTS_FSANITIZE_MEMORY)
# Test for leak sanitizer support
set(CMAKE_REQUIRED_FLAGS "-fsanitize=leak")
check_c_compiler_flag("-fsanitize=leak" CMAKE_CXX_SUPPORTS_FSANITIZE_LEAK)
# Test for address and undefined sanitizer support combined.
set(CMAKE_REQUIRED_FLAGS "-fsanitize=address,undefined")
check_c_compiler_flag("-fsanitize=address,undefined" CMAKE_CXX_SUPPORTS_FSANITIZE_ADDRESS_UNDEFINED)
