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
            const uint32_t blue_violet = static_cast<uint32_t>(fmt::color::blue_violet);
            const uint32_t sea_green = static_cast<uint32_t>(fmt::color::sea_green);
            const uint32_t fire_brick = static_cast<uint32_t>(fmt::color::fire_brick);
            const uint32_t red = static_cast<uint32_t>(fmt::color::red);
            const uint32_t crimson = static_cast<uint32_t>(fmt::color::crimson);
            const uint32_t white = static_cast<uint32_t>(fmt::color::white);
            const uint32_t golden_rod = static_cast<uint32_t>(fmt::color::golden_rod);
            const uint32_t light_sea_green = static_cast<uint32_t>(fmt::color::light_sea_green);
        }
        std::string format (std::string text, const uint32_t color) {
            return fmt::format(fg(static_cast<fmt::v11::color>(color)), text);
        }
    }
}
