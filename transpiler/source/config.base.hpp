/**
 * @brief 
 * Manage transpiler arguments and starting state
**/

#pragma once

#include "common/headers.hpp"
#include "dynamic.base.hpp" // FRANKIE_BASE_API

#include "actions.base.hpp"

// Basic C++ headers
//#include <string>

// WORK IN PROGRESS

namespace Base {
    // Version info
    extern FRANKIE_BASE_API const std::string version;

    // All state-related members should be contained under one namepsace
    namespace InitialConfigs {
        // Starting Path
        extern FRANKIE_BASE_API std::string frankiePath;

        // Main source file
        extern FRANKIE_BASE_API std::string mainPath;

        // Debug-related
        namespace Debug {
            // --debug-parser-antlr-syntax-test <path>
            namespace Parser {
                extern FRANKIE_BASE_API bool activateAntlrSyntaxTest;
            }
        }

        // Technical values
        namespace Technical {
            // For actions that require termination after the arguments are fully processed!
            extern FRANKIE_BASE_API bool terminateAfterArgs;
            // For actions that require termination after actions!
            extern FRANKIE_BASE_API bool terminateAfterActions;
            // Fail process when unknown flags are detected!
            extern FRANKIE_BASE_API bool strictFlagDetection;

            // Look for flags that require the default initialisation to stop!
            // [true - skip, false - don't skip]
            extern FRANKIE_BASE_API bool shouldSkipDefaultInitialization(int argc, const char *argv[]) ;
        }

        // Process and update values through program arguments!
        // [true - sucess, false - failure]
        extern FRANKIE_BASE_API bool updateUsingArgs(int argc, const char *argv[]) ;
    }
}
