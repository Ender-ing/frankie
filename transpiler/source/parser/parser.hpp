/**
 * @brief 
 * Parser implementations
**/

#pragma once

#include "../common/headers.hpp"
#include "dynamic.hpp" // FRANKIE_PARSER_API

namespace Parser {
    namespace Debug {
        // Check for syntax errors
        extern FRANKIE_PARSER_API bool syntaxCheck (std::string file_contents) ;
    }
}
