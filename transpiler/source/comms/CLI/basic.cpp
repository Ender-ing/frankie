/**
 * @brief
 * Include all used CLI headers
**/

// {fmt}
#include <fmt/format.h>
#include <fmt/color.h>

#include "basic.hpp"

namespace CLI {
    namespace Color {
        uint32_t black = static_cast<uint32_t>(fmt::color::black);
        uint32_t blue = static_cast<uint32_t>(fmt::color::blue);
        uint32_t blue_violet = static_cast<uint32_t>(fmt::color::blue_violet);
        uint32_t crimson = static_cast<uint32_t>(fmt::color::crimson);
        uint32_t cyan = static_cast<uint32_t>(fmt::color::cyan);
        uint32_t deep_pink = static_cast<uint32_t>(fmt::color::deep_pink);
        uint32_t fuchsia = static_cast<uint32_t>(fmt::color::fuchsia);
        uint32_t gold = static_cast<uint32_t>(fmt::color::gold);
        uint32_t golden_rod = static_cast<uint32_t>(fmt::color::golden_rod);
        uint32_t gray = static_cast<uint32_t>(fmt::color::gray);
        uint32_t green = static_cast<uint32_t>(fmt::color::green);
        uint32_t green_yellow = static_cast<uint32_t>(fmt::color::green_yellow);
        uint32_t lavender = static_cast<uint32_t>(fmt::color::lavender);
        uint32_t lavender_blush = static_cast<uint32_t>(fmt::color::lavender_blush);
        uint32_t lawn_green = static_cast<uint32_t>(fmt::color::lawn_green);
        uint32_t light_blue = static_cast<uint32_t>(fmt::color::light_blue);
        uint32_t light_cyan = static_cast<uint32_t>(fmt::color::light_cyan);
        uint32_t light_gray = static_cast<uint32_t>(fmt::color::light_gray);
        uint32_t light_green = static_cast<uint32_t>(fmt::color::light_green);
        uint32_t light_steel_blue = static_cast<uint32_t>(fmt::color::light_steel_blue);
        uint32_t light_yellow = static_cast<uint32_t>(fmt::color::light_yellow);
        uint32_t lime = static_cast<uint32_t>(fmt::color::lime);
        uint32_t magenta = static_cast<uint32_t>(fmt::color::magenta);
        uint32_t maroon = static_cast<uint32_t>(fmt::color::maroon);
        uint32_t midnight_blue = static_cast<uint32_t>(fmt::color::midnight_blue);
        uint32_t mint_cream = static_cast<uint32_t>(fmt::color::mint_cream);
        uint32_t orange = static_cast<uint32_t>(fmt::color::orange);
        uint32_t orange_red = static_cast<uint32_t>(fmt::color::orange_red);
        uint32_t orchid = static_cast<uint32_t>(fmt::color::orchid);
        uint32_t pale_golden_rod = static_cast<uint32_t>(fmt::color::pale_golden_rod);
        uint32_t peach_puff = static_cast<uint32_t>(fmt::color::peach_puff);
        uint32_t pink = static_cast<uint32_t>(fmt::color::pink);
        uint32_t plum = static_cast<uint32_t>(fmt::color::plum);
        uint32_t powder_blue = static_cast<uint32_t>(fmt::color::powder_blue);
        uint32_t purple = static_cast<uint32_t>(fmt::color::purple);
        uint32_t rebecca_purple = static_cast<uint32_t>(fmt::color::rebecca_purple);
        uint32_t red = static_cast<uint32_t>(fmt::color::red);
        uint32_t rosy_brown = static_cast<uint32_t>(fmt::color::rosy_brown);
        uint32_t royal_blue = static_cast<uint32_t>(fmt::color::royal_blue);
        uint32_t salmon = static_cast<uint32_t>(fmt::color::salmon);
        uint32_t sandy_brown = static_cast<uint32_t>(fmt::color::sandy_brown);
        uint32_t silver = static_cast<uint32_t>(fmt::color::silver);
        uint32_t sky_blue = static_cast<uint32_t>(fmt::color::sky_blue);
        uint32_t slate_blue = static_cast<uint32_t>(fmt::color::slate_blue);
        uint32_t slate_gray = static_cast<uint32_t>(fmt::color::slate_gray);
        uint32_t snow = static_cast<uint32_t>(fmt::color::snow);
        uint32_t spring_green = static_cast<uint32_t>(fmt::color::spring_green);
        uint32_t steel_blue = static_cast<uint32_t>(fmt::color::steel_blue);
        uint32_t white = static_cast<uint32_t>(fmt::color::white);
        uint32_t yellow = static_cast<uint32_t>(fmt::color::yellow);
    }
    std::string format (std::string text, uint32_t color) {
        return fmt::format(fg(fmt::v11::color(color)), text);
    }
}
