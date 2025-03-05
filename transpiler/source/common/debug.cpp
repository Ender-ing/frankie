/**
 * @brief
 * Memory leak checks (Windows)
**/

#include "debug.hpp"

namespace Common {
    namespace CrtDebug {
        // Set the flags for the memory check mode!
        void initiateCrtMemoryChecks() {
            #ifdef _CRTDBG_MAP_ALLOC
                _CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF);
                _CrtSetReportMode(_CRT_WARN, _CRTDBG_MODE_DEBUG); // Set report mode to debug
            #endif
        }

        // Get all memory leak report dumps in one string variable
        std::string captureCrtDumpMemoryLeaks() {
            // Capture the output through a custom function.
            #ifdef _CRTDBG_MAP_ALLOC
                _CrtSetReportHook2(_CRT_RPTHOOK_INSTALL, [](int nRptType, char* szMsg, int* pnErrno, long* plRet) -> int {
                    static std::string capturedOutput;
                    if (nRptType == _CRT_WARN) {
                        capturedOutput += szMsg;
                    }
                    return 0; // Continue normal processing
                });

                _CrtDumpMemoryLeaks();

                _CrtSetReportHook2(_CRT_RPTHOOK_REMOVE, nullptr); // Remove the hook.

                return capturedOutput;
            #else
                return "";
            #endif
        }

        // Process the string for leaks
        // [true - leaks found, false - everything is fine!]
        bool processCrtMemoryReports() {
            #ifdef _CRTDBG_MAP_ALLOC
                std::string leakReport = captureCrtDumpMemoryLeaks();
                std::cout << CLI::format("Leak Report:\n", CLI::Color::red) << leakReport << std::endl;
                return false;
            #else
                return false; // Always return a success state! (Non-windows machines)
            #endif
        }        
    }
}
