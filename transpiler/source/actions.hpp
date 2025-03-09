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
        typedef std::array<std::string, 3> ActionInfo;
        typedef std::function<bool(const ActionNextFunction)> ActionFunction;

        // Custom hash function for ActionInfo
        struct ActionInfoHash_internal {
            std::size_t operator()(const ActionInfo& info) const {
                std::size_t hash = 0;
                for (const auto& str : info) {
                    hash ^= std::hash<std::string>{}(str);
                }
                return hash;
            }
        };

        // List of actions and their respective functions
        // [
        //  string[
        //      // flag name members must be in lower case and only contain english letters and dashes (-)
        //      string (short flag name)
        //      string (long flag name)
        //      string (flag/action description)
        //  ]
        //  function (true - normal -> continue, false - error -> terminate) // Must always return a boolean value
        // ]
        extern FRANKIE_BASE_LIB std::unordered_map<
            ActionInfo,
            ActionFunction,
            ActionInfoHash_internal
            > map;

        // Get an action function using one flag
        extern FRANKIE_BASE_LIB bool getActionFunctionByFlag(const std::string& flag, ActionFunction &store) ;
    }
}
