/**
 * @brief
 * PolarFrankie Transpiler
**/

// Basic C++ headers
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
    if(!(Base::InitialConfigs::updateUsingArgs (argc, argv))){
        // This process failed!

        REPORT(Comms::START_REPORT, Comms::CRITICAL_REPORT, "COULDN'T PROCESS TRANSPILER ARGUMENTS!", Comms::END_REPORT);
        return Comms::ProcessReport::programStatus;
    }

    // Set communication protocol
    if (Base::InitialConfigs::protocol == "s") {
        Comms::mode = Comms::LSP_MODE;
    } else {
        // Fallback to console mode
        Comms::mode = Comms::CLI_MODE;
    }

    // TMP
    if (Base::InitialConfigs::Debug::Parser::activateBasicPrintTest) {
        auto filename = Base::InitialConfigs::mainPath;
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
            REPORT(Comms::START_REPORT, Comms::CRITICAL_REPORT, "Error opening file: ", filename, Comms::END_REPORT);
            return Comms::ProcessReport::programStatus;
        }
        // Debug
        Parser::Debug::syntaxCheck(file_contents);
    }

    // Check for unfinished reports
    // if(Comms::ProcessReport::didSendReport && !Comms::IndividualReport::isNew){
    //     std::cerr << Comms::CLI::format("Failed to properly end a report! ", Comms::CLI::Color::red) << std::endl; // Fail!
    //     return 1;
    // }

    std::cout << Comms::CLI::format("Done!", Comms::CLI::Color::green) << std::endl;

    // Handle memory check results
    if(Common::CrtDebug::processCrtMemoryReports()){
        // Exist with an error on memory leaks!
        return 1;
    }

    // Return a success
    return Comms::ProcessReport::programStatus;
}
