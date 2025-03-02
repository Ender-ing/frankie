# Generate ANTLR4 grammar C++ files
include(${FRANKIE_CMAKE_DIR}/generate-ANTLR4-files.cmake)

# Include project libraries
include(${FRANKIE_CMAKE_DIR}/libraries.cmake)

# Add executable and include relevant files
add_executable(
    FrankieTranspiler ${FRANKIE_MAIN_CPP_PATH}
)

# Link C++ libraries
# Basic in-house libraries
foreach(LIB ${PROJECT_LIBRARIES})
    # Link other public libraries to the library
    target_link_libraries(${LIB} PUBLIC fmt::fmt)
    # Add the library
    target_link_libraries(FrankieTranspiler ${LIB})
    # Mark the library as a dependency of the executable
    add_dependencies(FrankieTranspiler ${LIB})
endforeach()
