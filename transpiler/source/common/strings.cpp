/**
 * @brief 
 * String-related functions
**/

#include "strings.hpp"

namespace Common {
    namespace Strings {
        // Convert a std::string into lowercase format
        void toLowerCase(std::string &str) {
            // Transform it letter by letter
            std::transform(str.begin(), str.end(), str.begin(), [](unsigned char c){ return std::tolower(c); });
        }

        // Make a lowercase copy of a std::string
        std::string copyToLowerCase(const std::string &str) {
            // Copy the string
            std::string result (str);
            // Transform it
            toLowerCase(result);
            // Return the new string
            return result;
        }
    }
}
