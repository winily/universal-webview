add_library(sys_api "")

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
  file(GLOB ENV_SOUYCES_PATH_CPP ${CMAKE_CURRENT_LIST_DIR}/*/*_linux.cpp)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
  file(GLOB ENV_SOUYCES_PATH_CPP ${CMAKE_CURRENT_LIST_DIR}/*/*_mac.mm)
else()
  file(GLOB ENV_SOUYCES_PATH_CPP ${CMAKE_CURRENT_LIST_DIR}/*/*_windows.cpp)
endif()

file(GLOB SOUYCES_PATH_HPP ${CMAKE_CURRENT_LIST_DIR}/*/*.hpp)
target_sources(sys_api
  PRIVATE
    ${ENV_SOUYCES_PATH_CPP}
  PUBLIC
    ${SOUYCES_PATH_HPP}
)

target_include_directories(sys_api
  PUBLIC
      ${CMAKE_CURRENT_LIST_DIR}
)