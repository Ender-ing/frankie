# Generate ANTLR4 grammar C++ files
include(${FRANKIE_CMAKE_DIR}/generate-ANTLR4-files.cmake)

# Include project libraries
include(${FRANKIE_CMAKE_DIR}/libraries.cmake)

# Add executable and include relevant files
message(STATUS "[BUILD] Adding executable target 'FrankieTranspiler'...")
add_executable(
    FrankieTranspiler ${FRANKIE_MAIN_CPP_PATH}
)
target_link_directories(FrankieTranspiler PRIVATE ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

# Link C++ libraries
# Basic in-house libraries
foreach(LIB ${PROJECT_LIBRARIES})
    message(STATUS "[BUILD] Adding linking target '${LIB}' to executable target 'FrankieTranspiler'...")
    # Mark the library as a dependency of the executable
    add_dependencies(FrankieTranspiler ${LIB})
    # Add the library
    target_link_libraries(FrankieTranspiler PUBLIC ${LIB})
endforeach()

# Add debug flags
include(${FRANKIE_CMAKE_DIR}/debug-mode.cmake)
