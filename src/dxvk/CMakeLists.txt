add_library(dxvk STATIC
    dxvk_adapter.cpp
    dxvk_barrier.cpp
    dxvk_buffer.cpp
    dxvk_buffer_res.cpp
    dxvk_cmdlist.cpp
    dxvk_compute.cpp
    dxvk_context.cpp
    dxvk_cs.cpp
    dxvk_data.cpp
    dxvk_descriptor.cpp
    dxvk_device.cpp
    dxvk_extensions.cpp
    dxvk_event.cpp
    dxvk_event_tracker.cpp
    dxvk_format.cpp
    dxvk_framebuffer.cpp
    dxvk_graphics.cpp
    dxvk_image.cpp
    dxvk_instance.cpp
    dxvk_lifetime.cpp
    dxvk_main.cpp
    dxvk_memory.cpp
    dxvk_meta_resolve.cpp
    dxvk_options.cpp
    dxvk_pipecache.cpp
    dxvk_pipelayout.cpp
    dxvk_pipemanager.cpp
    dxvk_query.cpp
    dxvk_query_pool.cpp
    dxvk_query_tracker.cpp
    dxvk_queue.cpp
    dxvk_renderpass.cpp
    dxvk_resource.cpp
    dxvk_sampler.cpp
    dxvk_shader.cpp
    dxvk_staging.cpp
    dxvk_surface.cpp
    dxvk_swapchain.cpp
    dxvk_sync.cpp
    dxvk_unbound.cpp
    dxvk_util.cpp

    hud/dxvk_hud.cpp
    hud/dxvk_hud_devinfo.cpp
    hud/dxvk_hud_font.cpp
    hud/dxvk_hud_fps.cpp
    hud/dxvk_hud_text.cpp

    vulkan/dxvk_vulkan_extensions.cpp
    vulkan/dxvk_vulkan_loader.cpp
    vulkan/dxvk_vulkan_names.cpp
)

if (${CMAKE_HOST_SYSTEM_PROCESSOR} STREQUAL "AMD64")
  set(GLSL_VALIDATOR "$ENV{VULKAN_SDK}/Bin/glslangValidator.exe")
else()
  set(GLSL_VALIDATOR "$ENV{VULKAN_SDK}/Bin32/glslangValidator.exe")
endif()

file(GLOB_RECURSE GLSL_SOURCE_FILES
    "hud/shaders/*.frag"
    "hud/shaders/*.vert"
)

foreach(GLSL ${GLSL_SOURCE_FILES})
  get_filename_component(FILE_BASENAME ${GLSL} NAME_WE)
  set(SPIRV "${PROJECT_BINARY_DIR}/shaders/${FILE_BASENAME}.h")
  add_custom_command(
    OUTPUT ${SPIRV}
    COMMAND ${CMAKE_COMMAND} -E make_directory "${PROJECT_BINARY_DIR}/shaders/"
    COMMAND ${GLSL_VALIDATOR} -V --vn ${FILE_BASENAME} ${GLSL} -o ${SPIRV}
    DEPENDS ${GLSL})
  list(APPEND SPIRV_BINARY_FILES ${SPIRV})
endforeach()

add_custom_target(
    Shaders 
    DEPENDS ${SPIRV_BINARY_FILES}
    )

add_dependencies(dxvk Shaders)

target_include_directories(dxvk PRIVATE "${PROJECT_BINARY_DIR}/shaders/")

target_include_directories(dxvk PRIVATE ${Vulkan_INCLUDE_DIR})

target_include_directories(dxvk PRIVATE ${SPIRV-Tools_INCLUDE_DIR})