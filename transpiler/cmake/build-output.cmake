# Make adding global C/C++ flags easier
function(add_c_cpp_global_flag flag)
    message(STATUS "[BUILD] Adding C/C++ build flag: ${flag}...")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${flag}")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${flag}")
endfunction()

# Make adding global compile definitions easier
function(add_global_compile_definition definition)
    get_property(targets GLOBAL PROPERTY ALL_TARGETS)
    foreach(target ${targets})
        if(TARGET ${target})
            target_compile_definitions(${target} PRIVATE ${definition})
        endif()
    endforeach()
endfunction()

# Check the build mode
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    # Store output files in the 'Debug' subfolder
    set(FRANKIE_BINARY_MODE "Debug")
    message(STATUS "[BUILD] Build set to 'Debug' mode.")
else()
    if(NOT CMAKE_BUILD_TYPE STREQUAL "Release")
        message(WARNING "[BUILD] Invalid build mode detected! Defaulting to the 'Release' build mode.")
    else()
        message(STATUS "[BUILD] Detected the 'Release' build mode.")
    endif()
    # Store output files in the 'Release' subfolder
    set(FRANKIE_BINARY_MODE "Release")
    message(STATUS "[BUILD] Build set to 'Release' mode.")
endif()

# Set the desired CMake binary output directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${FRANKIE_BINARY_DIR}/${FRANKIE_BINARY_MODE}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${FRANKIE_BINARY_DIR}/${FRANKIE_BINARY_MODE}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${FRANKIE_BINARY_DIR}/${FRANKIE_BINARY_MODE}/lib)

# Clear configuration-specific variables
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${FRANKIE_BINARY_DIR}/Debug/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${FRANKIE_BINARY_DIR}/Release/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${FRANKIE_BINARY_DIR}/Debug/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${FRANKIE_BINARY_DIR}/Release/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${FRANKIE_BINARY_DIR}/Debug/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${FRANKIE_BINARY_DIR}/Release/lib)

# Libraries
if(WIN32)
    set(CMAKE_SHARED_LIBRARY_SUFFIX ".dll")
endif()
