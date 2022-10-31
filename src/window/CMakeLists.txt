add_library(window "")

if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
  message(STATUS "------------------------Configuring on/for macOS------------------------")
  include(./mac/CMakeLists.txt)
endif()

message(STATUS ${SOUYCES_PATH})

target_sources(window
  PRIVATE
    ${SOUYCES_PATH}
    ${CMAKE_CURRENT_LIST_DIR}/window.cpp
  PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/window.hpp
    ${CMAKE_CURRENT_LIST_DIR}/window_config.hpp
  )

target_include_directories(window
PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}
)

# add_executable(webview-test main.cpp)
target_link_libraries(window sys)
