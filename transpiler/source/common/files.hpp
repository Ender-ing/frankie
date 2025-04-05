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
        // Get the contents of a file
        extern FRANKIE_COMMON_API bool getFileContent(const std::string &filePath, std::string &store) ;
        // Get the parent folder's path
        extern FRANKIE_COMMON_API std::string getParentPath(const std::string &path, int depth = 1) ;
        extern FRANKIE_COMMON_API std::string getParentPath(const char *path, int depth = 1) ;
        // Get the current process executable directory
        extern FRANKIE_COMMON_API bool getExecutableDir(std::string &store) ;
    }
}
