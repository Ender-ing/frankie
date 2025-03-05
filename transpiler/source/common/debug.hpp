/**
 * @brief
 * Memory leak checks (Windows)
**/

#pragma once

#include "headers.hpp"

// Crt Debug headers
#ifdef _WIN32
#   include <crtdbg.h>
#   ifdef _DEBUG
#       define _CRTDBG_MAP_ALLOC
#       include <stdlib.h>
#   endif
#endif

namespace Common {
    namespace CrtDebug {
        // Set the flags for the memory check mode!
        extern DYNAMIC_API void initiateCrtMemoryChecks() ;
        
        // Get all memory leak report dumps in one string variable
        extern DYNAMIC_API std::string captureCrtDumpMemoryLeaks() ;
        
        // Process the string for leaks
        // [true - leaks found, false - everything is fine!]
        extern DYNAMIC_API bool processCrtMemoryReports() ;
    }
}
