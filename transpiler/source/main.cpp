
// Basic configurations
#pragma execution_character_set("utf-8")

// Basic C++ headers
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>

// Include platform headers
#ifdef _WIN32
    #include <Windows.h>
#elif defined(__linux__) // Linux
  #include <unistd.h>
#elif defined(__APPLE__) // macOS (and other Apple platforms)
  #include <mach/mach_time.h>
#else
  // ???
#endif

// CLI basic imports
#include "comms/comms.hpp"
#include "parser/parser.cpp"

int main (int argc, const char *argv[]) {

    // Check args
    if (argc < 2) {
        std::cerr << fmt::format(fg(fmt::color::red), "Expecting a file path!") << std::endl;
        return 1; // Fail!
    }

    // Check first input argument path
    auto filename = argv[1];
    std::ifstream file(filename);

    // Check if the file actually exists and get its contents
    std::string file_contents;
    if (file.is_open()) {
        // Get all file stream
        std::stringstream buffer;
        buffer << file.rdbuf();

        // Get the file as a string
        file_contents = buffer.str();

        // Close file
        file.close();
    } else {
        std::cerr << fmt::format(fg(fmt::color::red), "Error opening file: ") << filename << std::endl; // Fail!
        return 1;
    }

    // Debug
    Parser::debug(file_contents);

    return 0;
}