add_library(app "")


target_sources(app
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/application.cpp
  PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/application.hpp
)

target_include_directories(app
  PUBLIC
      ${CMAKE_CURRENT_LIST_DIR}
)