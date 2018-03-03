add_library(dxgi SHARED 
    dxgi_adapter.cpp
    dxgi_device.cpp
    dxgi_enums.cpp
    dxgi_factory.cpp
    dxgi_main.cpp
    dxgi_output.cpp
    dxgi_presenter.cpp
    dxgi_swapchain.cpp

	dxgi.def
)

target_include_directories(dxgi PRIVATE "../dxvk")

target_link_libraries(dxgi util)
target_link_libraries(dxgi spirv)
target_link_libraries(dxgi dxvk)

target_link_libraries(dxgi ${Vulkan_LIBRARY})

install(
    TARGETS dxgi
    RUNTIME DESTINATION .)
