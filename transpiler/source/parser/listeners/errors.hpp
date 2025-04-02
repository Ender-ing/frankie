/**
 * @brief
 * Shared lexer/parser listener components
**/

#pragma once

#include "../../common/headers.hpp"
#include "../dynamic.hpp" // FRANKIE_PARSER_API

// Parser
#include "base.hpp"

namespace Parser {
    namespace Listeners {
        class LexerErrorListener : public BaseErrorListener {
            private:
                const std::string section = "Lexer";
        };
        class ParserErrorListener : public BaseErrorListener {
            private:
                const std::string section = "Parser";
        };
    }
}
