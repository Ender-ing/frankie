/**
 * @brief 
 * Manage Windows DLL exports and imports
**/

#ifdef _WIN32
#  ifdef BUILDING_DYNAMIC_LIBRARY // Exporting on Windows
#    define DYNAMIC_API __declspec(dllexport)
#  else // Importing on Windows
#    define DYNAMIC_API __declspec(dllimport)
#  endif
#else // Linux
#  define DYNAMIC_API __attribute__((visibility("default")))
#endif
