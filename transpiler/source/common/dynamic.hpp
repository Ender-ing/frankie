/**
 * @brief 
 * Manage dynamic library exports and imports
**/

#pragma once

#ifdef _WIN32
#   ifdef FRANKIECOMMONLIBRARY_EXPORTS // Exporting on Windows
#       define FRANKIE_COMMON_LIB __declspec(dllexport)
#   else // Importing on Windows
#       define FRANKIE_COMMON_LIB __declspec(dllimport)
#   endif
#else // Linux
#   define FRANKIE_COMMON_LIB __attribute__((visibility("default")))
#endif
