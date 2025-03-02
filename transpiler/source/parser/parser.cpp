/**
 * @brief 
 * Parser implementations
**/

// ANTLR4 imports
// For SOME REASON, if you import these ANYWHERE ELSE, the build fails on WINDOWS..
#include "antlr4-runtime.h"
#include "PolarFrankieLexer.h"
#include "PolarFrankieParser.h"

#include "../common/headers.hpp"

// using namespace antlrcpptest;
using namespace antlr4;
using namespace frankie_parser;

namespace FrankieParser {
    // TMP
    void debug (std::string file_contents) {
        // Use the file's input
        ANTLRInputStream input(file_contents);

        // Generate tokens
        PolarFrankieLexer lexer(&input);
        CommonTokenStream tokens(&lexer);

        // Print tokens
        tokens.fill();
        std::cout << fmt::format(fg(fmt::color::blue), "Tokens: \n") << std::endl;
        for (auto token : tokens.getTokens()) {
            std::cout << token->toString() << std::endl;
        }
  
        // Generate a parse tree
        PolarFrankieParser parser(&tokens);
        tree::ParseTree *tree = parser.root();

        // Print the parse tree!
        auto s = tree->toStringTree(&parser);
        std::cout << fmt::format(fg(fmt::color::blue), "Parse Tree: \n") << s << std::endl;
    }
}
