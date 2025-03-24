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
                // TMP
                uint32_t color;
                if (IndividualReport::type == CRITICAL_REPORT) {
                    color = Color::red;
                } else if (IndividualReport::type == WARNING_REPORT) {
                    color = Color::yellow;
                } else {
                    color = Color::white;
                }

                // TMP
                for (auto& data : IndividualReport::messageBodyData) {
                    sanitize(data);
                    std::cerr << Comms::CLI::format(data, color) << std::flush;
                }
                std::cerr << std::endl;
            }
        }
    }
}
