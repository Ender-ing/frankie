/**
 * @brief 
 * PolarFrankie Transpiler
**/

#include "common/headers.hpp"

// Basic C++ headers
#include <iostream>
#include <fstream>
#include <sstream>

// Configs
#include "config.hpp"

// Parser imports
#include "parser/parser.hpp"

int main (int argc, const char *argv[]) {
    // Update initial configurations
    if(!(InitialConfigs::updateUsingArgs (argc, argv))){
        // This process failed!
        std::cerr << fmt::format(fg(fmt::color::red), "COULDN'T PROCESS TRANSPILER ARGUMENTS!") << std::endl;
        return 1;
    }

    // TMP
    if (InitialConfigs::Debug::ParserBasicPrintTest::active) {
        auto filename = InitialConfigs::Debug::ParserBasicPrintTest::path;
        // Check first input argument path
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
        FrankieParser::debug(file_contents);
    }

    std::cout << fmt::format(fg(fmt::color::green), "Done!") << std::endl;
    return 0;
}