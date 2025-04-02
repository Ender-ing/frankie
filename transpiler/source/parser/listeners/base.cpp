/**
 * @brief
 * Shared lexer/parser listener components
**/

#include "base.hpp"

#include "../../comms/comms.hpp"

namespace Parser {
    namespace Listeners {
        void BaseErrorListener::syntaxError(antlr4::Recognizer *recognizer, antlr4::Token *offendingSymbol, size_t line,
            size_t charPositionInLine, const std::string &msg, std::exception_ptr e) {

            // Get the starting position
            Comms::IndividualReport::startLine = line;
            Comms::IndividualReport::startColumn = charPositionInLine;

            // Determine the end position
            std::string tokenText;
            if (offendingSymbol) {
                // TMP
                tokenText = offendingSymbol->getText();
                Comms::IndividualReport::endColumn = Comms::IndividualReport::startColumn + tokenText.length();
            } else {
                // TMP
                tokenText = "<N/A> (Error)";
                Comms::IndividualReport::endColumn = Comms::IndividualReport::startColumn + 1;
            }
            Comms::IndividualReport::endLine = line; // TMP

            // Report the error
            REPORT(Comms::START_REPORT, Comms::CRITICAL_REPORT,
                Comms::SET_STAGE_TITLE, section,
                "???msg???", tokenText,
                Comms::END_REPORT);
        }
    }
}
