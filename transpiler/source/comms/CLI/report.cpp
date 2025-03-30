/**
 * @brief
 * Handle CLI report displays
**/

#include "report.hpp"

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

            // Print report details
            void print() {
                // Track output data printing
                uint32_t color;
                int channel = 0; // [0 -> cout, 1 -> cerr]
                auto print = [&channel, &color](std::string data) {
                    // {fmt}
                    sanitize(data);

                    // Choose the output channel
                    if (channel == 0) {
                        std::cout << Comms::CLI::format(data, color) << std::flush;
                    } else {
                        std::cerr << Comms::CLI::format(data, color) << std::flush;
                    }
                };

                if (IndividualReport::type == WARNING_REPORT) {
                    color = Color::yellow;
                    channel = 1;
                    // Title
                    print("[Warning] (TYPE?) ");
                } else if (IndividualReport::type == CRITICAL_REPORT) {
                    color = Color::crimson;
                    channel = 1;
                    // Title
                    print("[Error] (TYPE?) ");
                } else if (IndividualReport::type == FATAL_REPORT) {
                    color = Color::fire_brick;
                    channel = 1;
                    // Title
                    print("[Fatal Error] (TYPE?) ");
                } else if (IndividualReport::type == ACTION_REPORT) {
                    color = Color::lime_green;
                    channel = 1;
                    // Title
                    print("[Action] (TYPE?) ");
                } else if (IndividualReport::type == DEBUG_REPORT) {
                    color = Color::blue_violet;
                    channel = 0;
                    // Title
                    print("[Debug] (TYPE?) ");
                } else {
                    color = Color::white;
                    channel = 0;
                }

                // TMP
                for (auto& data : IndividualReport::messageBodyData) {
                    print(data);
                }
                if (channel == 0) {
                    std::cout << std::endl;
                } else {
                    std::cerr << std::endl;
                }
            }
        }
    }
}
