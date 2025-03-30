/**
 * @brief
 * Handle CLI report displays
**/

#include "report.hpp"

// Comms headers
#include "../comms.hpp"
#include "basic.hpp"

// Shortent the syntax for printing to the console
#define INTERNAL_C_OUT(DATA, CHANNEL_VAR)                   \
    if (CHANNEL_VAR == 0) {                                 \
        std::cout << DATA << std::flush;                    \
    } else {                                                \
        std::cerr << DATA << std::flush;                    \
    }                                                       \

namespace Comms {
    namespace CLI {
        // Handle reports CLI outputs
        namespace Reports {
            // Sanitise strings for console output
            static void sanitize(std::string &str) {
                // Symbols to replace ({fmt})
                static std::array<std::array<std::string, 2>, 2> symbols = {
                    std::array<std::string, 2>{"{", "{{"},
                    std::array<std::string, 2>{"}", "}}"}
                };

                // Replace all symbols
                for (const auto& pair : symbols) {
                    size_t pos = 0;
                    while ((pos = str.find(pair[0], pos)) != std::string::npos) {
                        str.replace(pos, 1, pair[1]); // Replace 1 char at pos with newString
                        pos += pair[1].length(); // Move past the replaced string
                    }
                }
            }

            // Keep track of print statistics
            static bool isFirstPrint = true;

            // Print report details
            void print() {
                // Track output data printing
                uint32_t color;
                int channel = 0; // [0 -> cout, 1 -> cerr]
                bool shouldPrompt = true;
                std::string prompt;
                auto print = [&channel, &color](std::string data) {
                    // {fmt}
                    sanitize(data);

                    // Print to the chosen output channel
                    INTERNAL_C_OUT(Comms::CLI::format(data, color), channel);
                };

                if (IndividualReport::type == WARNING_REPORT) {
                    color = Color::yellow;
                    channel = 1;
                    // Title
                    prompt = "[Warning] (TYPE?) ";
                } else if (IndividualReport::type == CRITICAL_REPORT) {
                    color = Color::crimson;
                    channel = 1;
                    // Title
                    prompt = "[Error] (TYPE?) ";
                } else if (IndividualReport::type == FATAL_REPORT) {
                    color = Color::fire_brick;
                    channel = 1;
                    // Title
                    prompt = "[Fatal Error] (TYPE?) ";
                } else if (IndividualReport::type == ACTION_REPORT) {
                    color = Color::lime_green;
                    channel = 1;
                    // Title
                    prompt = "[Action] (TYPE?) ";
                } else if (IndividualReport::type == DEBUG_REPORT) {
                    color = Color::blue_violet;
                    channel = 0;
                    // Title
                    prompt = "[Debug] (TYPE?) ";
                } else {
                    color = Color::white;
                    channel = 0;
                    // No prompts
                    shouldPrompt = false;
                }

                // Print a new line for new reports
                if (!isFirstPrint) {
                    INTERNAL_C_OUT(std::endl, channel);
                }
                
                // Print report type info
                if (shouldPrompt) {
                    print(prompt);
                }

                // TMP
                for (auto& data : IndividualReport::messageBodyData) {
                    print(data);
                }

                // Update print statistics
                if (isFirstPrint) {
                    isFirstPrint = false;
                }
            }
        }
    }
}
