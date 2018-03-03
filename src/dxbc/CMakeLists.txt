add_library(dxbc STATIC
    dxbc_chunk_isgn.cpp
    dxbc_chunk_shex.cpp
    dxbc_common.cpp
    dxbc_compiler.cpp
    dxbc_defs.cpp
    dxbc_decoder.cpp
    dxbc_header.cpp
    dxbc_module.cpp
    dxbc_names.cpp
    dxbc_options.cpp
    dxbc_reader.cpp
    dxbc_util.cpp
)

target_include_directories(dxbc PRIVATE ${Vulkan_INCLUDE_DIR})
target_include_directories(dxbc PUBLIC ${SPIRV-Tools_INCLUDE_DIR})
