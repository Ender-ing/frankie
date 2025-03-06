/**
 * @brief 
 * Manage dynamic library exports and imports
**/

#pragma once

#ifdef _WIN32
#   ifdef FRANKIEPARSERLIBRARY_EXPORTS // Exporting on Windows
#       define FRANKIE_PARSER_LIB __declspec(dllexport)
#   else // Importing on Windows
#       define FRANKIE_PARSER_LIB __declspec(dllimport)
#   endif
#else // Linux
#   define FRANKIE_PARSER_LIB __attribute__((visibility("default")))
#endif
