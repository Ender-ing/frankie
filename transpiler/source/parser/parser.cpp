/**
 * @brief
 * Parser implementations
**/

// ANTLR4 imports
#include "antlr4-runtime.h"
#include "PolarFrankieLexer.h"
#include "PolarFrankieParser.h"

// Parser
#include "parser.hpp"
#include "listeners/errors.hpp"

// Comms
#include "../comms/comms.hpp"

namespace Parser {
    namespace Debug {
        // Private members
        static bool syntaxCheckSuccess = true;
        // Debug Error Listener
        class DebugErrorListener : public antlr4::ANTLRErrorListener {
        public:
            void syntaxError(antlr4::Recognizer *recognizer, antlr4::Token *offendingSymbol, size_t line,
                size_t charPositionInLine, const std::string &msg, std::exception_ptr e) override {

                syntaxCheckSuccess = false;
                REPORT(Comms::START_REPORT, Comms::CRITICAL_REPORT, "Syntax error at line ", line, ":",
                    charPositionInLine, " - ", msg, Comms::END_REPORT);
            }
            void reportAmbiguity(antlr4::Parser *recognizer, const antlr4::dfa::DFA &dfa, size_t startIndex,
                size_t stopIndex, bool exact, const antlrcpp::BitSet &ambigAlts, antlr4::atn::ATNConfigSet *configs)
                override {

                syntaxCheckSuccess = false;
                REPORT(Comms::START_REPORT, Comms::CRITICAL_REPORT, "Ambiguity reported from index ",
                    startIndex ," to index " , stopIndex, Comms::END_REPORT);
            }
            void reportAttemptingFullContext(antlr4::Parser *recognizer, const antlr4::dfa::DFA &dfa, size_t startIndex,
                size_t stopIndex, const antlrcpp::BitSet &conflictingAlts, antlr4::atn::ATNConfigSet *configs)
                override {

                syntaxCheckSuccess = false;
                REPORT(Comms::START_REPORT, Comms::CRITICAL_REPORT, "Attempting full context reported from index ",
                    startIndex ," to index " , stopIndex, Comms::END_REPORT);
            }
            void reportContextSensitivity(antlr4::Parser *recognizer, const antlr4::dfa::DFA &dfa, size_t startIndex,
                size_t stopIndex, size_t prediction, antlr4::atn::ATNConfigSet *configs) override {

                syntaxCheckSuccess = false;
                REPORT(Comms::START_REPORT, Comms::CRITICAL_REPORT, "Context sensitivity reported from index ",
                    startIndex ," to index " , stopIndex, Comms::END_REPORT);
            }
        };
        // Check for syntax errors
        // [true -> success, false -> failure]
        bool syntaxCheck (std::string file_contents) {
            // Use the file's input
            antlr4::ANTLRInputStream input(file_contents);

            // Tokens
            GeneratedLexer::PolarFrankieLexer lexer(&input);
            antlr4::CommonTokenStream tokens(&lexer);
  
            // Parse tree
            GeneratedParser::PolarFrankieParser parser(&tokens);

            // Check for syntax errors
            DebugErrorListener errorListener;
            //Listeners::LexerErrorListener lexerErrorListener;
            //Listeners::ParserErrorListener parserErrorListener;
            lexer.removeErrorListeners();// remove default parser error listeners.
            lexer.addErrorListener(&errorListener);
            //lexer.addErrorListener(&lexerErrorListener);
            parser.removeErrorListeners();// remove default parser error listeners.
            parser.addErrorListener(&errorListener);
            //parser.addErrorListener(&parserErrorListener);

            // Print tokens
            tokens.fill();
            REPORT(Comms::START_REPORT, Comms::DEBUG_REPORT, "Tokens: \n");
            for (auto token : tokens.getTokens()) {
                REPORT(token->toString(), "\n");
            }
            REPORT(Comms::END_REPORT);

            // Get the root tree!
            antlr4::tree::ParseTree *tree = parser.root();

            // Print the parse tree!
            auto s = tree->toStringTree(&parser);
            REPORT(Comms::START_REPORT, Comms::DEBUG_REPORT, "Parse Tree: \n", s, Comms::END_REPORT);

            return syntaxCheckSuccess;
        }
    }
}
