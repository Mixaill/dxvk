add_library(spirv STATIC
    spirv_code_buffer.cpp
    spirv_module.cpp
)

target_include_directories(spirv PUBLIC ${SPIRV-Tools_INCLUDE_DIR})
target_include_directories(spirv PUBLIC ${Vulkan_INCLUDE_DIR})

target_link_libraries(spirv INTERFACE ${SPIRV-Tools_LIBRARIES})
