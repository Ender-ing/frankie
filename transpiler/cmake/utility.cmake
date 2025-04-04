# Add a .ini value reader
function(get_ini_value INI_FILE INI_SECTION KEY OUTPUT_VARIABLE)
    # Get file contents
    file(READ ${INI_FILE} INI_CONTENTS)
    string(REGEX REPLACE "\r" "" INI_CONTENTS "${INI_CONTENTS}")

    # Get the required section
    string(REGEX MATCH "(\\[${INI_SECTION}\\]\n)(([^\\[]*)\n)*\\[?" MATCHED_SECTION "${INI_CONTENTS}")

    # Look for the key
    string(REGEX MATCH "(^|\n)(${KEY}\\=[^\n]*)" MATCHED_VALUE "${MATCHED_SECTION}")
    # Only get the value
    # (?<=(\[FrankieTranspiler\]\n))^VERSION=([^\n]*) # Doesn't work if the value is not directly after the section's name
    string(REGEX REPLACE "(^|\n)${KEY}\\=[\\s]*(\"(.*)\"|([\\d]+))[\\s]*" "\\3" VALUE "${MATCHED_VALUE}")
    string(STRIP "${VALUE}" VALUE) # Remove extra whitespace (for bad string values)

    # Check for value inheritance
    string(REGEX MATCH "^INHERIT:.+" INIT_INHERIT "${VALUE}")
    if(INIT_INHERIT)
        string(REGEX REPLACE "INHERIT:(.*)" "\\1" INIT_INHERIT "${INIT_INHERIT}")
        # Get value from INIT_INHERIT's section
        get_ini_value(${INI_FILE} ${INIT_INHERIT} ${KEY} VALUE)
    endif()

    # Return value
    set(${OUTPUT_VARIABLE} "${VALUE}" PARENT_SCOPE)
endfunction()

