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
            extern FRANKIE_COMMS_API const uint32_t black;
            extern FRANKIE_COMMS_API const uint32_t blue_violet;
            extern FRANKIE_COMMS_API const uint32_t fuchsia;
            extern FRANKIE_COMMS_API const uint32_t gray;
            extern FRANKIE_COMMS_API const uint32_t green;
            extern FRANKIE_COMMS_API const uint32_t green_yellow;
            extern FRANKIE_COMMS_API const uint32_t light_gray;
            extern FRANKIE_COMMS_API const uint32_t lime_green;
            extern FRANKIE_COMMS_API const uint32_t mint_cream;
            extern FRANKIE_COMMS_API const uint32_t orange;
            extern FRANKIE_COMMS_API const uint32_t orange_red;
            extern FRANKIE_COMMS_API const uint32_t fire_brick;
            extern FRANKIE_COMMS_API const uint32_t red;
            extern FRANKIE_COMMS_API const uint32_t crimson;
            extern FRANKIE_COMMS_API const uint32_t sky_blue;
            extern FRANKIE_COMMS_API const uint32_t white;
            extern FRANKIE_COMMS_API const uint32_t yellow;
        }
        extern FRANKIE_COMMS_API std::string format (std::string text, const uint32_t color) ;
    }
}
