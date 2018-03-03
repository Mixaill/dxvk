# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.
# 
# revision: 1
# See https://github.com/CMakePorts/CMakeFindPackages for updates
#
#.rst:
# FindSPIRV-Tools
# ---------
#
# Locates SPIRV-Tools libraries
#
# Authors:
#  Copyright (c)           Eric Wing
#  Copyright (c)           Alexander Neundorf
#  Copyright (c) 2008      Joshua L. Blocher  <verbalshadow at gmail dot com>
#  Copyright (c) 2012      Dmitry Baryshnikov <polimax at mail dot ru>
#  Copyright (c) 2013-2018 Mikhail Paulyshka  <me at mixaill dot tk>
#

find_path(SPIRV-Tools_INCLUDE_DIR
    NAMES
        "spirv-tools/libspirv.h"
    HINTS
        ${CMAKE_FIND_ROOT_PATH}
    PATHS
        ${CMAKE_FIND_ROOT_PATH}
    PATH_SUFFIXES
        "include"
        "usr/include"
)

function(find_spirv_library name)
    if(NOT ${name}_LIBRARY)
        find_library(${name}_LIBRARY_RELEASE
            NAMES
                "lib${name}"
                "${name}"
            HINTS
                ${CMAKE_FIND_ROOT_PATH}
            PATHS
                ${CMAKE_FIND_ROOT_PATH}
            PATH_SUFFIXES
                "lib"
                "local/lib"
        ) 

        find_library(${name}_LIBRARY_DEBUG
            NAMES
                "lib${name}d"
                "${name}d"
                "lib${name}"
                "${name}"         
            HINTS
                ${CMAKE_FIND_ROOT_PATH}
            PATHS
                ${CMAKE_FIND_ROOT_PATH}
            PATH_SUFFIXES
                "debug/lib"
                "lib"
                "local/lib"
        ) 

        #fix debug/release libraries mismatch for vcpkg
        if(DEFINED VCPKG_TARGET_TRIPLET)
            set(${name}_LIBRARY_RELEASE ${${name}_LIBRARY_DEBUG}/../../../lib/${name}.lib)
            get_filename_component(${name}_LIBRARY_RELEASE ${${name}_LIBRARY_RELEASE} REALPATH)
        endif()

        include(SelectLibraryConfigurations)
        select_library_configurations(${name})
        set(${name}_LIBRARY ${${name}_LIBRARY} PARENT_SCOPE)

        mark_as_advanced(
            ${name}_LIBRARY_DEBUG
            ${name}_LIBRARY_RELEASE
            ${name}_LIBRARY
            ${name}_LIBRARIES
        )

    endif()
endfunction()

find_spirv_library(SPIRV-Tools)   
find_spirv_library(SPIRV-Tools-link)
find_spirv_library(SPIRV-Tools-opt)
find_spirv_library(SPIRV-Tools-shared)

set(SPIRV-Tools_LIBRARIES
    ${SPIRV-Tools_LIBRARY} 
    ${SPIRV-Tools-link_LIBRARY}
    ${SPIRV-Tools-opt_LIBRARY}
    ${SPIRV-Tools-shared_LIBRARY}
)

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(
    SPIRV-Tools 
    REQUIRED_VARS 
        SPIRV-Tools_LIBRARIES 
        SPIRV-Tools_INCLUDE_DIR
)

MARK_AS_ADVANCED(
    SPIRV-Tools_INCLUDE_DIR 
    SPIRV-Tools_LIBRARIES
)
