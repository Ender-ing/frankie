# PIC
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(BUILD_SHARED_LIBS ON)

# required if linking to static library
# add_definitions(-DANTLR4CPP_STATIC)

# using /MD flag for antlr4_runtime (for Visual C++ compilers only)
set(ANTLR4_WITH_STATIC_CRT OFF)

# WARNING!
# Patches may be applied to the ANTLR4 runtime source code!
# Make sure to update the patch files if the version changes!

# Specify the version of the antlr4 library needed for this project.
# ANTLR4_TAG SHOULD ALREADY BE SET!
# By default the latest version of antlr4 will be used.  You can specify a
# specific, stable version by setting a repository tag value or a link
# to a zip file containing the libary source.
# set(ANTLR4_ZIP_REPOSITORY https://github.com/antlr/antlr4/archive/refs/tags/4.13.2.zip) # No need to set this! (if you do, the git patch won't apply!)
# If the patching process fails, use this:
# set(ANTLR4_ZIP_REPOSITORY https://github.com/0xENDER/antlr-4.13.2-chrono-patch/archive/refs/tags/4.13.2-crono-patch.zip)

# add external build for antlrcpp
include(ExternalAntlr4Cpp)
# add antlr4cpp artifacts to project environment
include_directories(${ANTLR4_INCLUDE_DIRS})

# set variable pointing to the antlr tool that supports C++
# this is not required if the jar file can be found under PATH environment
set(ANTLR_EXECUTABLE ${FRANKIE_DEPENDENCIES_ANTLR4_JAR_PATH})
# add macros to generate ANTLR Cpp code from grammar
find_package(ANTLR REQUIRED)

# Call macro to add lexer and grammar to your build dependencies.
antlr_target(FrankieGrammarLexer ${FRANKIE_ANTLR4_LEXER_PATH} LEXER
            PACKAGE frankie_parser)
antlr_target(FrankieGrammarParser ${FRANKIE_ANTLR4_PARSER_PATH} PARSER
            PACKAGE frankie_parser
            DEPENDS_ANTLR FrankieGrammarLexer
            COMPILE_FLAGS -lib ${ANTLR_FrankieGrammarLexer_OUTPUT_DIR})

# include generated files in project environment
include_directories(${ANTLR_FrankieGrammarLexer_OUTPUT_DIR})
include_directories(${ANTLR_FrankieGrammarParser_OUTPUT_DIR})
