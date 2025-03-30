/**
 * @brief
 * Manage transpiler actions
**/

#include "actions.base.hpp"

#include "config.base.hpp"

// CLI/LSP
#include "comms/comms.hpp"

// Common
#include "common/files.hpp"

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
                "<mode> - c/console (console, default) | s/server (language server)",
                {
                    // Get the next argument and save it!
                    std::string protocolText;
                    bool success = getNextArg(protocolText, true);

                    // Check if the action was successful!
                    if (!success) {
                        // Missing input argument!
                        REPORT(Comms::START_REPORT, Comms::FATAL_REPORT, "Missing the <mode> input argument! (-p, --protocol)", Comms::END_REPORT);
                        ACTION_FATAL_FAILURE;
                    }
                    
                    // Set communication protocol
                    if (protocolText == "s" || protocolText == "server") {
                        // TMP
                        REPORT(Comms::START_REPORT, Comms::FATAL_REPORT, "Currently, 'LSP' mode is not supported!", Comms::END_REPORT);
                        // Then set the protocol to 'server'
                        Comms::mode = Comms::LSP_MODE;
                    } else if (protocolText == "c" || protocolText == "console") {
                        Comms::mode = Comms::CLI_MODE;
                    } else {
                        // Incorrect input value!
                        REPORT(Comms::START_REPORT, Comms::WARNING_REPORT, "Incorrect <mode> value ('", protocolText,"') detected! (-p, --protocol)", "Expected values are: s/server, or c/console.", Comms::END_REPORT);
                        // Fallback to console mode
                        Comms::mode = Comms::CLI_MODE;
                        ACTION_FATAL_FAILURE;
                    }

                    ACTION_PROGRESS;
                }
            ),
            DEFINE_ACTION(
                "v", "version",
                "Get the plain version string. (No extra console output will be made as long as no errors occur)",
                "",
                {
                    // Enable the test
                    InitialConfigs::Technical::versionOnlyMode = true;

                    ACTION_PROGRESS;
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
                        REPORT(Comms::START_REPORT, Comms::FATAL_REPORT, "Missing the <path> input argument! (-i, --input)", Comms::END_REPORT);
                        ACTION_FATAL_FAILURE;
                    }

                    // Check if the file can be opened!
                    if (!Common::isFileAccessible(Base::InitialConfigs::mainPath)) {
                        // File isn't accessible!
                        REPORT(Comms::START_REPORT, Comms::FATAL_REPORT, "Input file is non-existent or inaccessible!", Comms::END_REPORT);
                        ACTION_FATAL_FAILURE;
                    }

                    ACTION_PROGRESS;
                }
            ),
            DEFINE_ACTION(
                "dbg-antlr-print", "debug-parser-antlr-print-test",
                "Print the parser's tokens list and initial parser output.",
                "",
                {
                    // Enable the test
                    InitialConfigs::Debug::Parser::activateBasicPrintTest = true;

                    // Report status
                    REPORT(Comms::START_REPORT, Comms::ACTION_REPORT, "Enabled the ANTLR4 parser print syntax test!", Comms::END_REPORT);

                    ACTION_PROGRESS;
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
