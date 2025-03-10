# Used commands
find_program(VALGRIND_EXECUTABLE valgrind)
set(TEST_VALGRIND_COMMAND valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --undef-value-errors=yes --errors-for-leak-kinds=definite,indirect,possible,reachable)
set(TEST_FRANKIE_DEBUG_COMMAND ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/FrankieTranspiler --debug-parser-antlr-print-test -i)

# Check if the native system supports the generated binaries
set(X64_PROCESSORS "x86_64 x64 AMD64")
set(X32_PROCESSORS "x86_32 x86 i386 x32")
set(ARM64_PROCESSORS "arm64 aarch64 armv8")
set(ARM32_PROCESSORS "arm32 arm armv7")
if(${FRANKIE_BINARY_PLATFORM} STREQUAL "arm64")
    # Can be executed on arm64
    if(${ARM64_PROCESSORS} MATCHES ${CMAKE_SYSTEM_PROCESSOR})
        set(NATIVE_SYSTEM_SUPPORTS_BINARIES TRUE)
    endif()
elseif(${FRANKIE_BINARY_PLATFORM} STREQUAL "arm32")
    # Can be executed on arm64, and arm32
    if(${ARM64_PROCESSORS} MATCHES ${CMAKE_SYSTEM_PROCESSOR} OR ${ARM32_PROCESSORS} MATCHES ${CMAKE_SYSTEM_PROCESSOR})
        set(NATIVE_SYSTEM_SUPPORTS_BINARIES TRUE)
    endif()
elseif(${FRANKIE_BINARY_PLATFORM} STREQUAL "x86_64")
    # Can be executed on arm64, and x86_64
    if(${ARM64_PROCESSORS} MATCHES ${CMAKE_SYSTEM_PROCESSOR} OR ${X64_PROCESSORS} MATCHES ${CMAKE_SYSTEM_PROCESSOR})
        set(NATIVE_SYSTEM_SUPPORTS_BINARIES TRUE)
    endif()
elseif(${FRANKIE_BINARY_PLATFORM} STREQUAL "x86_32")
    # Can be executed on arm64, arm32, x86_64, and x86_32
    set(NATIVE_SYSTEM_SUPPORTS_BINARIES TRUE)
else()
    message(FATAL_ERROR "[TESTS] Couldn't determine the build target")
endif()

# Define testing function
function(frankie_file_test test_name file_path)
    message(STATUS "[TESTS] Add a '${test_name}' test... (native ${CMAKE_SYSTEM_PROCESSOR}, binary ${FRANKIE_BINARY_PLATFORM})")
    if(EXISTS ${file_path})
        if(DEFINED NATIVE_SYSTEM_SUPPORTS_BINARIES)
            # Normal test
            add_test(NAME FrankieFileTest__${test_name}_execute COMMAND ${TEST_FRANKIE_DEBUG_COMMAND} ${file_path})
            # Valgrind memory leaks test
            if(VALGRIND_EXECUTABLE)
                add_test(NAME FrankieFileTest__${test_name}_valgrind COMMAND ${TEST_VALGRIND_COMMAND} ${TEST_FRANKIE_DEBUG_COMMAND} ${file_path})
            else()
                message(WARNING "[TESTS] Extra memory leak tests have been disabled! (Please install Valgrind to enable said tests...)")
            endif()
        else()
            message(FATAL_ERROR "[TESTS] Native system does not support binaries, the relative test is likely to fail! (native ${CMAKE_SYSTEM_PROCESSOR}, binary ${FRANKIE_BINARY_PLATFORM})")
        endif()
    else()
        message(FATAL_ERROR "[TESTS] Failed to locate a Frankie test file! (${file_path}) The relative test is likely to fail!")
    endif()
endfunction()

# Include all .test.cmake files in the tests directory
# Search for all .test.cmake files recursively
file(GLOB_RECURSE TEST_CMAKE_FILES ${FRANKIE_TESTS_DIR}/*.test.cmake)
# Include each .test.cmake file
foreach(TEST_CMAKE_FILE ${TEST_CMAKE_FILES})
  include("${TEST_CMAKE_FILE}")
endforeach()

# Example: Adding a test that runs a script
# add_test(NAME ScriptTest COMMAND ${CMAKE_COMMAND} -E echo "Running script test")

# Example: Adding a test that checks for file existence
# add_test(NAME FileTest COMMAND ${CMAKE_COMMAND} -E file EXISTS my_file.txt)
