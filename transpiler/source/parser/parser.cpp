/**
 * @brief
 * Parser implementations
**/

// ANTLR4 imports
#include "antlr4-runtime.h"
#include "PolarFrankieLexer.h"
#include "PolarFrankieParser.h"

#include "parser.hpp"

#include "../comms/comms.hpp"

// using namespace antlrcpptest;
using namespace frankie_parser;

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
                std::cerr << "Syntax error at line " << line << ":" << charPositionInLine << " - " << msg << std::endl;
            }
            void reportAmbiguity(antlr4::Parser *recognizer, const antlr4::dfa::DFA &dfa, size_t startIndex,
                size_t stopIndex, bool exact, const antlrcpp::BitSet &ambigAlts, antlr4::atn::ATNConfigSet *configs) override {

                syntaxCheckSuccess = false;
                std::cerr << "Ambiguity reported from index " << startIndex << " to index " << stopIndex << std::endl;
            }
            void reportAttemptingFullContext(antlr4::Parser *recognizer, const antlr4::dfa::DFA &dfa, size_t startIndex,
                size_t stopIndex, const antlrcpp::BitSet &conflictingAlts, antlr4::atn::ATNConfigSet *configs) override {

                syntaxCheckSuccess = false;
                std::cerr << "Attempting full context reported from index " << startIndex << " to index " << stopIndex << std::endl;
            }
            void reportContextSensitivity(antlr4::Parser *recognizer, const antlr4::dfa::DFA &dfa, size_t startIndex,
                size_t stopIndex, size_t prediction, antlr4::atn::ATNConfigSet *configs) override {

                    syntaxCheckSuccess = false;
                std::cerr << "Context sensitivity reported from index " << startIndex << " to index " << stopIndex << std::endl;
            }
        };
        // Check for syntax errors
        // [true -> success, false -> failure]
        bool syntaxCheck (std::string file_contents) {
            // Use the file's input
            antlr4::ANTLRInputStream input(file_contents);

            // Generate tokens
            PolarFrankieLexer lexer(&input);
            antlr4::CommonTokenStream tokens(&lexer);

            // Print tokens
            tokens.fill();
            std::cout << Comms::CLI::format("Tokens: \n", Comms::CLI::Color::blue) << std::endl;
            for (auto token : tokens.getTokens()) {
                std::cout << token->toString() << std::endl;
            }
  
            // Generate a parse tree
            PolarFrankieParser parser(&tokens);

            // Look for syntax errors!
            DebugErrorListener errorListener;
            parser.addErrorListener(&errorListener);

            // Get the root tree!
            antlr4::tree::ParseTree *tree = parser.root();

            // Print the parse tree!
            auto s = tree->toStringTree(&parser);
            std::cout << Comms::CLI::format("Parse Tree: \n", Comms::CLI::Color::blue) << s << std::endl;

            return syntaxCheckSuccess;
        }
    }
}
