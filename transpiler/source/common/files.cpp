/**
 * @brief
 * File-related functions
**/

#include "files.hpp"

// Basic C++ headers
// #include <filesystem>
#include <fstream>

namespace Common {
    // Check if a file is accessible
    bool isFileAccessible (const std::string &filePath) {
        // Check if the file is open!
        std::ifstream file(filePath);
        return file.is_open(); // FIle will be closed when out of scope
    }
}
