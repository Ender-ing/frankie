include(CheckCCompilerFlag)

# Test for address sanitizer support
set(CMAKE_REQUIRED_FLAGS "-fsanitize=address")
check_c_compiler_flag("-fsanitize=address" CPP_COMPILER_SUPPORTS_FSANITIZE_ADDRESS)
# Test for undefined behavior sanitizer support
set(CMAKE_REQUIRED_FLAGS "-fsanitize=undefined")
check_c_compiler_flag("-fsanitize=undefined" CPP_COMPILER_SUPPORTS_FSANITIZE_UNDEFINED)
# Test for thread sanitizer support
set(CMAKE_REQUIRED_FLAGS "-fsanitize=thread")
check_c_compiler_flag("-fsanitize=thread" CPP_COMPILER_SUPPORTS_FSANITIZE_THREAD)
# Test for memory sanitizer support
set(CMAKE_REQUIRED_FLAGS "-fsanitize=memory")
check_c_compiler_flag("-fsanitize=memory" CPP_COMPILER_SUPPORTS_FSANITIZE_MEMORY)
# Test for leak sanitizer support
set(CMAKE_REQUIRED_FLAGS "-fsanitize=leak")
check_c_compiler_flag("-fsanitize=leak" CPP_COMPILER_SUPPORTS_FSANITIZE_LEAK)
# Test for address and undefined sanitizer support combined.
set(CMAKE_REQUIRED_FLAGS "-fsanitize=address,undefined")
check_c_compiler_flag("-fsanitize=address,undefined" CPP_COMPILER_SUPPORTS_FSANITIZE_ADDRESS_UNDEFINED)
