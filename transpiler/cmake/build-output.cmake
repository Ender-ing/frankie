# Set the desired CMake binary output directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${FRANKIE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${FRANKIE_BINARY_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${FRANKIE_BINARY_DIR}/lib)

# Clear configuration-specific variables
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${FRANKIE_BINARY_DIR}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${FRANKIE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${FRANKIE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${FRANKIE_BINARY_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${FRANKIE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${FRANKIE_BINARY_DIR}/lib)

# Move MSVC files into the main folder
#add_custom_command(TARGET FrankieTranspiler
#                   POST_BUILD
#                   COMMAND ${CMAKE_COMMAND}
#                           -E move ./Release/* .
#                   WORKING_DIRECTORY ${FRANKIE_BINARY_DIR})
#                   add_custom_command(TARGET FrankieTranspiler
#                   POST_BUILD
#                   COMMAND ${CMAKE_COMMAND}
#                           -E move ./Debug/* .
#                   WORKING_DIRECTORY ${FRANKIE_BINARY_DIR})
