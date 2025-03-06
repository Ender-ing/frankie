/**
 * @brief 
 * Commnly used headers
**/

#pragma once

// Basic configurations
#pragma execution_character_set("utf-8")

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
