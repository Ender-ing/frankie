/**
 * @brief
 * Manage transpiler actions
**/

#include "actions.hpp"

#include "config.hpp"

namespace Base {
    namespace Actions {
        // List of actions and their respective functions
        // [
        //  string[
        //      // flag name members must be in lower case and only contain english letters and dashes (-)
        //      string (short flag name)
        //      string (long flag name)
        //      string (flag/action description)
        //  ]
        //  function (true - normal -> continue, false - error -> terminate) // Must always return a boolean value
        // ]
        std::unordered_map<
            ActionInfo,
            ActionFunction,
            ActionInfoHash_internal
            > map = {
            /*
            {
                {"-frc-stdo", "--force-standard-output"},
                [](const ActionNextFunction getNextArg) {
                    return true;
                },
                "Forcefully feed all output (status, warnings, or errors) into the normal standard output stream!"
            },*/
            DEFINE_ACTION(
                "p", "protocol",
                "Set the data output protocol.",
                "c (console, default) | s (language server)",
                {
                    // Get the next argument and save it!
                    std::string protocolText;
                    bool success = getNextArg(Base::InitialConfigs::protocol, true);

                    // Check if the action was successful!
                    if (!success) {
                        // Missing input argument!
                        // PRINT AN ERROR!
                        ACTION_FAILURE;
                    }

                    // Check if the protocol value is valid!
                    if(!(Base::InitialConfigs::protocol == "c" || Base::InitialConfigs::protocol == "s")) {
                        // Incorrect input value!
                        // PRINT AN ERROR!
                        ACTION_FAILURE;
                    }

                    ACTION_SUCCESS;
                }
            ),
            DEFINE_ACTION(
                "v", "version",
                "Get the plain version string. (No extra console output will be made as long as no errors occur)",
                "",
                {
                    // Enable the test
                    InitialConfigs::Technical::versionOnlyMode = true;

                    ACTION_SUCCESS;
                }
            ),
            DEFINE_ACTION(
                "i", "input",
                "Set a path for the main user input file.",
                "<path>",
                {
                    // Get the next argument and save it!
                    bool success = getNextArg(Base::InitialConfigs::mainPath, true);

                    // Check if the action was successful!
                    if (!success) {
                        // Missing input argument!
                        // PRINT AN ERROR!
                        ACTION_FAILURE;
                    }

                    // Check if the file exists!

                    ACTION_SUCCESS;
                }
            ),
            DEFINE_ACTION(
                "dbg-antlr-print", "debug-parser-antlr-print-test",
                "Print the parser's tokens list and initial parser output.",
                "",
                {
                    // Enable the test
                    InitialConfigs::Debug::Parser::activateBasicPrintTest = true;

                    ACTION_SUCCESS;
                }
            )
    };

        // Get an action function using one flag
        // [true - success, false - failure]
        bool getActionFunctionByFlag(const std::string& flag, ActionFunction &store) {
            for (const auto& pair : map) {
                if (pair.first[0] == flag || pair.first[1] == flag) {
                    store = pair.second;
                    return true;
                }
            }
            return false;
        }
    }
}
