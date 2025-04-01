/**
 * @brief 
 * File-related functions
**/

#pragma once

#include "headers.hpp"
#include "dynamic.hpp" // FRANKIE_COMMON_API

// Basic C++ headers
//#include <string>

namespace Common {
    namespace Files {
        // Check if a file is accessible
        extern FRANKIE_COMMON_API bool isFileAccessible(const std::string &filePath) ;
        // Check if a file is a valid frankie file
        extern FRANKIE_COMMON_API bool isFrankieFile(const std::string &filePath) ;
    }
}
