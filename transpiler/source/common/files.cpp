/**
 * @brief
 * File-related functions
**/

#include "files.hpp"

// Basic C++ headers
#include <filesystem>
#include <fstream>

namespace fs = std::filesystem;

namespace Common {
    namespace Files {
        // Check if a file is accessible
        bool isFileAccessible(const std::string &filePath) {
            // Check if the file is open!
            std::ifstream file(filePath);
            return file.is_open(); // FIle will be closed when out of scope
        }
        // Check if a file is a valid frankie file
        bool isFrankieFile(const std::string &filePath) {
            // Check file extension
            fs::path filePathObj = filePath;
            std::string extension = filePathObj.extension().string();
            return (extension == ".frankie");
            // TO-DO: Add a file data checker!
        }
    }
}
