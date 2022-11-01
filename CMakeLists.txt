cmake_minimum_required(VERSION 3.0)
project(universal-webview LANGUAGES CXX)

enable_language(CXX)

include_directories(${CMAKE_CURRENT_LIST_DIR}/lib)


# if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
#   message(STATUS "Configuring on/for macOS")
#   enable_language(OBJC)
# endif()

# set(CMAKE_CXX_STANDARD 20)
# set(CMAKE_CXX_COMPILER "/usr/bin/g++")
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++20")
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# include(GNUInstallDirs)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_BINDIR})


# 编译后引入
# 配置依赖库
# add_library(yaml-cpp)
# 包含头文件
include_directories(${CMAKE_CURRENT_LIST_DIR}/lib/yaml-cpp-yaml-cpp-0.6.3/include)
link_directories(${CMAKE_CURRENT_LIST_DIR}/lib/yaml-cpp-yaml-cpp-0.6.3/build)

message(STATUS "========================================")
message(STATUS ${ROOT_PATH})

add_subdirectory(src)


# 复制 web 资源文件到 build 目录
execute_process(COMMAND cp -r ${CMAKE_CURRENT_LIST_DIR}/resource ${CMAKE_CURRENT_LIST_DIR}/build/resource)


# enable testing and define tests
enable_testing()
add_subdirectory(test)