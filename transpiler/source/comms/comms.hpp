/**
 * @brief
 * Include all used comms headers
**/

#pragma once

#include "../common/headers.hpp"
#include "dynamic.hpp" // FRANKIE_COMMS_LIB

// Include console messages
#include "CLI/basic.hpp"

namespace ProcessReport {
    // Function definition outside the class declaration (optional)
    extern FRANKIE_COMMS_LIB void reportError();
}
