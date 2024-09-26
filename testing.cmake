# Find the LSB (Linux Standard Base) (Determine if host is using Ubuntu) 
find_program(LSB_RELEASE_EXEC lsb_release)
execute_process(COMMAND ${LSB_RELEASE_EXEC} -is
    OUTPUT_VARIABLE Linux_Standard_Base
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
message (STATUS "[PORTFILE] - Linux_Standard_Base: ${Linux_Standard_Base}")


# UbuntuFlag
if (Linux_Standard_Base MATCHES "Ubuntu")
    message(STATUS "[PORTFILE] - Ubuntu Detected")
    set(ubuntu_flag 1)
else()
    message(STATUS "[PORTFILE] - Ubuntu NOT Detected")
    set(ubuntu_flag 0)
endif()


# WSLFlag
if ( CMAKE_HOST_SYSTEM_VERSION MATCHES "microsoft-standard-WSL2" OR CMAKE_HOST_SYSTEM_VERSION MATCHES "microsoft-standard-WSL") 
    set(wsl_flag 1)
    #message("wsl_flag: ${wsl_flag}")
else()
    set(wsl_flag 0)
    #message("wsl_flag: ${wsl_flag}")
endif()


# Linux Flag
if (CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set(linux_flag 1)
    #message("linux_flag: ${linux_flag}")
else()
    set(linux_flag 0)
    #message("linux_flag: ${linux_flag}")
endif()


# JetsonFlag/Tegra Devices
if (CMAKE_HOST_SYSTEM_VERSION MATCHES "tegra" AND EXISTS "${ROOT}/etc/nv_tegra_release")
    set(jetson_flag 1)
    #message("jetson_flag: ${jetson_flag}")
else()
    set(jetson_flag 0)
    #message("jetson_flag: ${jetson_flag}")
endif()


# WindowsFlag
if (CMAKE_HOST_SYSTEM_NAME MATCHES "Windows" AND CMAKE_HOST_SYSTEM_VERSION MATCHES "10.0")
    set(windows_flag 1)
    #message("windows_flag: ${windows_flag}")
else()
    set(windows_flag 0)
    #message("windows_flag: ${windows_flag}")
endif()


# [WSL2] - Supported
if( (wsl_flag MATCHES 1) 
    AND (linux_flag MATCHES 1) 
    AND (ubuntu_flag MATCHES 1)
    AND (jetson_flag MATCHES 0) 
    AND (windows_flag MATCHES 0))
    message(STATUS "[PORTFILE] - WSL Detected")
endif()


# [Linux + Ubuntu] - Supported
if( (wsl_flag MATCHES 0) 
    AND (linux_flag MATCHES 1) 
    AND (ubuntu_flag MATCHES 1)
    AND (jetson_flag MATCHES 0) 
    AND (windows_flag MATCHES 0) )
    message(STATUS "[PORTFILE] - Linux + Ubuntu Machine Detected")
endif()


# [Nvidia Devices] - Supported
if( (wsl_flag MATCHES 0) 
    AND (linux_flag MATCHES 1)
    AND (ubuntu_flag MATCHES 1) 
    AND (jetson_flag MATCHES 1) 
    AND (windows_flag MATCHES 0))
    message(STATUS "[PORTFILE] - Nvidia Jetson Device Detected")
endif()


# [Windows Devices] - Not Supported
if( (wsl_flag MATCHES 0) 
    AND (linux_flag MATCHES 0)
    AND (ubuntu_flag MATCHES 0) 
    AND (jetson_flag MATCHES 0) 
    AND (windows_flag MATCHES 1))    
    message(STATUS "[PORTFILE] - Windows Detected")
    message(FATAL_ERROR "[PORTFILE] - !!! WINDOWS NOT SUPPORTED, ABORTING... !!!")
endif()


# Not Currently Supported
if( (wsl_flag MATCHES 0) 
    AND (ubuntu_flag MATCHES 0)
    AND (linux_flag MATCHES 0) 
    AND (jetson_flag MATCHES 0) 
    AND (windows_flag MATCHES 0))    
    message(STATUS "[PORTFILE] - NONE Detected")
    message(FATAL_ERROR "[PORTFILE] - !!! ARCHITECTURE NOT SUPPORTED, ABORTING... !!!")
endif()