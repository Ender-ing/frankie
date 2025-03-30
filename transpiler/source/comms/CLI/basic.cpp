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
            const uint32_t blue_violet = static_cast<uint32_t>(fmt::color::blue_violet);
            const uint32_t fuchsia = static_cast<uint32_t>(fmt::color::fuchsia);
            const uint32_t gray = static_cast<uint32_t>(fmt::color::gray);
            const uint32_t green = static_cast<uint32_t>(fmt::color::green);
            const uint32_t green_yellow = static_cast<uint32_t>(fmt::color::green_yellow);
            const uint32_t light_gray = static_cast<uint32_t>(fmt::color::light_gray);
            const uint32_t lime_green = static_cast<uint32_t>(fmt::color::lime_green);
            const uint32_t mint_cream = static_cast<uint32_t>(fmt::color::mint_cream);
            const uint32_t orange = static_cast<uint32_t>(fmt::color::orange);
            const uint32_t orange_red = static_cast<uint32_t>(fmt::color::orange_red);
            const uint32_t fire_brick = static_cast<uint32_t>(fmt::color::fire_brick);
            const uint32_t red = static_cast<uint32_t>(fmt::color::red);
            const uint32_t crimson = static_cast<uint32_t>(fmt::color::crimson);
            const uint32_t sky_blue = static_cast<uint32_t>(fmt::color::sky_blue);
            const uint32_t white = static_cast<uint32_t>(fmt::color::white);
            const uint32_t yellow = static_cast<uint32_t>(fmt::color::yellow);
        }
        std::string format (std::string text, const uint32_t color) {
            return fmt::format(fg(static_cast<fmt::v11::color>(color)), text);
        }
    }
}
