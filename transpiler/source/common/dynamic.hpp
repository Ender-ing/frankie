/**
 * @brief 
 * Manage Windows DLL exports and imports
**/

#pragma once

#ifndef COMMON_DLL_API_HEADER
#define COMMON_DLL_API_HEADER


#ifdef _WIN32
#   ifdef BUILD_DYNAMIC_LIBRARY // Exporting on Windows
#       define DYNAMIC_API __declspec(dllexport)
#   else // Importing on Windows
#       define DYNAMIC_API __declspec(dllimport)
#   endif
#else // Linux
#   define DYNAMIC_API __attribute__((visibility("default")))
#endif


#endif
