/**
 * @brief
 * Enable uniform reports for both consoles and IDEs
**/

// Basic C++ headers
#include <sstream>

#include "comms.hpp"

namespace Comms {
    // Communication mode
    // (may need to introduce more complex modes!)
    Mode mode = CLI_MODE; // defaults to CLI mode!

    // Handle error throw statement
    static void throwError(std::string msg) {
        std::cerr << CLI::format("[Internal Error] ", Comms::CLI::Color::red) << CLI::format(msg, Comms::CLI::Color::red) << CLI::format("\nPossible memory leaks/bad code. Please contact the developers of PolarFrankie!", Comms::CLI::Color::red) << std::endl;
        throw std::runtime_error(msg);
    }

    // General Transpiler status
    namespace ProcessReport {
        // It may become necessary to introduce static tracking variables to keep up with more complex error reports
        // to support LSP!
        int programStatus = 0; // Default: 0 (success)
        // Keep track of the reporting status
        bool didSendReport = false;
    }

    // Report-specific status
    namespace IndividualReport {
        // Current reporting status!
        bool isNew = true; // Check if this is a new report!
        ReportType type;
        ReportBodyData messageBodyData = {}; // report message data!

        // Reset report data!
        static void reset() {
            isNew = true;
            // Report details
            type = NORMAL_REPORT;
            messageBodyData.clear();
        }

        // Send report data!
        static void send() {
            if (IndividualReport::isNew) {
                throwError("Attempting to send an untouched/incorrectly initialised Comms::IndividualReport!");
            }
            if(!ProcessReport::didSendReport){
                ProcessReport::didSendReport = true;
            }
            // Send report data to CLI/LSP
            if (mode == CLI_MODE) {
                // Print report details
                CLI::Reports::print();
            } else if (mode == LSP_MODE) {
                throwError("Currently, 'LSP' Comms::mode is not supported!");
            } else {
                throwError("Unsupported Comms::mode value!"); 
            }
            // Reset report data
            reset();
        }
    }

    // Internal library members!
    namespace ReportInternals {
        // Handle control input processing
        static void processReportControl(const ReportInput& arg) {
            // Arguments that are used to send instructions!
            if (std::holds_alternative<ReportAction>(arg)) {
                ReportAction value = std::get<ReportAction>(arg);
                if (value == START_REPORT){
                    if (!IndividualReport::isNew) {
                        throwError("Attempting to start a new Comms::IndividualReport without ending the previous one!"); 
                    }
                    IndividualReport::isNew = false;
                } else if (value == END_REPORT) {
                    // Send report data
                    IndividualReport::send();
                } else {
                    throwError("Unknown Comms::ReportAction value!"); 
                }
            } else if (std::holds_alternative<ReportType>(arg)) {
                ReportType value = std::get<ReportType>(arg);
                // Update program status
                if (value == CRITICAL_REPORT) {
                    // Update program status to 'failure'
                    ProcessReport::programStatus = 1;
                }

                // Update report status
                if (value == NORMAL_REPORT || value == WARNING_REPORT || value == CRITICAL_REPORT ||
                    value == FATAL_REPORT || value == ACTION_REPORT || value == DEBUG_REPORT) {
                    IndividualReport::type = value;
                } else {
                    throwError("Unknown Comms::ReportType value!"); 
                }
            } else {
                throwError("Unknown Comms::report control argument type!");
            }
        }

        // Handle user input processing
        static void processReportInput(const ReportInput& arg) {
            // Check if it's data that should saved, or printed!
            bool isMessageBody = true;
            std::stringstream text;
            // Check arg type
            if (std::holds_alternative<std::string>(arg)) {
                std::string value = std::get<std::string>(arg);
                // TMP
                text << value;
            } else if (std::holds_alternative<size_t>(arg)) {
                size_t value = std::get<size_t>(arg);
                // TMP
                text << value;
                // Check for line and column numbers!
                // ...
                // isMessageBody = false
            } else {
                throwError("Unknown Comms::report input argument type!"); 
            }

            // Save message body data
            if (isMessageBody) {
                IndividualReport::messageBodyData.push_back(text.str());
            }
        }
    }

    // Type group checks
    template <typename... Types, typename Variant>
    bool holdsAlternatives(const Variant& variant) {
        return (std::holds_alternative<Types>(variant) || ...); // Fold expression
    }

    // Reporting
    void report(const ReportInputs& args) {
        for (const auto& arg : args) {
            if (holdsAlternatives<REPORT_BASIC_TYPES>(arg)) {
                ReportInternals::processReportControl(arg);
            } else if (holdsAlternatives<REPORT_INPUT_TYPES>(arg)) {
                ReportInternals::processReportInput(arg);
            } else {
                throwError("Unknown Comms::report argument type!"); 
            }
        }
    }

    // Initalise protocol
    void initalize() {
        if(mode == CLI_MODE){
            // Initialise CLI mode
            CLI::initialize(); //TMP
        } else if(mode == LSP_MODE){
            // Initialise LSP mode
            // ...
        } else {
            throwError("Unknown Comms::mode value!"); 
        }
    }

    // Keep track of finalisation
    static bool isFinalized = false;

    // Finalise protocol
    void finalize() {
        // Check for unwanted called
        if (isFinalized) {
            throwError("Detecting multiple protocol finalisation attempts!");
        }
        isFinalized = true;

        if(mode == CLI_MODE){
            // Finalize CLI mode
            CLI::finalize(); //TMP
        } else if(mode == LSP_MODE){
            // Finalize LSP mode
            // ...
        } else {
            throwError("Unknown Comms::mode value!"); 
        }

        // Check for unfinished reports
        if(ProcessReport::didSendReport && !IndividualReport::isNew){
            throwError("Detected an unfinished report!");
        }
    }
}
