/**
 * @brief
 * Memory leak checks (Windows)
**/

#pragma once

#include "headers.hpp"
#include "dynamic.hpp" // FRANKIE_COMMON_API

// Crt Debug headers
#ifdef _WIN32
#   ifdef FRANKIE_WINDOWS_CRTDEBUG
#       define WINDOWS_CRTDEBUG_ACTIVE
#       include <crtdbg.h>
#       define _CRTDBG_MAP_ALLOC
#       include <stdlib.h>
#   endif
#endif

namespace Common {
    namespace CrtDebug {
        // Set the flags for the memory check mode!
        extern FRANKIE_COMMON_API void initiateCrtMemoryChecks() ;

        // Get all memory leak report dumps in one string variable
        extern FRANKIE_COMMON_API std::string captureCrtDumpMemoryLeaks() ;

        // Process the string for leaks
        // [true - leaks found, false - everything is fine!]
        extern FRANKIE_COMMON_API bool processCrtMemoryReports() ;
    }
}
