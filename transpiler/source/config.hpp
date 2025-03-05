/**
 * @brief 
 * Manage transpiler arguments and starting state
**/

#ifndef TRANSPILER_CONFIG_HPP // Unique identifier for the header
#define TRANSPILER_CONFIG_HPP

#include "common/headers.hpp"
// Basic C++ headers
//#include <string>

// All state-related members should be contained under one namepsace
namespace InitialConfigs {
    // Starting Path
    extern std::string runPath;

    // Debug-related
    namespace Debug {
        // --debug-parser-print-test <path>
        namespace ParserBasicPrintTest {
            extern bool active;
            extern std::string path;
        }
    }

    // Process and update values through program arguments!
    // [true - sucess, false - failure]
    bool updateUsingArgs (int argc, const char *argv[]) ;
}

#endif
