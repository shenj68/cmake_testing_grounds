# Check if the system is Linux
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    # Try to detect Ubuntu specifically
    message(STATUS "[PORTFILE] - Detected Linux")
    execute_process(
        COMMAND lsb_release -i
        OUTPUT_VARIABLE DISTRO_ID
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_QUIET
    )

    if(DISTRO_ID MATCHES "Ubuntu")
        message(STATUS "Detected Ubuntu Linux")
        # Add your specific configuration for Ubuntu here
    else()
        message(FATAL_ERROR "This port is only supported on Ubuntu Linux.")
    endif()
else()
    message(FATAL_ERROR "This port is only supported on Linux.")
endif()

message(STATUS "CMAKE_HOST_SYSTEM_VERSION: ${CMAKE_HOST_SYSTEM_VERSION}")

if(CMAKE_HOST_SYSTEM_VERSION MATCHES "microsoft-standard-WSL2")
    set(boop 1)
endif()

if(boop MATCHES 1)
    message(STATUS "QLKWELQWELWQELELE")
endif()

if(boop MATCHES 2)
    message(STATUS "LOLOLOL ITS 2")
endif()


set(boop2 "microsoft")

if ( CMAKE_HOST_SYSTEM_VERSION MATCHES "microsoft-standard-WSL2") 
    set(wsl_condition_cnt_1 1)
endif()
if (CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set (wsl_condition_cnt_2 1)
endif()
if (CMAKE_HOST_SYSTEM_VERSION MATCHES "tegra")
    set (wsl_condition_cnt_3 1)
else()
    set(wsl_condition_cnt_3 0)
endif()

# AND (CMAKE_SYSTEM_NAME STREQUAL "Linux") AND (CMAKE_HOST_SYSTEM_VERSION NOT MATCHES "tegra")
#     message(STATUS "YEEEETT BABY")
# endif()

if( (wsl_condition_cnt_1 MATCHES 1) AND (wsl_condition_cnt_2 MATCHES 1) AND (wsl_condition_cnt_3 MATCHES 0) )
    message(STATUS "YEEEET")
endif()
