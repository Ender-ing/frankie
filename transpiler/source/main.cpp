/**
 * @brief
 * PolarFrankie Transpiler
**/

// Basic C++ headers
#include <iostream>
#include <fstream>
#include <sstream>

// Common headers
#include "common/headers.hpp"
#include "common/debug.hpp"

// CLI/LSP
#include "comms/comms.hpp"

// Configs
#include "config.hpp"

// Parser imports
#include "parser/parser.hpp"

int main (int argc, const char *argv[]) {
    // Test for memory leaks
    Common::CrtDebug::initiateCrtMemoryChecks();

    // Update initial configurations
    if(!(InitialConfigs::updateUsingArgs (argc, argv))){
        // This process failed!
        std::cerr << CLI::format("COULDN'T PROCESS TRANSPILER ARGUMENTS!", CLI::Color::red) << std::endl;
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
            std::cerr << CLI::format("Error opening file: ", CLI::Color::red) << filename << std::endl; // Fail!
            return 1;
        }
        // Debug
        FrankieParser::debug(file_contents);
    }

    std::cout << CLI::format("Done!", CLI::Color::green) << std::endl;

    // Handle memory check results
    if(Common::CrtDebug::processCrtMemoryReports()){
        // Exist with an error on memory leaks!
        return 1;
    }

    // Return a success
    return 0;
}
