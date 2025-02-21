# required if linking to static library
add_definitions(-DANTLR4CPP_STATIC)

# using /MD flag for antlr4_runtime (for Visual C++ compilers only)
set(ANTLR4_WITH_STATIC_CRT OFF)

# Specify the version of the antlr4 library needed for this project.
# By default the latest version of antlr4 will be used.  You can specify a
# specific, stable version by setting a repository tag value or a link
# to a zip file containing the libary source.
set(ANTLR4_TAG 4.13.2)
set(ANTLR4_ZIP_REPOSITORY https://github.com/antlr/antlr4/archive/refs/tags/4.13.2.zip)

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
             PACKAGE frankietranspiler)
antlr_target(FrankieGrammarParser ${FRANKIE_ANTLR4_PARSER_PATH} PARSER
             PACKAGE frankietranspiler
             DEPENDS_ANTLR FrankieGrammarLexer
             COMPILE_FLAGS -lib ${ANTLR_FrankieGrammarLexer_OUTPUT_DIR})
             
# include generated files in project environment
include_directories(${ANTLR_FrankieGrammarLexer_OUTPUT_DIR})
include_directories(${ANTLR_FrankieGrammarParser_OUTPUT_DIR})
