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

# Get the current build architecture
project(ArchitectureSpecificBuild)
if(CMAKE_GENERATOR_PLATFORM)
    if(${CMAKE_GENERATOR_PLATFORM} STREQUAL "Win32")
        set(FRANKIE_BINARY_PLATFORM "x86_32")
    elseif(${CMAKE_GENERATOR_PLATFORM} STREQUAL "x64")
        set(FRANKIE_BINARY_PLATFORM "x86_64")
    elseif(${CMAKE_GENERATOR_PLATFORM} STREQUAL "ARM")
        set(FRANKIE_BINARY_PLATFORM "arm32")
    elseif(${CMAKE_GENERATOR_PLATFORM} STREQUAL "ARM64")
        set(FRANKIE_BINARY_PLATFORM "arm64")
    else()
        message(FATAL_ERROR "[BUILD] Couldn't determine the target architecture for the build on Windows.")
    endif()
elseif(CMAKE_UNIX_GENERATOR_PLATFORM)
    if(${CMAKE_UNIX_GENERATOR_PLATFORM} STREQUAL "x86")
        add_c_cpp_global_flag("-arch x86_32")
        add_c_cpp_global_flag("-m32")
        set(FRANKIE_BINARY_PLATFORM "x86_32")
    elseif(${CMAKE_UNIX_GENERATOR_PLATFORM} STREQUAL "x64")
        add_c_cpp_global_flag("-arch x86_64")
        add_c_cpp_global_flag("-m64")
        add_c_cpp_global_flag("-march=x86-64")
        set(FRANKIE_BINARY_PLATFORM "x86_64")
    elseif(${CMAKE_UNIX_GENERATOR_PLATFORM} STREQUAL "ARM")
        add_c_cpp_global_flag("-arch arm64")
        add_c_cpp_global_flag("-marm")
        add_c_cpp_global_flag("-march=armv7-a")
        set(FRANKIE_BINARY_PLATFORM "arm32")
    elseif(${CMAKE_UNIX_GENERATOR_PLATFORM} STREQUAL "ARM64")
        add_c_cpp_global_flag("-arch arm64")
        add_c_cpp_global_flag("-mabi=lp64")
        add_c_cpp_global_flag("-mfpu=neon-fp-armv8")
        add_c_cpp_global_flag("-march=armv8-a")
        set(FRANKIE_BINARY_PLATFORM "arm64")
    else()
        message(FATAL_ERROR "[BUILD] Couldn't determine the target architecture for the build on Windows.")
    endif()
else()
    message(FATAL_ERROR "[BUILD] Couldn't determine the target architecture for the build.")
endif()

# Set the desired CMake binary output directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${FRANKIE_BINARY_DIR}/${FRANKIE_BINARY_MODE}/${FRANKIE_BINARY_PLATFORM}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${FRANKIE_BINARY_DIR}/${FRANKIE_BINARY_MODE}/${FRANKIE_BINARY_PLATFORM}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${FRANKIE_BINARY_DIR}/${FRANKIE_BINARY_MODE}/${FRANKIE_BINARY_PLATFORM}/lib)

# Clear configuration-specific variables
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${FRANKIE_BINARY_DIR}/Debug/${FRANKIE_BINARY_PLATFORM}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${FRANKIE_BINARY_DIR}/Release/${FRANKIE_BINARY_PLATFORM}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${FRANKIE_BINARY_DIR}/Debug/${FRANKIE_BINARY_PLATFORM}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${FRANKIE_BINARY_DIR}/Release/${FRANKIE_BINARY_PLATFORM}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${FRANKIE_BINARY_DIR}/Debug/${FRANKIE_BINARY_PLATFORM}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${FRANKIE_BINARY_DIR}/Release/${FRANKIE_BINARY_PLATFORM}/lib)

# Add a .ini value reader
function(get_ini_value INI_FILE INI_SECTION KEY OUTPUT_VARIABLE)
    # Get file contents
    file(READ ${INI_FILE} INI_CONTENTS)
    string(REGEX REPLACE "\r" "" INI_CONTENTS "${INI_CONTENTS}")

    # Get the required section
    string(REGEX MATCH "(\\[${INI_SECTION}\\]\n)(([^\\[]*)\n)*\\[?" MATCHED_SECTION "${INI_CONTENTS}")

    # Look for the key
    string(REGEX MATCH "(^|\n)(${KEY}\\=[^\n]*)" MATCHED_VALUE "${MATCHED_SECTION}")
    # Only get the value
    # (?<=(\[FrankieTranspiler\]\n))^VERSION=([^\n]*) # Doesn't work if the value is not directly after the section's name
    string(REGEX REPLACE "(^|\n)${KEY}\\=[\\s]*(\"(.*)\"|([\\d]+))[\\s]*" "\\3" VALUE "${MATCHED_VALUE}")
    string(STRIP "${VALUE}" VALUE) # Remove extra whitespace (for bad string values)

    # Check for value inheritance
    string(REGEX MATCH "^INHERIT:.+" INIT_INHERIT "${VALUE}")
    if(INIT_INHERIT)
        string(REGEX REPLACE "INHERIT:(.*)" "\\1" INIT_INHERIT "${INIT_INHERIT}")
        # Get value from INIT_INHERIT's section
        get_ini_value(${INI_FILE} ${INIT_INHERIT} ${KEY} VALUE)
    endif()

    # Return value
    set(${OUTPUT_VARIABLE} "${VALUE}" PARENT_SCOPE)
endfunction()

# Attach manifest.ini info to targets!
function(attach_manifest_data TARGET)
    message(STATUS "[BUILD] Attaching manifest data to target: ${TARGET}")
    # Set versioning info
    get_ini_value(${FRANKIE_MANIFEST_FILE} ${TARGET} "VERSION" INI_VERSION)
    #get_ini_value(${FRANKIE_MANIFEST_FILE} ${TARGET} "SOVERSION" INI_SOVERSION)

    # Update target info
    set_target_properties(${TARGET} PROPERTIES # THIS DOESN'T WORK!
        VERSION "${INI_VERSION}"
        #SOVERSION "${INI_SOVERSION}" # CMAKE LINKS TO THIS, BEFORE "VERSION"
        # Naming scheme
        OUTPUT_NAME "${TARGET}"
    )
endfunction()

# Manage symbolic links post-build
function(manage_symbolic_links POST_TARGET FRANKIE_COMMAND_NAME)
    if(WIN32)
        set(SYMBOLIC_LINKS_COMMAND_DELETE Get-ChildItem -Path . -Attributes ReparsePoint | Remove-Item -Force)
        set(SYMBOLIC_LINKS_COMMAND_REMAKE mklink ${POST_TARGET}.exe ${POST_TARGET}*)
        set(SYMBOLIC_LINKS_COMMAND_EXTRA mklink ${FRANKIE_COMMAND_NAME}.exe ${POST_TARGET}.exe)
    else()
        set(SYMBOLIC_LINKS_COMMAND_DELETE find . -type l -delete)
        set(SYMBOLIC_LINKS_COMMAND_REMAKE ln -s ${POST_TARGET}* ${POST_TARGET})
        set(SYMBOLIC_LINKS_COMMAND_EXTRA ln -s ${POST_TARGET} ${FRANKIE_COMMAND_NAME})
    endif()
    add_custom_command(
        TARGET ${POST_TARGET}
        POST_BUILD
        COMMAND ${SYMBOLIC_LINKS_COMMAND_DELETE}
        COMMAND ${SYMBOLIC_LINKS_COMMAND_REMAKE}
        COMMAND ${SYMBOLIC_LINKS_COMMAND_EXTRA}
        WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
    )
endfunction()
