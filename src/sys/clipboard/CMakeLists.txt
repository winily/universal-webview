

if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
  message(STATUS "剪贴板 引入 MacOs 依赖")
  message(STATUS "------------------------Configuring on/for macOS------------------------")

  target_sources(sys
    PRIVATE
      ${CMAKE_CURRENT_LIST_DIR}/clipboard_mac.mm
  )

  target_link_libraries(sys "-framework AppKit -framework CoreData")
  target_link_libraries(sys "-framework Foundation")
endif()
