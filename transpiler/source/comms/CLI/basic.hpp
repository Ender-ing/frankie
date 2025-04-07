/**
 * @brief
 * Include all used CLI headers
**/

#pragma once

#include "../../common/headers.hpp"
#include "../dynamic.hpp" // FRANKIE_COMMS_API

// Basic C++ headers
#include <cstdint>

namespace Comms {
    namespace CLI {
        namespace Color {
            extern FRANKIE_COMMS_API const uint32_t blue_violet;
            extern FRANKIE_COMMS_API const uint32_t sea_green;
            extern FRANKIE_COMMS_API const uint32_t red;
            extern FRANKIE_COMMS_API const uint32_t crimson;
            extern FRANKIE_COMMS_API const uint32_t white;
            extern FRANKIE_COMMS_API const uint32_t golden_rod;
            extern FRANKIE_COMMS_API const uint32_t light_sea_green;
        }
        extern FRANKIE_COMMS_API std::string color(const std::string &text, const uint32_t color) ;
    }
}
