/**
 * @brief
 * Include all used CLI headers
**/

// {fmt}
#include <fmt/format.h>
#include <fmt/color.h>

// Basic C++ headers
#include <string>

namespace CLI {
    namespace Color {
        fmt::v11::color black = fmt::color::black;
        fmt::v11::color blue = fmt::color::blue;
        fmt::v11::color blue_violet = fmt::color::blue_violet;
        fmt::v11::color crimson = fmt::color::crimson;
        fmt::v11::color cyan = fmt::color::cyan;
        fmt::v11::color deep_pink = fmt::color::deep_pink;
        fmt::v11::color fuchsia = fmt::color::fuchsia;
        fmt::v11::color gold = fmt::color::gold;
        fmt::v11::color golden_rod = fmt::color::golden_rod;
        fmt::v11::color gray = fmt::color::gray;
        fmt::v11::color green = fmt::color::green;
        fmt::v11::color green_yellow = fmt::color::green_yellow;
        fmt::v11::color lavender = fmt::color::lavender;
        fmt::v11::color lavender_blush = fmt::color::lavender_blush;
        fmt::v11::color lawn_green = fmt::color::lawn_green;
        fmt::v11::color light_blue = fmt::color::light_blue;
        fmt::v11::color light_cyan = fmt::color::light_cyan;
        fmt::v11::color light_gray = fmt::color::light_gray;
        fmt::v11::color light_green = fmt::color::light_green;
        fmt::v11::color light_steel_blue = fmt::color::light_steel_blue;
        fmt::v11::color light_yellow = fmt::color::light_yellow;
        fmt::v11::color lime = fmt::color::lime;
        fmt::v11::color magenta = fmt::color::magenta;
        fmt::v11::color maroon = fmt::color::maroon;
        fmt::v11::color midnight_blue = fmt::color::midnight_blue;
        fmt::v11::color mint_cream = fmt::color::mint_cream;
        fmt::v11::color orange = fmt::color::orange;
        fmt::v11::color orange_red = fmt::color::orange_red;
        fmt::v11::color orchid = fmt::color::orchid;
        fmt::v11::color pale_golden_rod = fmt::color::pale_golden_rod;
        fmt::v11::color peach_puff = fmt::color::peach_puff;
        fmt::v11::color pink = fmt::color::pink;
        fmt::v11::color plum = fmt::color::plum;
        fmt::v11::color powder_blue = fmt::color::powder_blue;
        fmt::v11::color purple = fmt::color::purple;
        fmt::v11::color rebecca_purple = fmt::color::rebecca_purple;
        fmt::v11::color red = fmt::color::red;
        fmt::v11::color rosy_brown = fmt::color::rosy_brown;
        fmt::v11::color royal_blue = fmt::color::royal_blue;
        fmt::v11::color salmon = fmt::color::salmon;
        fmt::v11::color sandy_brown = fmt::color::sandy_brown;
        fmt::v11::color silver = fmt::color::silver;
        fmt::v11::color sky_blue = fmt::color::sky_blue;
        fmt::v11::color slate_blue = fmt::color::slate_blue;
        fmt::v11::color slate_gray = fmt::color::slate_gray;
        fmt::v11::color snow = fmt::color::snow;
        fmt::v11::color spring_green = fmt::color::spring_green;
        fmt::v11::color steel_blue = fmt::color::steel_blue;
        fmt::v11::color white = fmt::color::white;
        fmt::v11::color yellow = fmt::color::yellow;
    }
    auto format (std::string text, fmt::v11::color color) {
        return fmt::format(fg(color), text);
    }
}
