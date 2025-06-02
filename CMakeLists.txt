cmake_minimum_required(VERSION 3.15)
project(AirMobiSimLibveins)

# Set C++ Standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Conan-generated toolchain file
if(EXISTS "${CMAKE_BINARY_DIR}/generators/conan_toolchain.cmake")
    include("${CMAKE_BINARY_DIR}/generators/conan_toolchain.cmake")
else()
    message(FATAL_ERROR "Conan toolchain file not found. Please run 'conan install'.")
endif()

# Include Conan-generated configurations
find_package(gRPC REQUIRED)
find_package(Protobuf REQUIRED)

# Custom target for running src/Makefile
#add_custom_target(build_src ALL
#    COMMAND ${CMAKE_MAKE_PROGRAM} -C ${CMAKE_SOURCE_DIR}/src
#    COMMENT "Building src/Makefile..."
#)

# gRPC Include und Link für src
#include_directories(${CONAN_INCLUDE_DIRS_GRPC})
#link_directories(${CONAN_LIB_DIRS_GRPC})

#------------------------------------------------------------------------------------ added by Tian
# ———— 本地依赖路径 ————
set(OMNETPP_BASE   "/home/tianhao/Documents/omnetpp-6.0.3")
set(WORKSPACE_BASE "/home/tianhao/Documents/workspace_uav")
set(VEINS_BASE     "${WORKSPACE_BASE}/veins")
set(VEINS_INET_BASE "${VEINS_BASE}/subprojects/veins_inet") 
set(INET_BASE      "${WORKSPACE_BASE}/inet")
set(SIMU5G_BASE    "${WORKSPACE_BASE}/Simu5G")

# ———— Include 目录 ————
include_directories(
    ${CMAKE_SOURCE_DIR}/src # 项目源码
    ${OMNETPP_BASE}/include # OMNeT++
    ${VEINS_BASE}/src
    ${VEINS_INET_BASE}/src 
    ${INET_BASE}/src
    ${SIMU5G_BASE}/src
    
    # Conan 包：gRPC & Protobuf
    ${CONAN_INCLUDE_DIRS_GRPC}
    ${CONAN_INCLUDE_DIRS_PROTOBUF}
)

# ———— Link 目录 ————
link_directories(
    # OMNeT++ 核心
    ${OMNETPP_BASE}/lib
    # 本地编译产物
    ${VEINS_BASE}/src
    ${VEINS_INET_BASE}/src
    ${INET_BASE}/src
    ${SIMU5G_BASE}/src
    # Conan 包：gRPC & Protobuf
    ${CONAN_LIB_DIRS_GRPC}
    ${CONAN_LIB_DIRS_PROTOBUF}
)

# ———— 源文件列表 ————
file(GLOB_RECURSE SOURCES
    "${CMAKE_SOURCE_DIR}/src/*.cc"
    "${CMAKE_SOURCE_DIR}/src/*.cpp"
)

# ———— 构建共享库 ————
add_library(veins_libairmobisim SHARED ${SOURCES})

# 恢复默认 lib 前缀，但把输出名改为 veins_libairmobisim
set_target_properties(veins_libairmobisim PROPERTIES
    OUTPUT_NAME "veins_libairmobisim"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/src"
)

# ———— 链接依赖库 ————
target_link_libraries(veins_libairmobisim
    # 第一层：gRPC / protobuf
    gRPC::grpc++
    protobuf::libprotobuf
    oppsim # OMNeT++ 核心
    # Veins / INET / Simu5G
    veins
    veins_inet
    INET
    simu5g
)



