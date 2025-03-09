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
        //  string[] (flag name(s)) // Members must be in lower case and only contain english letters and dashes (-)
        //  function (true - normal -> continue, false - error -> terminate) // Must always return a boolean value
        //  string (flag/action description)
        // ]
        std::unordered_map<
            ActionArgs,
            ActionFunction,
            std::string
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
                {"-dbg-antlr-print", "--debug-parser-antlr-print-test"},
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
                },
                "Print the parser's tokens list and initial parser output."
            }
        };

        // Get an action function using one flag
        // [true - success, false - failure]
        bool getActionFunctionByFlag(const std::string& flag, ActionFunction &store) {
            std::cout << "DOING SOMETHING!" << std::endl;
            std::cout << "DOING SOMETHING!" << std::endl;
            std::cout << "DOING SOMETHING!" << std::endl;
            for (const auto& pair : map) {
                if (pair.first[0] == flag || pair.first[1] == flag) {
                    store = pair.second;
                    std::cout << "FOUND A FUNCTION!" << std::endl;
                    std::cout << "FOUND A FUNCTION!" << std::endl;
                    std::cout << "FOUND A FUNCTION!" << std::endl;
                    return true;
                }
            }
            return false;
        }
    }
}
