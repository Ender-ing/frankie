message(STATUS "[DEPENDENCIES] Checking dependencies...")

# CMake
include(FetchContent)

# Check for C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
include(CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG("-std=c++17" CXX_17_FLAG)
CHECK_CXX_COMPILER_FLAG("-std:c++17" CXX_17_FLAG_MSVC)
if(NOT (CXX_17_FLAG OR CXX_17_FLAG_MSVC))
    message(FATAL_ERROR "[DEPENDENCIES] C++17 is not supported by the compiler. Please use a compiler that supports C++17.")
endif()

# Check for VS
# (MSVC)
#find_package(Visual Studio)
#if(MSVC)
#    message(SEND_WARNING "[DEPENDENCIES] What version of Visual Studio version do you use? (Professional/Community - default is Community):")
#    set(BUILD_VS_EDITION "Community" CACHE STRING "Professional" FORCE)
#endif()

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
set(FRANKIE_DEPENDENCIES_ANTLR4_JAR_PATH ${FRANKIE_DEPENDENCIES_DIR}/antlr4/antlr.jar)
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

# Check for GIT Patch
find_program(GIT_PATCH_EXECUTABLE NAMES patch) # Search for "patch" (case-insensitive)
if(GIT_PATCH_EXECUTABLE)
    message(STATUS "[DEPENDENCIES] Git Patch executable found: ${GIT_PATCH_EXECUTABLE}")
else()
    # Attempt to locate the Git Patch executable using the default paths
    if(CMAKE_SYSTEM_NAME MATCHES "Windows")
        set(GIT_PATCH_EXECUTABLE "C:/Program Files/Git/usr/bin/patch.exe")
    else()
        set(GIT_PATCH_EXECUTABLE "/usr/bin/patch")
    endif()
    if(GIT_PATCH_EXECUTABLE)
        message(STATUS "[DEPENDENCIES] Git Patch executable found (default path, not in PATH): ${GIT_PATCH_EXECUTABLE}")
    else()
        message(FATAL_ERROR "[DEPENDENCIES] Git Patch executable not found. Add it to your PATH or install it!")
    endif()
endif()

# {fmt}
option(USE_INSTALLED_FMT "Ignore or use installed FMT" OFF) # Default OFF - not using installed fmt
if(USE_INSTALLED_FMT)
    find_package(fmt)
endif()
if(fmt)
    message(STATUS "[DEPENDENCIES] {fmt} library is present!")
else()
    # Download {fmt}
    message(STATUS "[DEPENDENCIES] Fetching {fmt}...")
    FetchContent_Declare(
        fmt
        GIT_REPOSITORY https://github.com/fmtlib/fmt.git
        GIT_TAG ${FMT_LIB_VERSION}
        SOURCE_DIR ${FRANKIE_DEPENDENCIES_DIR}/fmt
        )
    FetchContent_MakeAvailable(fmt)
endif()
