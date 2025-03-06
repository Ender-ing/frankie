/**
 * @brief
 * Include all used CLI headers
**/

#pragma once

#include "../../common/headers.hpp"
#include "../dynamic.hpp" // FRANKIE_COMMS_LIB

// Basic C++ headers
#include <cstdint>

namespace CLI {
    namespace Color {
        extern FRANKIE_COMMS_LIB const uint32_t black;
        extern FRANKIE_COMMS_LIB const uint32_t blue;
        extern FRANKIE_COMMS_LIB const uint32_t blue_violet;
        extern FRANKIE_COMMS_LIB const uint32_t crimson;
        extern FRANKIE_COMMS_LIB const uint32_t cyan;
        extern FRANKIE_COMMS_LIB const uint32_t deep_pink;
        extern FRANKIE_COMMS_LIB const uint32_t fuchsia;
        extern FRANKIE_COMMS_LIB const uint32_t gold;
        extern FRANKIE_COMMS_LIB const uint32_t golden_rod;
        extern FRANKIE_COMMS_LIB const uint32_t gray;
        extern FRANKIE_COMMS_LIB const uint32_t green;
        extern FRANKIE_COMMS_LIB const uint32_t green_yellow;
        extern FRANKIE_COMMS_LIB const uint32_t lavender;
        extern FRANKIE_COMMS_LIB const uint32_t lavender_blush;
        extern FRANKIE_COMMS_LIB const uint32_t lawn_green;
        extern FRANKIE_COMMS_LIB const uint32_t light_blue;
        extern FRANKIE_COMMS_LIB const uint32_t light_cyan;
        extern FRANKIE_COMMS_LIB const uint32_t light_gray;
        extern FRANKIE_COMMS_LIB const uint32_t light_green;
        extern FRANKIE_COMMS_LIB const uint32_t light_steel_blue;
        extern FRANKIE_COMMS_LIB const uint32_t light_yellow;
        extern FRANKIE_COMMS_LIB const uint32_t lime;
        extern FRANKIE_COMMS_LIB const uint32_t magenta;
        extern FRANKIE_COMMS_LIB const uint32_t maroon;
        extern FRANKIE_COMMS_LIB const uint32_t midnight_blue;
        extern FRANKIE_COMMS_LIB const uint32_t mint_cream;
        extern FRANKIE_COMMS_LIB const uint32_t orange;
        extern FRANKIE_COMMS_LIB const uint32_t orange_red;
        extern FRANKIE_COMMS_LIB const uint32_t orchid;
        extern FRANKIE_COMMS_LIB const uint32_t pale_golden_rod;
        extern FRANKIE_COMMS_LIB const uint32_t peach_puff;
        extern FRANKIE_COMMS_LIB const uint32_t pink;
        extern FRANKIE_COMMS_LIB const uint32_t plum;
        extern FRANKIE_COMMS_LIB const uint32_t powder_blue;
        extern FRANKIE_COMMS_LIB const uint32_t purple;
        extern FRANKIE_COMMS_LIB const uint32_t rebecca_purple;
        extern FRANKIE_COMMS_LIB const uint32_t red;
        extern FRANKIE_COMMS_LIB const uint32_t rosy_brown;
        extern FRANKIE_COMMS_LIB const uint32_t royal_blue;
        extern FRANKIE_COMMS_LIB const uint32_t salmon;
        extern FRANKIE_COMMS_LIB const uint32_t sandy_brown;
        extern FRANKIE_COMMS_LIB const uint32_t silver;
        extern FRANKIE_COMMS_LIB const uint32_t sky_blue;
        extern FRANKIE_COMMS_LIB const uint32_t slate_blue;
        extern FRANKIE_COMMS_LIB const uint32_t slate_gray;
        extern FRANKIE_COMMS_LIB const uint32_t snow;
        extern FRANKIE_COMMS_LIB const uint32_t spring_green;
        extern FRANKIE_COMMS_LIB const uint32_t steel_blue;
        extern FRANKIE_COMMS_LIB const uint32_t white;
        extern FRANKIE_COMMS_LIB const uint32_t yellow;
    }
    extern FRANKIE_COMMS_LIB std::string format (std::string text, const uint32_t color) ;
}
