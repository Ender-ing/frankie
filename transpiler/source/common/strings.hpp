/**
 * @brief 
 * String-related functions
**/

#pragma once

#include "headers.hpp"
#include "dynamic.hpp" // FRANKIE_COMMON_LIB

// Basic C++ headers
#include <string>
#include <algorithm>
#include <cctype>

namespace Common {
    namespace Strings {
        // Convert a std::string into lowercase format
        extern FRANKIE_COMMON_LIB void toLowerCase(std::string &str) ;

        // Make a lowercase copy of a std::string
        extern FRANKIE_COMMON_LIB std::string copyToLowerCase(const std::string &str) ;
    }
}
