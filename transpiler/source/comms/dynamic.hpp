/**
 * @brief 
 * Manage dynamic library exports and imports
**/

#pragma once

#ifdef _WIN32
#   ifdef FRANKIECOMMSLIBRARY_EXPORTS // Exporting on Windows
#       define FRANKIE_COMMS_API __declspec(dllexport)
#   else // Importing on Windows
#       define FRANKIE_COMMS_API __declspec(dllimport)
#   endif
#else // Linux
#   define FRANKIE_COMMS_API __attribute__((visibility("default")))
#endif
