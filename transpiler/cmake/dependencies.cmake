message(STATUS "[DEPENDENCIES] Checking dependencies...")

# Check for C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
include(CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG("-std=c++17" CXX_17_FLAG)
CHECK_CXX_COMPILER_FLAG("-std:c++17" CXX_17_FLAG_MSVC)
if(NOT (CXX_17_FLAG OR CXX_17_FLAG_MSVC))
    message(FATAL_ERROR "[DEPENDENCIES] C++17 is not supported by the compiler. Please use a compiler that supports C++17.")
endif()

# Check for Java
find_package(Java REQUIRED)
# Execute java -version and capture the output
if(JAVA_FOUND)
    execute_process(
        COMMAND ${Java_JAVA_EXECUTABLE} -version
        OUTPUT_VARIABLE JAVA_VERSION_COMMAND_STDOUT
        ERROR_VARIABLE JAVA_VERSION_COMMAND_STDERR
    )
    # Use the value of either standard output or standard error
    if(JAVA_VERSION_COMMAND_STDOUT)
        set(JAVA_VERSION_COMMAND_OUTPUT ${JAVA_VERSION_COMMAND_STDOUT})
    else()
        set(JAVA_VERSION_COMMAND_OUTPUT ${JAVA_VERSION_COMMAND_STDERR})
    endif()
    # Parse the version string from the find_package output
    string(REGEX MATCH "version \\\"([0-9\\._]+)\\\"" JAVA_VERSION_MATCH "${JAVA_VERSION_COMMAND_OUTPUT}")
    if(JAVA_VERSION_MATCH)
        set(JAVA_VERSION ${CMAKE_MATCH_1})
        # Parse major, minor, patch (example - adapt as needed)
        string(REGEX MATCH "([0-9]+)\\.([0-9]+)\\.([0-9]+)" JAVA_VERSION_PARTS "${JAVA_VERSION}")
        if(JAVA_VERSION_PARTS)
            set(JAVA_MAJOR_VERSION ${CMAKE_MATCH_1})
            set(JAVA_MINOR_VERSION ${CMAKE_MATCH_2})
            set(JAVA_PATCH_VERSION ${CMAKE_MATCH_3})
        endif()
    else()
        message(FATAL_ERROR "[DEPENDENCIES] Could not determine Java version from find_package output: ${JAVA_VERSION_COMMAND_OUTPUT}")
    endif()
endif()
# Check if Java version is 11 or higher
if(JAVA_MAJOR_VERSION VERSION_GREATER_EQUAL 11) # ANTLR4 jar requires Java 11 or higher 
    message(STATUS "[DEPENDENCIES] Java 11 or higher found: ${JAVA_MAJOR_VERSION}")
elseif(JAVA_FOUND) # Java was found, but not the right version
    message(FATAL_ERROR "[DEPENDENCIES] Java ${JAVA_MAJOR_VERSION} found, but Java 11+ is required!")
else()
    message(FATAL_ERROR "[DEPENDENCIES] Java not found! Please install Java 11 or newer on your system.")
endif()

# ANTLR4 jar
set(FRANKIE_DEPENDENCIES_ANTLR4_JAR_PATH ${CMAKE_CURRENT_SOURCE_DIR}/dependencies/antlr4/antlr.jar)
if(NOT EXISTS ${FRANKIE_DEPENDENCIES_ANTLR4_JAR_PATH})
    message(STATUS "[DEPENDENCIES] Downloading ANTLR4 jar (v4.13.2)...")
    file(DOWNLOAD
        "https://www.antlr.org/download/antlr-4.13.2-complete.jar"
        ${FRANKIE_DEPENDENCIES_ANTLR4_JAR_PATH}
        EXPECTED_HASH "SHA256=eae2dfa119a64327444672aff63e9ec35a20180dc5b8090b7a6ab85125df4d76"
        TLS_VERIFY TRUE
        TIMEOUT 30
        STATUS download_status_1
    )
    if(NOT download_status_1 EQUAL 0)
        message(FATAL_ERROR "[DEPENDENCIES] Failed to download ANTLR4 jar: ${download_errors}")
    endif()
else()
    message(STATUS "[DEPENDENCIES] ANTLR4 jar is present!")
endif()

# ANTLR4 C++ runtime
set(FRANKIE_DEPENDENCIES_ANTLR4_CPP_RUNTIME_ZIP_PATH ${CMAKE_CURRENT_SOURCE_DIR}/dependencies/antlr4/antlr4-cpp-runtime-source.zip)
set(FRANKIE_DEPENDENCIES_ANTLR4_CPP_RUNTIME_PATH ${CMAKE_CURRENT_SOURCE_DIR}/dependencies/antlr4/antlr4-cpp-runtime-source)
# Download missing files
if((NOT EXISTS ${FRANKIE_DEPENDENCIES_ANTLR4_CPP_RUNTIME_ZIP_PATH}) AND (NOT EXISTS ${FRANKIE_DEPENDENCIES_ANTLR4_CPP_RUNTIME_PATH}))
    message(STATUS "[DEPENDENCIES] Downloading ANTLR4 C++ runtime (v4.13.2)...")
    file(DOWNLOAD
        "https://www.antlr.org/download/antlr4-cpp-runtime-4.13.2-source.zip"
        ${FRANKIE_DEPENDENCIES_ANTLR4_CPP_RUNTIME_ZIP_PATH}
        EXPECTED_HASH "SHA256=0ed13668906e86dbc0dcddf30fdee68c10203dea4e83852b4edb810821bee3c4"
        TLS_VERIFY TRUE
        TIMEOUT 30
        STATUS download_status_2
    )
    if(NOT download_status_2 EQUAL 0)
        message(FATAL_ERROR "[DEPENDENCIES] Failed to download ANTLR4 jar: ${download_errors}")
    endif()
endif()
# extract the runtime files
if(NOT EXISTS ${FRANKIE_DEPENDENCIES_ANTLR4_CPP_RUNTIME_PATH})
    message(STATUS "[DEPENDENCIES] Extracting ANTLR4 C++ runtime...")
    extract_zip(${FRANKIE_DEPENDENCIES_ANTLR4_CPP_RUNTIME_ZIP_PATH} ${FRANKIE_DEPENDENCIES_ANTLR4_CPP_RUNTIME_PATH})
endif()
# TO-DO:
# - Add a check for already-installed ANTLR4 C++ runtime
# - Add appropriate ANTLR4 C++ runtime presence status messages
