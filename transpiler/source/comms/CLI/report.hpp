/**
 * @brief
 * Include all used report headers
**/

#pragma once

#include "../../common/headers.hpp"
#include "../dynamic.hpp" // FRANKIE_COMMS_API

namespace Comms {
    namespace CLI {
        // Handle reports CLI outputs
        namespace Reports {
            // Print report details
            extern FRANKIE_COMMS_API void print() ;
        }
    }
}
