# Add executable and include relevant files
message(STATUS "[BUILD] Adding executable target 'FrankieTranspiler'...")
add_executable(
    FrankieTranspiler ${FRANKIE_MAIN_CPP_PATH}
)

# Handle dynamic libraries
target_link_directories(FrankieTranspiler PRIVATE "$<TARGET_FILE_DIR:FrankieTranspiler>")

# Attach manifest data
# The first use of the "attach_manifest_data" function must be for the main executable!
attach_manifest_data(FrankieTranspiler)

# Re-do symbolic linking (POST BUILD)
manage_symbolic_links(FrankieTranspiler "frankie")

# Add compiler flags
add_internal_target_cxx_flags(FrankieTranspiler FALSE)

# Generate ANTLR4 grammar C++ files
include(${FRANKIE_CMAKE_DIR}/generate-ANTLR4-files.cmake)

# Include project libraries
include(${FRANKIE_CMAKE_DIR}/libraries.cmake)

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
