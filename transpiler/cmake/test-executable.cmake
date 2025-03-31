# Memory testing commands
find_program(VALGRIND_EXECUTABLE valgrind)
set(TEST_VALGRIND_COMMAND valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --undef-value-errors=yes --errors-for-leak-kinds=definite,indirect,possible,reachable)

# Basic transpiler commands
set(TEST_FRANKIE_COMMAND ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/FrankieTranspiler)
set(TEST_FRANKIE_MINI_COMMAND ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/frankie)

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

# All tests should have these checks, so use `define_frankie_test` to define any and all tests!
function(define_frankie_test test_prefix test_name should_fail test_command)
    # Set test base name
    if(should_fail)
        set(full_test_name ${test_prefix}failing__${test_name})
    else()
        set(full_test_name ${test_prefix}${test_name})
    endif()
    message(STATUS "[TESTS] Add a '${full_test_name}?' syntax test... (native ${CMAKE_SYSTEM_PROCESSOR}, binary ${FRANKIE_BINARY_PLATFORM})")
    # Check platform
    if(DEFINED NATIVE_SYSTEM_SUPPORTS_BINARIES)
        # Normal test
        add_test(NAME ${full_test_name}__execute COMMAND ${test_command})
        set_tests_properties(${full_test_name}__execute PROPERTIES WILL_FAIL ${should_fail})
        # Valgrind memory leaks test
        if(VALGRIND_EXECUTABLE)
            add_test(NAME ${full_test_name}__valgrind COMMAND ${TEST_VALGRIND_COMMAND} ${test_command})
            set_tests_properties(${full_test_name}__valgrind PROPERTIES WILL_FAIL ${should_fail})
        else()
            message(WARNING "[TESTS] Extra memory leak tests have been disabled! (Please install Valgrind to enable said tests...)")
        endif()    
    else()
        message(FATAL_ERROR "[TESTS] Native system does not support binaries, the relative test is likely to fail! (native ${CMAKE_SYSTEM_PROCESSOR}, binary ${FRANKIE_BINARY_PLATFORM})")
    endif()
endfunction()

# Define Basic binary testing function
function(frankie_binary_test)
    # Test if the binary's symbolic links are functioning normally!
    define_frankie_test("FrankieBinaryTest__" "FrankieTranspiler"
        FALSE
        "${TEST_FRANKIE_COMMAND}")
    define_frankie_test("FrankieBinaryTest__" "frankie"
        FALSE
        "${TEST_FRANKIE_MINI_COMMAND}"
        )
endfunction()

# Define Syntax testing function
function(frankie_file_syntax_test test_name file_path should_fail)
    # Check for the needed files
    if(EXISTS ${file_path})
        define_frankie_test("FrankieFileTest__syntax__" ${test_name}
            ${should_fail}
            "${TEST_FRANKIE_COMMAND};--debug-parser-antlr-syntax-test;-i;${file_path}")
    else()
        message(FATAL_ERROR "[TESTS] Failed to locate a Frankie test file! (${file_path}) The relative test is likely to fail!")
    endif()
endfunction()

# Create the basic files list
set(FRANKIE_FILE_TESTS "") # All frankie file tests will be applied to files added to this list
# list(APPEND FRANKIE_FILE_TESTS "path/to/file.frankie")
#set(FRANKIE_FILE_SYNTAX_TESTS "") # Syntax tests
## list(APPEND FRANKIE_FILE_SYNTAX_TESTS "path/to/file.frankie")

## Include all .test.cmake files in the tests directory
## Search for all .test.cmake files recursively
#file(GLOB_RECURSE TEST_CMAKE_FILES ${FRANKIE_TESTS_DIR}/*.test.cmake)
## Include each .test.cmake file
#foreach(TEST_CMAKE_FILE ${TEST_CMAKE_FILES})
#    include("${TEST_CMAKE_FILE}")
#endforeach()

# Test the basic binary command!
frankie_binary_test()

# Load all .frankie test files
file(GLOB_RECURSE TEST_FRANKIE_FILES ${FRANKIE_TESTS_DIR} "*.frankie")
foreach(file_path ${TEST_FRANKIE_FILES})
    message(STATUS "[TESTS] Processing test file ${file_path}...")
    # Get file name
    cmake_path(GET file_path FILENAME filename)
    # Exclude "_*.frankie" files
    # For some reason, using "${filename}" instead of "filename" results in some files like "numbers.frankie" not loading!
    string(REGEX MATCH "^[^_]" is_main_input_file filename)
    message(STATUS "[TESTS] ${filename}?")
    if(is_main_input_file)
        # Flag the file for testing
        list(APPEND FRANKIE_FILE_TESTS ${file_path})
    endif()
endforeach()

# Define a function that detects the precence of a "failure expectation" letter
function(check_for_frankie_file_letter letter file_name output_variable)
    string(REGEX MATCH "![a-zA-Z]*[${letter}][a-zA-Z]*.frankie" contains_letter "${file_name}")
    if(contains_letter)
        set(${output_variable} TRUE PARENT_SCOPE)
    else()
        set(${output_variable} FALSE PARENT_SCOPE)
    endif()
endfunction()

# Go through all added paths
foreach(file ${FRANKIE_FILE_TESTS})

    # Get the proper test name
    string(REPLACE ${FRANKIE_TESTS_DIR} "" test_name ${file}) # remove test directory path
    string(REGEX REPLACE "(![a-zA-Z]*)?.frankie" "" test_name ${test_name}) # remove ".frankie" file extension and extra letters
    string(REGEX REPLACE "[^a-zA-Z0-9_]" "_" test_name ${test_name}) # Remove illegal characters

    # Get test failure expectation
    # (Any letter placed between "!" and ".frankie" in the file's filename will trigger this)
    cmake_path(GET file FILENAME filename)

    # Syntax test
    check_for_frankie_file_letter("s" ${filename} expects_syntax_failure)
    if(expects_syntax_failure)
        frankie_file_syntax_test(${test_name} ${file} TRUE)
    else()
        frankie_file_syntax_test(${test_name} ${file} FALSE)
    endif()
endforeach()
