/**
 * @brief
 * Manage transpiler actions
**/

#pragma once

#include "common/headers.hpp"
#include "dynamic.hpp" // FRANKIE_BASE_LIB

// Basic C++ headers
#include <unordered_map>
#include <functional>

// WORK IN PROGRESS

namespace Base {
    namespace Actions {
        // Action-related function types
        typedef std::function<bool(std::string&, bool)> ActionNextFunction;
        typedef std::function<bool(const ActionNextFunction)> ActionFunction;
        typedef std::function<bool(ActionNextFunction)> ActionArgs;

        // List of actions and their respective functions
        // [
        //  string[] (flag name(s)) // Members must be in lower case and only contain english letters and dashes (-)
        //  function (true - normal -> continue, false - error -> terminate) // Must always return a boolean value
        //  string (flag/action description)
        // ]
        extern FRANKIE_BASE_LIB std::unordered_map<
            ActionArgs,
            ActionFunction,
            std::string
            > map;

        // Get an action function using one flag
        extern FRANKIE_BASE_LIB bool getActionFunctionByFlag(const std::string& flag, ActionFunction &store) ;
    }
}
