#include <iostream>

#include "antlr4-runtime.h"
#include "PolarFrankieLexer.h"
#include "PolarFrankieParser.h"

// #include <Windows.h>

#include <iostream>
#include <fstream>
#include <sstream>
#include <string>

#pragma execution_character_set("utf-8")

// using namespace antlrcpptest;
using namespace antlr4;
using namespace frankie_parser;

int main (int argc, const char *argv[]) {

    // Check args
    if (argc < 2) {
        std::cerr << "Expecting a file path! " << std::endl;
        return 1; // Fail!
    }

    // Check first input argument path
    auto filename = argv[1];
    std::ifstream file(filename);

    // Check if the file actually exists and get its contents
    std::string file_contents;
    if (file.is_open()) {
        // Get all file stream
        std::stringstream buffer;
        buffer << file.rdbuf();

        // Get the file as a string
        file_contents = buffer.str();

        // Close file
        file.close();
    } else {
        std::cerr << "Error opening file: " << filename << std::endl; // Fail!
        return 1;
    }

    // Use the file's input
    ANTLRInputStream input(file_contents);

    // Generate tokens
    PolarFrankieLexer lexer(&input);
    CommonTokenStream tokens(&lexer);

    // Generate a parse tree
    PolarFrankieParser parser(&tokens);
    tree::ParseTree *tree = parser.root();

    // Print the parse tree!
    auto s = tree->toStringTree(&parser);
    std::cout << "Parse Tree: \n" << s << std::endl;

    return 0;
}