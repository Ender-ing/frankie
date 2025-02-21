# Needed programs!
find_program(SEVEN_ZIP NAMES 7z)  # Find the 7z executable
find_program(POWERSHELL NAMES powershell pwsh) # Find powershell, pwsh is for powershell core

# extract_zip("source.zip" "output_dir")
if(SEVEN_ZIP)
    function(extract_zip zip_file extract_dir)
        execute_process(
            COMMAND ${SEVEN_ZIP} x ${zip_file} -o${extract_dir} -y
            RESULT_VARIABLE EXTRACT_RESULT
        )
        # Catch failures
        if(NOT EXTRACT_RESULT EQUAL 0)
            message(FATAL_ERROR "[MICROS] (7z) Failed to extract ${zip_file}")
        endif()
    endfunction()
elseif(POWERSHELL)
    function(extract_zip zip_file extract_dir)
        execute_process(
            COMMAND ${POWERSHELL} -Command "Expand-Archive -Path '${zip_file}' -DestinationPath '${extract_dir}' -Force"
            RESULT_VARIABLE EXTRACT_RESULT
        )
        # Catch failures
        if(NOT EXTRACT_RESULT EQUAL 0)
            message(FATAL_ERROR "[MICROS] (PowerShell) Failed to extract ${zip_file}")
        endif()
    endfunction()
else()
    message(FATAL_ERROR "[MICROS] No appropriate archive management programe has been found! Please install 7-Zip or PowerShell!")
endif()
