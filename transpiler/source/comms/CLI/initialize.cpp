/**
 * @brief
 * Handle CLI initialisation
**/

#include "initialize.hpp"

// Comms headers
#include "basic.hpp"

namespace Comms {
    namespace CLI {
        // Track status
        static bool isInitialized = false;

        // Handle CLI initialisation
        void initialize() {
            if (isInitialized) { // TMP
                return;
            }

            /**
             *   ,-.       _,---._ __  / \
             *  /  )    .-'       `./ /   \
             * (  (   ,'            `/    /|  PolarFrankie v???
             *  \  `-"             \'\   / |
             *   `.              ,  \ \ /  |  Copyright (C) 2025 Ender-ing GitHub Organisation
             *    /`.          ,'-`----Y   |
             *   (            ;        |   '
             *   |  ,-.    ,-'         |  /
             *   |  | (   |    Frankie | /    (Cat-chy Art by Hayley Jane Wakenshaw)
             *   )  |  \  `.___________|/
             *   `--'   `--'
            **/
            // Print initial console prompt
            std::cout << std::endl << std::endl << format("  ,-.       _,---._ __ ", Color::golden_rod)
                << format(" / \\", Color::light_sea_green) << std::endl;
            std::cout << format(" /  )    .-'       `./", Color::golden_rod)
                << format(" /   \\", Color::light_sea_green) << std::endl;
            std::cout << format("(  (   ,'            `", Color::golden_rod)
                << format("/    /|  PolarFrankie ", Color::light_sea_green) << format("v", Color::blue_violet)
                << format(MAIN_TARGET_BINARY_VERSION, Color::blue_violet) << std::endl;
            std::cout << format(" \\  `-\"             \\'", Color::golden_rod)
                << format("\\   / |", Color::light_sea_green) << std::endl;
            std::cout << format("  `.              ,  \\", Color::golden_rod)
                << format(" \\ /  |  Copyright (C) 2025 Ender-ing GitHub Organisation", Color::light_sea_green)
                << std::endl;
            std::cout << format("   /`.          ,'", Color::golden_rod) << format("-", Color::light_sea_green)
                << format("`", Color::golden_rod) << format("----Y   |", Color::light_sea_green) << std::endl;
            std::cout << format("  (            ;", Color::golden_rod)
                << format("        |   '", Color::light_sea_green) << std::endl;
            std::cout << format("  |  ,-.    ,-'", Color::golden_rod) << format("         |  /", Color::light_sea_green)
                << std::endl;
            std::cout << format("  |  | (   |", Color::golden_rod)
                << format("    Frankie | /    (Cat-chy Art by Hayley Jane Wakenshaw)", Color::light_sea_green)
                << std::endl;
            std::cout << format("  )  |  \\  `.", Color::golden_rod) << format("___________|/", Color::light_sea_green)
                << std::endl;
            std::cout << format("  `--'   `--'", Color::golden_rod) << std::endl << std::endl;

            // Update status to prevent duplicate calls
            isInitialized = true;
        }
    }
}
