# Generate ANTLR4 grammar C++ files
include(${FRANKIE_CMAKE_DIR}/generate-ANTLR4-files.cmake)

# Include project libraries
include(${FRANKIE_CMAKE_DIR}/libraries.cmake)

# Add executable and include relevant files
message(STATUS "[BUILD] Adding executable target 'FrankieTranspiler'...")
add_executable(
    FrankieTranspiler ${FRANKIE_MAIN_CPP_PATH}
)

# Handle dynamic libraries
if(WIN32)
    # No need to do anything, Windows can handle this!
    # target_link_directories(FrankieTranspiler PRIVATE "$<TARGET_FILE_DIR:FrankieTranspiler>")
elseif(CMAKE_SYSTEM_NAME MATCHES "Darwin")
    target_link_directories(FrankieTranspiler PRIVATE "@executable_path")
elseif(CMAKE_SYSTEM_NAME MATCHES "Linux")
    target_link_directories(FrankieTranspiler PRIVATE "$ORIGIN")
endif()

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
