/**
 * @brief
 * Include all used CLI headers
**/

// {fmt}
#include <fmt/format.h>
#include <fmt/color.h>

#include "basic.hpp"

namespace Comms {
    namespace CLI {
        namespace Color {
            const uint32_t black = static_cast<uint32_t>(fmt::color::black);
            const uint32_t blue = static_cast<uint32_t>(fmt::color::blue);
            const uint32_t blue_violet = static_cast<uint32_t>(fmt::color::blue_violet);
            const uint32_t crimson = static_cast<uint32_t>(fmt::color::crimson);
            const uint32_t cyan = static_cast<uint32_t>(fmt::color::cyan);
            const uint32_t deep_pink = static_cast<uint32_t>(fmt::color::deep_pink);
            const uint32_t fuchsia = static_cast<uint32_t>(fmt::color::fuchsia);
            const uint32_t gold = static_cast<uint32_t>(fmt::color::gold);
            const uint32_t golden_rod = static_cast<uint32_t>(fmt::color::golden_rod);
            const uint32_t gray = static_cast<uint32_t>(fmt::color::gray);
            const uint32_t green = static_cast<uint32_t>(fmt::color::green);
            const uint32_t green_yellow = static_cast<uint32_t>(fmt::color::green_yellow);
            const uint32_t lavender = static_cast<uint32_t>(fmt::color::lavender);
            const uint32_t lavender_blush = static_cast<uint32_t>(fmt::color::lavender_blush);
            const uint32_t lawn_green = static_cast<uint32_t>(fmt::color::lawn_green);
            const uint32_t light_blue = static_cast<uint32_t>(fmt::color::light_blue);
            const uint32_t light_cyan = static_cast<uint32_t>(fmt::color::light_cyan);
            const uint32_t light_gray = static_cast<uint32_t>(fmt::color::light_gray);
            const uint32_t light_green = static_cast<uint32_t>(fmt::color::light_green);
            const uint32_t light_steel_blue = static_cast<uint32_t>(fmt::color::light_steel_blue);
            const uint32_t light_yellow = static_cast<uint32_t>(fmt::color::light_yellow);
            const uint32_t lime = static_cast<uint32_t>(fmt::color::lime);
            const uint32_t magenta = static_cast<uint32_t>(fmt::color::magenta);
            const uint32_t maroon = static_cast<uint32_t>(fmt::color::maroon);
            const uint32_t midnight_blue = static_cast<uint32_t>(fmt::color::midnight_blue);
            const uint32_t mint_cream = static_cast<uint32_t>(fmt::color::mint_cream);
            const uint32_t orange = static_cast<uint32_t>(fmt::color::orange);
            const uint32_t orange_red = static_cast<uint32_t>(fmt::color::orange_red);
            const uint32_t orchid = static_cast<uint32_t>(fmt::color::orchid);
            const uint32_t pale_golden_rod = static_cast<uint32_t>(fmt::color::pale_golden_rod);
            const uint32_t peach_puff = static_cast<uint32_t>(fmt::color::peach_puff);
            const uint32_t pink = static_cast<uint32_t>(fmt::color::pink);
            const uint32_t plum = static_cast<uint32_t>(fmt::color::plum);
            const uint32_t powder_blue = static_cast<uint32_t>(fmt::color::powder_blue);
            const uint32_t purple = static_cast<uint32_t>(fmt::color::purple);
            const uint32_t rebecca_purple = static_cast<uint32_t>(fmt::color::rebecca_purple);
            const uint32_t red = static_cast<uint32_t>(fmt::color::red);
            const uint32_t rosy_brown = static_cast<uint32_t>(fmt::color::rosy_brown);
            const uint32_t royal_blue = static_cast<uint32_t>(fmt::color::royal_blue);
            const uint32_t salmon = static_cast<uint32_t>(fmt::color::salmon);
            const uint32_t sandy_brown = static_cast<uint32_t>(fmt::color::sandy_brown);
            const uint32_t silver = static_cast<uint32_t>(fmt::color::silver);
            const uint32_t sky_blue = static_cast<uint32_t>(fmt::color::sky_blue);
            const uint32_t slate_blue = static_cast<uint32_t>(fmt::color::slate_blue);
            const uint32_t slate_gray = static_cast<uint32_t>(fmt::color::slate_gray);
            const uint32_t snow = static_cast<uint32_t>(fmt::color::snow);
            const uint32_t spring_green = static_cast<uint32_t>(fmt::color::spring_green);
            const uint32_t steel_blue = static_cast<uint32_t>(fmt::color::steel_blue);
            const uint32_t white = static_cast<uint32_t>(fmt::color::white);
            const uint32_t yellow = static_cast<uint32_t>(fmt::color::yellow);
        }
        std::string format (std::string text,     const uint32_t color) {
            return fmt::format(fg(static_cast<fmt::v11::color>(color)), text);
        }
    }
}
