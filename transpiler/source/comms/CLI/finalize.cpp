/**
 * @brief
 * Handle CLI initialisation
**/

#include "finalize.hpp"

// Comms headers
#include "basic.hpp"

// Base headers
#include "../../config.base.hpp"

namespace Comms {
    namespace CLI {
        // Handle CLI finalisation
        void finalize() {
            if (Base::InitialConfigs::Technical::minimalProtocolFinalization) { //TMP
                std::cout << std::endl;
                return;
            }

            /**
             * Failure!
             * Success, with warnings!
             * Success, with non-fatal errors!
             * Success!
             * Success, with warnings!
             * Success, with non-fatal errors!
             * 
             *                 |\__/,|   (`\
             *               _.|o o  |_   ) )
             * ----------- -(((---(((--------  -----------------------
             * 
             * 0 action(s), 0 warning(s), 0 error(s), 0 fatal error(s)
            **/
            // Print initial console prompt
            std::cout << std::endl << format("Done!", Color::light_sea_green) << std::endl;
        }
    }
}
