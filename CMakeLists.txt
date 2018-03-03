cmake_minimum_required(VERSION 3.10)
project(dxvk)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED 17)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/build_helpers/cmake/modules/")
include("${CMAKE_SOURCE_DIR}/build_helpers/cmake/ucm.cmake")

option(USE_STATIC_RUNTIME "Use static runtime" ON)
if(USE_STATIC_RUNTIME)
    ucm_set_runtime(STATIC)
else()
    ucm_set_runtime(RUNTIME)
endif()

find_package(Vulkan)
if(NOT Vulkan_FOUND)
    message("Vulkan was not found, fallback to embedded version")

    set(Vulkan_INCLUDE_DIR "${CMAKE_SOURCE_DIR}/build_helpers/dependencies/vulkan/include/")
    if(CMAKE_SIZEOF_VOID_P EQUAL 8)
        set(Vulkan_LIBRARY "${CMAKE_SOURCE_DIR}/build_helpers/dependencies/vulkan/lib64/vulkan-1.lib")
    elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
        set(Vulkan_LIBRARY "${CMAKE_SOURCE_DIR}/build_helpers/dependencies/vulkan/lib32/vulkan-1.lib")
    endif()
endif()

find_package(SPIRV-Tools)
if(NOT SPIRV-Tools_FOUND)
    message("SPIRV-Tools was not found, fallback to embedded version")

    set(SPIRV-Tools_INCLUDE_DIR "${CMAKE_SOURCE_DIR}/build_helpers/dependencies/spirv-tools/include/")
    if(MSVC)
        #TODO
    else()
        if(CMAKE_SIZEOF_VOID_P EQUAL 8)
            set(Vulkan_LIBRARY "${CMAKE_SOURCE_DIR}/build_helpers/dependencies/spirv-tools/lib64-mingw/vulkan-1.lib")
        elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
            set(Vulkan_LIBRARY "${CMAKE_SOURCE_DIR}/build_helpers/dependencies/spirv-tools/lib32-mingw/vulkan-1.lib")
        endif()
    endif()
endif()

if(MSVC)
    add_definitions(-D_SILENCE_CXX17_CODECVT_HEADER_DEPRECATION_WARNING)
    add_definitions(-DNOMINMAX)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS)
endif()

add_subdirectory(src)