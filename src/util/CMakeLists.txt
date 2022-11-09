add_library(util "")



if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    file(GLOB ENV_SOUYCES_PATH_CPP ${CMAKE_CURRENT_LIST_DIR}/*_windows.cpp)
    message(STATUS "window 配置")
else()
    file(GLOB ENV_SOUYCES_PATH_CPP ${CMAKE_CURRENT_LIST_DIR}/*_mac.cpp)
    message(STATUS "其他配置")
endif()

file(GLOB SOUYCES_PATH_HPP ${CMAKE_CURRENT_LIST_DIR}/*.hpp)
# file(GLOB SOUYCES_PATH_CPP ${CMAKE_CURRENT_LIST_DIR}/*.cpp)
target_sources(util
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/util.cpp
    ${ENV_SOUYCES_PATH_CPP}
  PUBLIC
    ${SOUYCES_PATH_HPP}
)

MESSAGE(STATUS ${ENV_SOUYCES_PATH_CPP})
MESSAGE(STATUS ${CMAKE_CURRENT_LIST_DIR})

target_include_directories(util
  PUBLIC
      ${CMAKE_CURRENT_LIST_DIR}
)