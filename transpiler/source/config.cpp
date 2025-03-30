/**
 * @brief
 * Manage transpiler arguments and starting state
**/

#include "config.hpp"
#include "common/strings.hpp"

// WORK IN PROGRESS

namespace Base {
    // All state-related members should be contained under one namepsace
    namespace InitialConfigs {
        // Starting Path
        std::string runPath = "";

        // Main source file
        std::string mainPath = "";

        // Debug-related
        namespace Debug {
            // --debug-parser-antlr-print-test <path>
            namespace Parser {
                bool activateBasicPrintTest = false;
            }
        }

        // Technical values
        namespace Technical {
            // --version
            bool versionOnlyMode = false;
        }

        // Process and update values through program arguments!
        // [true - sucess, false - failure]
        bool updateUsingArgs (int argc, const char *argv[]) {
            // Get the starting path
            runPath = (std::string) argv[0];

            // Loop through all arguments (skipping the first one)
            for (int i = 1; i < argc; i++) {
                // Get the current argument
                std::string arg (argv[i]);
                // Convert the flag into lowercase format
                Common::Strings::toLowerCase(arg);

                // Use this function to get the next argument
                // [true - success, false = failure]
                const Actions::ActionNextFunction getNextArg = [&i, &argc, &argv](std::string &store, bool skip) {
                    // Check for the next argument
                    if (i + 1 < argc) {
                        // Get the next argument (and skip it when necessary!)
                        store = std::string(argv[(skip) ? ++i : i + 1]);
                        return true;
                    } else {
                        return false;
                    }
                };

                // Check current flag
                Actions::ActionFunction action;
                if (Actions::getActionFunctionByFlag(arg, action)) {
                    // Execute action, and check for failure
                    if (!action(getNextArg)) {
                        // Action-related error!
                        // Error message is handled by the action!
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
}
