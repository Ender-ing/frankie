/**
 * @brief
 * Manage transpiler arguments and starting state
**/

#include "config.base.hpp"
#include "common/strings.hpp"

// CLI/LSP
#include "comms/comms.hpp"

namespace Base {
    // All state-related members should be contained under one namepsace
    namespace InitialConfigs {
        // Starting Path
        std::string runPath = "";

        // Main source file
        std::string mainPath = "";

        // Debug-related
        namespace Debug {
            // --debug-parser-antlr-syntax-test <path>
            namespace Parser {
                bool activateAntlrSyntaxTest = false;
            }
        }

        // Technical values
        namespace Technical {
            // For actions that require minimal finalisation!
            bool minimalProtocolFinalization = false;
            // For actions that require termination after the arguments are fully processed!
            bool terminateAfterArgs = false;
            // For actions that require termination after actions!
            bool terminateAfterActions = false;

            // Look for flags that require the default initialisation to stop!
            // [true - skip, false - don't skip]
            bool shouldSkipDefaultInitialization(int argc, const char *argv[]) {
                // List of flags
                std::vector<std::string> flagsList{"-v", "--version"};
                // Loop through all arguments (skipping the first one)
                for (int i = 1; i < argc; i++) {
                    // Get the current argument
                    std::string arg (argv[i]);
                    // Convert the flag into lowercase format
                    Common::Strings::toLowerCase(arg);

                    // Check if the flag is in the list
                    if (std::find(std::begin(flagsList), std::end(flagsList), arg) != std::end(flagsList)) {
                        return true;
                    }

                }

                // Don't skip!
                return false;
            }
        }

        // Process and update values through program arguments!
        // [true - sucess, false - failure]
        bool updateUsingArgs(int argc, const char *argv[]) {
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
                        // Action-related fatal error!
                        // Error message is handled by the action!
                        return false;
                    }
                } else {
                    // Unknown argument!
                    REPORT(Comms::START_REPORT, Comms::FATAL_REPORT, "Unknown argument! ('", arg, "')", Comms::END_REPORT);
                    return false;
                }
            }

            // Success!
            return true;
        }
    }
}
