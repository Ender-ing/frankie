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
set(FRANKIE_DIST_FINAL_DIR ${FRANKIE_BINARY_DIR}/${FRANKIE_BINARY_MODE}/${FRANKIE_BINARY_PLATFORM})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${FRANKIE_DIST_FINAL_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${FRANKIE_DIST_FINAL_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${FRANKIE_DIST_FINAL_DIR}/lib)

# Clear configuration-specific variables
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${FRANKIE_BINARY_DIR}/Debug/${FRANKIE_BINARY_PLATFORM}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${FRANKIE_BINARY_DIR}/Release/${FRANKIE_BINARY_PLATFORM}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${FRANKIE_BINARY_DIR}/Debug/${FRANKIE_BINARY_PLATFORM}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${FRANKIE_BINARY_DIR}/Release/${FRANKIE_BINARY_PLATFORM}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${FRANKIE_BINARY_DIR}/Debug/${FRANKIE_BINARY_PLATFORM}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${FRANKIE_BINARY_DIR}/Release/${FRANKIE_BINARY_PLATFORM}/lib)

# Attach manifest.ini info to targets!
# (Only supports executables and dynamic libraries!)
function(attach_manifest_data TARGET)
    message(STATUS "[BUILD] Attaching manifest data to target: ${TARGET}")
    # Set versioning info
    get_ini_value(${FRANKIE_MANIFEST_FILE} "TARGET:${TARGET}" "VERSION" INI_VERSION)
    #get_ini_value(${FRANKIE_MANIFEST_FILE} "TARGET:${TARGET}" "SOVERSION" INI_SOVERSION)

    # Update target info
    set_target_properties(${TARGET} PROPERTIES # THIS DOESN'T WORK!
        VERSION "${INI_VERSION}"
        #SOVERSION "${INI_SOVERSION}" # CMAKE LINKS TO THIS, BEFORE "VERSION"
        # Naming scheme
        OUTPUT_NAME "${TARGET}"
    )

    # Keep track of the main target value
    if(NOT DEFINED IN_MAIN_BIN_VERSION_NAME)
        # Save version info
        set(IN_MAIN_BIN_VERSION_NAME "${INI_VERSION}")
        set(IN_MAIN_BIN_VERSION_NAME "${IN_MAIN_BIN_VERSION_NAME}" PARENT_SCOPE)
        string(REGEX MATCHALL "[0-9]+" version_list "${INI_VERSION}")
        list(GET version_list 0 IN_MAIN_BIN_MAJOR)
        set(IN_MAIN_BIN_MAJOR "${IN_MAIN_BIN_MAJOR}" PARENT_SCOPE)
        list(GET version_list 1 IN_MAIN_BIN_MINOR)
        set(IN_MAIN_BIN_MINOR "${IN_MAIN_BIN_MINOR}" PARENT_SCOPE)
        list(GET version_list 2 IN_MAIN_BIN_PATCH)
        set(IN_MAIN_BIN_PATCH "${IN_MAIN_BIN_PATCH}" PARENT_SCOPE)
        list(GET version_list 3 IN_MAIN_BIN_EXTRA)
        set(IN_MAIN_BIN_EXTRA "${IN_MAIN_BIN_EXTRA}" PARENT_SCOPE)
    endif()

    # Pass manifest data to .in file
    string(REGEX MATCHALL "[0-9]+" version_list "${INI_VERSION}")
    list(GET version_list 0 IN_BIN_MAJOR)
    list(GET version_list 1 IN_BIN_MINOR)
    list(GET version_list 2 IN_BIN_PATCH)
    list(GET version_list 3 IN_BIN_EXTRA)
    get_ini_value(${FRANKIE_MANIFEST_FILE} "TARGET:${TARGET}" "DESCRIPTION" IN_BIN_DESCRIPTION)
    set(IN_BIN_VERSION_NAME ${INI_VERSION})

    # Get target type
    get_target_property(target_type ${TARGET} TYPE)

    # Link native platform
    if(WIN32)
        # Modify binary name
        if(target_type STREQUAL "SHARED_LIBRARY")
            set(IN_BIN_NAME "${TARGET}.dll")
        else()
            set(IN_BIN_NAME "${TARGET}.exe")
        endif()
        # Compile Windows resource script file
        set(WIN32_VERSIONING_RC_FILE ${FRANKIE_BUILD_DIR}/versioning/${TARGET}.Rc)
        set(WIN32_VERSIONING_RES_FILE ${FRANKIE_BUILD_DIR}/versioning/${TARGET}.res)
        configure_file(${FRANKIE_CMAKE_DIR}/version/VersionInfo.Rc.in ${WIN32_VERSIONING_RC_FILE})
        execute_process(
            COMMAND ${RC_EXECUTABLE} /fo ${WIN32_VERSIONING_RES_FILE} ${WIN32_VERSIONING_RC_FILE}
            RESULT_VARIABLE command_result
        )
        if(NOT command_result EQUAL 0)
            message(FATAL_ERROR "[BUILD] Couldn't compile Windows resource file: ${WIN32_VERSIONING_RES_FILE}")
        endif()
        # Link Windows resource file to target
        target_link_libraries(${TARGET} PRIVATE ${WIN32_VERSIONING_RES_FILE})
    elseif(CMAKE_SYSTEM_NAME MATCHES "Darwin")
        # Modify binary name
        if(target_type STREQUAL "SHARED_LIBRARY")
            set(IN_BIN_NAME "lib${TARGET}.${IN_BIN_VERSION_NAME}.dylib")
        else()
            set(IN_BIN_NAME "${TARGET}.${IN_BIN_VERSION_NAME}")
        endif()
    elseif(CMAKE_SYSTEM_NAME MATCHES "Linux")
        # Modify binary name
        if(target_type STREQUAL "SHARED_LIBRARY")
            set(IN_BIN_NAME "lib${TARGET}.so.${IN_BIN_VERSION_NAME}")
        else()
            set(IN_BIN_NAME "${TARGET}.${IN_BIN_VERSION_NAME}")
        endif()
    endif()

    # Pass data to the target's C++ source files
    target_compile_definitions(${TARGET} PRIVATE
        "MAIN_TARGET_BINARY_VERSION=\"${IN_MAIN_BIN_VERSION_NAME}\""
        "TARGET_BINARY_VERSION=\"${IN_BIN_VERSION_NAME}\""
    )
endfunction()

# Manage symbolic links post-build
function(manage_symbolic_links POST_TARGET FRANKIE_COMMAND_NAME)
    if(WIN32)
        set(SYMBOLIC_LINKS_COMMAND_DELETE start /wait powershell -Command "Get-ChildItem -Path . -Attributes ReparsePoint | Remove-Item -Path {$_.FullName} -Force") 
        set(SYMBOLIC_LINKS_COMMAND_REMAKE echo "Windows already has a valid .exe main file!")
        set(SYMBOLIC_LINKS_COMMAND_EXTRA start /wait powershell -Command "Start-Process powershell -Verb RunAs -ArgumentList \\\"-Command cd '${CMAKE_RUNTIME_OUTPUT_DIRECTORY}' \; New-Item -Path ${FRANKIE_COMMAND_NAME}.exe -ItemType SymbolicLink -Value ${POST_TARGET}.exe \\\" ")
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
