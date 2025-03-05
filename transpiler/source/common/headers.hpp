/**
 * @brief 
 * Commnly used headers
**/

#pragma once

// Basic configurations
#pragma execution_character_set("utf-8")

// Handle dynamic library imports and exports
#include "dynamic.hpp" // DYNAMIC_API
// Note: only use the "DYNAMIC_API" keyword within HEADER FILES please!

// Basic C++ headers
//#include <iostream>
//#include <fstream>
//#include <sstream>
#include <string>

// Include platform headers
#ifdef _WIN32
    #include <Windows.h>
#elif defined(__linux__) // Linux
  #include <unistd.h>
#elif defined(__APPLE__) // macOS (and other Apple platforms)
  #include <mach/mach_time.h>
#else
  // ???
#endif
