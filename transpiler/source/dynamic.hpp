/**
 * @brief 
 * Manage dynamic library exports and imports
**/

#pragma once

#ifdef _WIN32
#   ifdef FRANKIEBASELIBRARY_EXPORTS // Exporting on Windows
#       define FRANKIE_BASE_API __declspec(dllexport)
#   else // Importing on Windows
#       define FRANKIE_BASE_API __declspec(dllimport)
#   endif
#else // Linux & macOS
#   define FRANKIE_BASE_API __attribute__((visibility("default")))
#endif
