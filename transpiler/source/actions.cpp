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
            ActionFunction
            > map = {
            /*{
                {"-i", "--input"},
                [](const ActionNextFunction getNextArg) {
                    std::cout << "Opening file..." << std::endl;
                    return true;
                },
                "Set a path for the main user input file."
            },
            {
                {"-frc-stdo", "--force-standard-output"},
                [](const ActionNextFunction getNextArg) {
                    return true;
                },
                "Forcefully feed all output (status, warnings, or errors) into the normal standard output stream!"
            },*/
            {
                {
                    "-dbg-antlr-print", "--debug-parser-antlr-print-test",
                    "Print the parser's tokens list and initial parser output."
                },
                [](const ActionNextFunction getNextArg) {
                    // Enable the test
                    InitialConfigs::Debug::ParserBasicPrintTest::active = true;

                    // Get the next argument and save it!
                    bool failed = getNextArg(InitialConfigs::Debug::ParserBasicPrintTest::path, true);

                    // Check if the action was successful!
                    if (failed) {
                        // Missing input argument!
                        // PRINT AN ERROR!
                        return false;
                    }

                    return true;
                }
            }
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
