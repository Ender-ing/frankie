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

// Base
#include "config.base.hpp"
#include "info.base.hpp"

// Parser imports
#include "parser/parser.hpp"

int main (int argc, const char *argv[]) {
    // Test for memory leaks
    Common::CrtDebug::initiateCrtMemoryChecks();

    // Update initial configurations
    if(!(Base::InitialConfigs::updateUsingArgs (argc, argv))){
        // This process failed!
        REPORT(Comms::START_REPORT, Comms::CRITICAL_REPORT, "Terminating program due to the previous error(s)!", Comms::END_REPORT);
        return Comms::ProcessReport::programStatus;
    }

    // Check for --version
    if (Base::InitialConfigs::Technical::versionOnlyMode) {
        REPORT(Comms::START_REPORT, Comms::NORMAL_REPORT, Base::Info::version, Comms::END_REPORT);
        // End the program!
        // (This is done to make sure only the version information gets printed for simple technical use!)
        return Comms::ProcessReport::programStatus;
    }

    // Initalise communications protocol
    Comms::initalize();

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

    REPORT(Comms::START_REPORT, Comms::ACTION_REPORT, "Done!", Comms::END_REPORT);

    // Check for unfinished reports
    if(Comms::ProcessReport::didSendReport && !Comms::IndividualReport::isNew){
        const std::string msg = "Detected an unfinished report! Possible memory leaks/bad code, please contact the developers of PolarFrankie!";
        std::cerr << Comms::CLI::format("[Thrown Error] ", Comms::CLI::Color::red) << Comms::CLI::format(msg, Comms::CLI::Color::red) << std::endl;
        throw std::runtime_error(msg);
        return 1;
    }
    
    // Handle memory check results
    if(Common::CrtDebug::processCrtMemoryReports()){
        // Exist with an error on memory leaks!
        return 1;
    }

    // Return a success
    return Comms::ProcessReport::programStatus;
}
