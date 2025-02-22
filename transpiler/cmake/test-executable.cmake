# Define testing function
function(frankie_file_test test_name file_path)
    message(STATUS "[TESTS] Initiating \"frankie_file_test\" for the path: ${file_path}")
    add_test(NAME FrankieFileTest__${test_name}_find COMMAND ${CMAKE_COMMAND} -E file EXISTS ${file_path})
    add_test(NAME FrankieFileTest__${test_name}_execute COMMAND FrankieTranspiler ${file_path})
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
