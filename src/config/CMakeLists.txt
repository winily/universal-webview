add_library(config "")

file(GLOB SOUYCES_PATH ${CMAKE_CURRENT_LIST_DIR}/*.hpp)

target_sources(config
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/config.cpp
  PUBLIC
    ${SOUYCES_PATH}
)

target_include_directories(config
  PUBLIC
      ${CMAKE_CURRENT_LIST_DIR}
)