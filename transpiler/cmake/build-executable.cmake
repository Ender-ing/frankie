# Generate ANTLR4 grammar C++ files
include(${FRANKIE_CMAKE_DIR}/generate-ANTLR4-files.cmake)

# Include project static libraries
include(${FRANKIE_CMAKE_DIR}/static-libraries.cmake)

# Add executable and include relevant files
add_executable(
    FrankieTranspiler ${FRANKIE_MAIN_CPP_PATH}
)

# Link C++ libraries
# {fmt}
target_link_libraries(FrankieTranspiler fmt::fmt)
# ANTLR4
target_link_libraries(FrankieTranspiler antlr4_static)
# Basic in-house libraries
foreach(LIB ${PROJECT_STATIC_LIBRARIES})
    # Link other public libraries to the library
    target_link_libraries(${LIB} PUBLIC fmt::fmt)
    # Add the library
    target_link_libraries(FrankieTranspiler ${LIB})
endforeach()
