/**
 * @brief
 * Include all used comms headers
**/

#pragma once

#include "../common/headers.hpp"
#include "dynamic.hpp" // FRANKIE_COMMS_LIB

// Basic C++ headers
#include <variant>

// Include comms headers
#include "CLI/basic.hpp"
#include "CLI/report.hpp"

// Pack the report function into a macro
#define REPORT(...)                                                 \
    Comms::report(Comms::ReportInputs{__VA_ARGS__})                 \

namespace Comms {
    // Communication mode
    // (may need to introduce more complex modes!)
    enum Mode {
        CLI_MODE = 0xFFF00001,
        LSP_MODE = 0xFFF00002
    };
    extern FRANKIE_COMMS_LIB Mode mode;

    // General Transpiler status
    namespace ProcessReport {
        // It may become necessary to introduce static tracking variables to keep up with more complex error reports
        // to support LSP!
        extern FRANKIE_COMMS_LIB int programStatus;
        // Keep track of the reporting status
        extern FRANKIE_COMMS_LIB bool didSendReport;
    }

    // Report actions
    enum ReportAction {
        START_REPORT = 0xFFF00101, // Used as a measure to prevent the misuse of the report function
        END_REPORT = 0xFFF00102 // Used to send and reset report data!
    };
    // Report types
    enum ReportType {
        NORMAL_REPORT = 0xFFF00201, // Used for general reports
        WARNING_REPORT = 0xFFF00202, // Used for warnings
        CRITICAL_REPORT = 0xFFF00203, // Used for errors
        FATAL_REPORT = 0xFFF00204, // Used for fatal errors (terminates the program)
        ACTION_REPORT = 0xFFF00205, // Used for user-invoked action confirmations
        DEBUG_REPORT = 0xFFF00206 // Used for debug/non-standard output
    };

    // Handle shared input types
    #define REPORT_BASIC_TYPES ReportType, ReportAction
    #define REPORT_INPUT_TYPES size_t, std::string
    typedef std::variant<REPORT_BASIC_TYPES, REPORT_INPUT_TYPES> ReportInput;
    typedef std::vector<ReportInput> ReportInputs;
    typedef std::vector<std::string> ReportBodyData;

    // Report-specific status
    namespace IndividualReport {
        // Current reporting status!
        extern FRANKIE_COMMS_LIB bool isNew; // Check if this is a new report!
        extern FRANKIE_COMMS_LIB ReportType type;
        extern FRANKIE_COMMS_LIB ReportBodyData messageBodyData;
    }

    // Reporting
    extern FRANKIE_COMMS_LIB void report(const ReportInputs& args) ;
}
