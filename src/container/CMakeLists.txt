add_library(container "")


target_sources(container
  PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}/container.cpp
  PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/buffer.hpp
)

target_include_directories(container
  PUBLIC
      ${CMAKE_CURRENT_LIST_DIR}
)