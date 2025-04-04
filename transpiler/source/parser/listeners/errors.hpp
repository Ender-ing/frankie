/**
 * @brief
 * Lexer & parser error listeners
**/

#pragma once

// ANTLR4 imports
#include "antlr4-runtime.h"

#include "../../common/headers.hpp"
#include "../dynamic.hpp" // FRANKIE_PARSER_API

namespace Parser {
    namespace Listeners {
        // Track errors
        extern FRANKIE_PARSER_API bool errorsDetected;

        // Listen for syntax-related errors
        class FRANKIE_PARSER_API ErrorListener : public antlr4::BaseErrorListener {
            public:
                void syntaxError(antlr4::Recognizer *recognizer, antlr4::Token *offendingSymbol, size_t line,
                    size_t charPositionInLine, const std::string &msg, std::exception_ptr e) override ;
                void reportAmbiguity(antlr4::Parser *recognizer, const antlr4::dfa::DFA &dfa, size_t startIndex,
                    size_t stopIndex, bool exact, const antlrcpp::BitSet &ambigAlts, antlr4::atn::ATNConfigSet *configs)
                    override ;
                void reportAttemptingFullContext(antlr4::Parser *recognizer, const antlr4::dfa::DFA &dfa,
                    size_t startIndex, size_t stopIndex, const antlrcpp::BitSet &conflictingAlts,
                    antlr4::atn::ATNConfigSet *configs) override ;
                void reportContextSensitivity(antlr4::Parser *recognizer, const antlr4::dfa::DFA &dfa,
                    size_t startIndex, size_t stopIndex, size_t prediction,
                    antlr4::atn::ATNConfigSet *configs) override ;

                std::string stage; // "Lexer" or "Parser"
            private:
        };
    }
}
