add_library(util STATIC   
    util_env.cpp
    com/com_guid.cpp
    com/com_private_data.cpp
    log/log.cpp
    log/log_debug.cpp
    sha1/sha1.c
    sha1/sha1_util.cpp
)

target_include_directories(util PRIVATE ${Vulkan_INCLUDE_DIR})
