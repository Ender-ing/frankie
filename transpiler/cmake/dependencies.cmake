message(STATUS "[DEPENDENCIES] Checking dependencies...")

# Check for Java
find_package(Java REQUIRED)
if(JAVA_VERSION VERSION_GREATER_EQUAL 11) # ANTLR4 jar requires Java 11 or higher 
    message(STATUS "Java 21 or higher found: ${JAVA_VERSION}")
    set(JAVA_11_FOUND TRUE) # Set a flag for later use
elseif(JAVA_FOUND) # Java was found, but not the right version
    message(FATAL_ERROR "Java ${JAVA_VERSION} found, but Java 11+ is required!")
    set(JAVA_11_FOUND FALSE)
else()
    message(FATAL_ERROR "Java not found! Please install Java 21 or newer on your system.")
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
endif()

# ANTLR4 C++ runtime
set(FRANKIE_DEPENDENCIES_ANTLR4_CPP_RUNTIME_ZIP_PATH ${CMAKE_CURRENT_SOURCE_DIR}/dependencies/antlr4/antlr4-cpp-runtime-source.zip)
if(NOT EXISTS ${FRANKIE_DEPENDENCIES_ANTLR4_CPP_RUNTIME_ZIP_PATH})
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
set(FRANKIE_DEPENDENCIES_ANTLR4_CPP_RUNTIME_PATH ${CMAKE_CURRENT_SOURCE_DIR}/dependencies/antlr4/antlr4-cpp-runtime-source)
message(STATUS "[DEPENDENCIES] Extracting ANTLR4 C++ runtime...")
extract_zip(${FRANKIE_DEPENDENCIES_ANTLR4_CPP_RUNTIME_ZIP_PATH} ${FRANKIE_DEPENDENCIES_ANTLR4_CPP_RUNTIME_PATH})
