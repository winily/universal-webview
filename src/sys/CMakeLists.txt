add_library(sys "")


target_sources(sys
  # PRIVATE
  #   ${CMAKE_CURRENT_LIST_DIR}/sys.cpp
  PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/sys.hpp
)

include(./clipboard/CMakeLists.txt)

target_include_directories(sys
  PUBLIC
      ${CMAKE_CURRENT_LIST_DIR}
)

# target_link_libraries(sys
#   PRIVATE
#     fs
#   )