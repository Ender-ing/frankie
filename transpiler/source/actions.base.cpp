/**
 * @brief
 * Manage transpiler actions
 * (The actual actions should be implemented somewhere else if possible!)
**/

#include "actions.base.hpp"

#include "config.base.hpp"
#include "info.base.hpp"

// CLI/LSP
#include "comms/comms.hpp"

// Common
#include "common/files.hpp"

// Shorten the syntax for defining an action
#define DEFINE_ACTION(FLAG1, FLAG2, DESCRIPTION, ARGS, FUNCTION){   \
    {                                                               \
        "-" FLAG1, "--" FLAG2,                                      \
        #DESCRIPTION,                                               \
        #ARGS                                                       \
    },                                                              \
    [](const ActionNextFunction getNextArg) FUNCTION                \
}                                                                   \

// Hide the return keyword to avoid confusion
#define ACTION_FATAL_FAILURE                return false
#define ACTION_PROGRESS                     return true

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
                        REPORT(Comms::START_REPORT, Comms::FATAL_REPORT,
                            "Missing the <mode> input argument! (-p, --protocol)", Comms::END_REPORT);
                        ACTION_FATAL_FAILURE;
                    }
                    
                    // Set communication protocol
                    if (protocolText == "s" || protocolText == "server") {
                        // Then set the protocol to 'server'
                        Comms::mode = Comms::LSP_MODE;
                        REPORT(Comms::START_REPORT, Comms::ACTION_REPORT,
                            "Communications protocol has been set to 'server' mode!", Comms::END_REPORT);
                    } else if (protocolText == "c" || protocolText == "console") {
                        // Then set the protocol to 'console'
                        Comms::mode = Comms::CLI_MODE;
                        REPORT(Comms::START_REPORT, Comms::ACTION_REPORT,
                            "Communications protocol has been set to 'console' mode!", Comms::END_REPORT);
                    } else {
                        // Incorrect input value!
                        REPORT(Comms::START_REPORT, Comms::WARNING_REPORT,
                            "Incorrect <mode> value ('", protocolText,"') detected! (-p, --protocol)",
                            "\nExpected values are: s/server, or c/console.", Comms::END_REPORT);
                        // Fallback to console mode
                        Comms::mode = Comms::CLI_MODE;
                    }

                    // Reinitalise the protocol with the new value
                    Comms::initalize();

                    ACTION_PROGRESS;
                }
            ),
            DEFINE_ACTION(
                "v", "version",
                "Get the plain version string. (No extra console output will be made as long as no errors occur)",
                "",
                {
                    REPORT(Comms::START_REPORT, Comms::NORMAL_REPORT, Info::version, Comms::END_REPORT);

                    // Prevent other outputs
                    InitialConfigs::Technical::terminateAfterArgs = true;
                    Comms::minimalProtocolFinalization = true;

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
                        REPORT(Comms::START_REPORT, Comms::FATAL_REPORT,
                            "Missing the <path> input argument! (-i, --input)", Comms::END_REPORT);
                        ACTION_FATAL_FAILURE;
                    }

                    // Check if the file can be opened!
                    if (!Common::Files::isFileAccessible(Base::InitialConfigs::mainPath)) {
                        // File isn't accessible!
                        REPORT(Comms::START_REPORT, Comms::FATAL_REPORT, "Input file is non-existent or inaccessible!",
                            Comms::END_REPORT);
                        ACTION_FATAL_FAILURE;
                    }

                    // Check if the file can be opened!
                    if (!Common::Files::isFrankieFile(Base::InitialConfigs::mainPath)) {
                        // File isn't accessible!
                        REPORT(Comms::START_REPORT, Comms::FATAL_REPORT,
                            "Input file is corrupted or of an invalid type! (Must use a valid .frankie file)",
                            Comms::END_REPORT);
                        ACTION_FATAL_FAILURE;
                    }

                    // Chec

                    ACTION_PROGRESS;
                }
            ),
            DEFINE_ACTION(
                "dbg-antlr-syntax", "debug-parser-antlr-syntax-test",
                "Print the parser's tokens list and initial parser output.",
                "",
                {
                    // Enable the test
                    InitialConfigs::Debug::Parser::activateAntlrSyntaxTest = true;

                    // Report status
                    REPORT(Comms::START_REPORT, Comms::ACTION_REPORT, "Enabled the ANTLR4 parser print syntax test!",
                        Comms::END_REPORT);

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
