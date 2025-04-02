/**
 * @brief
 * Shared lexer/parser listener components
**/

#pragma once

#include "../../common/headers.hpp"
#include "../dynamic.hpp" // FRANKIE_PARSER_API

// ANTLR4 imports
#include "antlr4-runtime.h"

namespace Parser {
    namespace Listeners {
        class BaseErrorListener : public antlr4::BaseErrorListener {
            public:
                void syntaxError(antlr4::Recognizer *recognizer, antlr4::Token *offendingSymbol, size_t line,
                    size_t charPositionInLine, const std::string &msg, std::exception_ptr e) override ;

            private:
                const std::string section = "UNKNOWN"; // "Lexer" or "Parser"
        };
    }
}
