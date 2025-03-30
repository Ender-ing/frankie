/**
 * @brief 
 * String-related functions
**/

#pragma once

#include "headers.hpp"
#include "dynamic.hpp" // FRANKIE_COMMON_API

namespace Common {
    namespace Strings {
        // Convert a std::string into lowercase format
        extern FRANKIE_COMMON_API void toLowerCase(std::string &str) ;

        // Make a lowercase copy of a std::string
        extern FRANKIE_COMMON_API std::string copyToLowerCase(const std::string &str) ;
    }
}
