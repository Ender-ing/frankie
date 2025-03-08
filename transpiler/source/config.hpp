/**
 * @brief 
 * Manage transpiler arguments and starting state
**/

#pragma once

#include "common/headers.hpp"
#include "dynamic.hpp" // FRANKIE_BASE_LIB

#include "actions.hpp"

// Basic C++ headers
//#include <string>

// WORK IN PROGRESS

namespace Base {
    // All state-related members should be contained under one namepsace
    namespace InitialConfigs {
        // Starting Path
        extern FRANKIE_BASE_LIB std::string runPath;

        // Debug-related
        namespace Debug {
            // --debug-parser-antlr-print-test <path>
            namespace ParserBasicPrintTest {
                extern FRANKIE_BASE_LIB bool active;
                extern FRANKIE_BASE_LIB std::string path;
            }
        }

        // Process and update values through program arguments!
        // [true - sucess, false - failure]
        extern FRANKIE_BASE_LIB bool updateUsingArgs (int argc, const char *argv[]) ;
    }
}
