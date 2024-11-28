@echo off
setlocal enabledelayedexpansion

:: Input and output
set input_folder=.\..\..\source\ANTLR4
set output_folder=.\..\..\generated\ANTLR4

:: Make the output
mkdir %output_folder%

:: Process the lexer
java org.antlr.v4.Tool %input_folder%\PolarFrankieLexer.g4
:: Process the parser
java org.antlr.v4.Tool %input_folder%\PolarFrankieParser.g4

:: Move the files to the generated files directory
move "%input_folder%\*.cpp" "%output_folder%\"
move "%input_folder%\*.h" "%output_folder%\"
move "%input_folder%\*.interp" "%output_folder%\"
move "%input_folder%\*.tokens" "%output_folder%\"
