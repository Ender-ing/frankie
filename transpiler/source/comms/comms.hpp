/**
 * @brief
 * Include all used comms headers
**/

#pragma once

#include "../common/headers.hpp"
#include "dynamic.hpp" // FRANKIE_COMMS_API

// Basic C++ headers
#include <variant>

// Include comms headers
#include "CLI/basic.hpp"
#include "CLI/report.hpp"
#include "CLI/initialize.hpp"
#include "CLI/finalize.hpp"

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
    extern FRANKIE_COMMS_API Mode mode;

    // General Transpiler status
    namespace ProcessReport {
        // It may become necessary to introduce static tracking variables to keep up with more complex error reports
        // to support LSP!
        extern FRANKIE_COMMS_API int programStatus;
        // Keep track of the reporting status
        extern FRANKIE_COMMS_API bool didSendReport;
    }

    // Report actions
    enum ReportAction {
        START_REPORT = 0xFFF00101, // Used as a measure to prevent the misuse of the report function
        END_REPORT = 0xFFF00102, // Used to send and reset report data!
        SET_STAGE_TITLE = 0xFFF00103 // Sets the stage of the report (e.g. lexer, parser, etc.)
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

    // Report-specific status
    namespace IndividualReport {
        // Current reporting status!
        extern FRANKIE_COMMS_API bool isNew; // Check if this is a new report!
        extern FRANKIE_COMMS_API ReportType type;
        extern FRANKIE_COMMS_API std::string stage;
        extern FRANKIE_COMMS_API std::stringstream messageStream;
    }

    // Keep track of general report statistics
    namespace Statistics {
        extern FRANKIE_COMMS_API int normalReports;
        extern FRANKIE_COMMS_API int warningReports;
        extern FRANKIE_COMMS_API int criticalReports;
        extern FRANKIE_COMMS_API int fatalReports;
        extern FRANKIE_COMMS_API int actionReports;
        extern FRANKIE_COMMS_API int debugReports;
    }

    // Reporting
    extern FRANKIE_COMMS_API void report(const ReportInputs& args) ;

    // Initalise protocol
    extern FRANKIE_COMMS_API void initalize() ;

    // For actions that require minimal finalisation!
    extern FRANKIE_COMMS_API bool minimalProtocolFinalization;

    // Finalise protocol
    extern FRANKIE_COMMS_API void finalize() ;
}
