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
using namespace antlr4;
using namespace frankie_parser;

namespace Parser {
    // TMP
    void debug (std::string file_contents) {
        // Use the file's input
        ANTLRInputStream input(file_contents);

        // Generate tokens
        PolarFrankieLexer lexer(&input);
        CommonTokenStream tokens(&lexer);

        // Print tokens
        tokens.fill();
        std::cout << Comms::CLI::format("Tokens: \n", Comms::CLI::Color::blue) << std::endl;
        for (auto token : tokens.getTokens()) {
            std::cout << token->toString() << std::endl;
        }
  
        // Generate a parse tree
        PolarFrankieParser parser(&tokens);
        tree::ParseTree *tree = parser.root();

        // Print the parse tree!
        auto s = tree->toStringTree(&parser);
        std::cout << Comms::CLI::format("Parse Tree: \n", Comms::CLI::Color::blue) << s << std::endl;
    }
}
