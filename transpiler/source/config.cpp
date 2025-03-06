/**
 * @brief
 * Manage transpiler arguments and starting state
**/

#include "config.hpp"

// All state-related members should be contained under one namepsace
namespace InitialConfigs {
    // Starting Path
    std::string runPath = "";

    // Debug-related
    namespace Debug {
        // --debug-parser-print-test <path>
        namespace ParserBasicPrintTest {
            bool active = false;
            std::string path = "";
        }
    }

    // Process and update values through program arguments!
    // [true - sucess, false - failure]
    bool updateUsingArgs (int argc, const char *argv[]) {
        // Get the starting path
        std::string runPath (argv[0]);

        // Loop through all arguments (skipping the first one)
        for (int i = 1; i < argc; i++) {
            // Enable the test
            Debug::ParserBasicPrintTest::active = true;

            // Get the current argument
            std::string arg (argv[i]);

            if (arg == "--debug-parser-print-test") {
                // Check for the next argument
                if (i + 1 < argc) {
                    // Get the next argument and skip it!
                    std::string inputArg (argv[++i]);
                    Debug::ParserBasicPrintTest::path = inputArg;
                } else {
                    // Missing input argument!
                    // PRINT AN ERROR!
                    return false;
                }
            } else {
                // Unknown argument!
                // PRINT AN ERROR!
                return false;
            }
        }

        // Success!
        return true;
    }
}
