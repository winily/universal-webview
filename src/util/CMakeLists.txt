add_library(util "")

target_sources(util
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/util.cpp
  PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/messageBus.hpp
    ${CMAKE_CURRENT_LIST_DIR}/messageHandler.hpp
    ${CMAKE_CURRENT_LIST_DIR}/util.hpp
)

MESSAGE(STATUS ${CMAKE_CURRENT_LIST_DIR})

target_include_directories(util
  PUBLIC
      ${CMAKE_CURRENT_LIST_DIR}
)