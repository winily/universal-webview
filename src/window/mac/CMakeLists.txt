message(STATUS "引入 MacOs 依赖 设置代码源文件")

enable_language(OBJC)


file(GLOB OC_ROOT_SOUYCES_PATH ${CMAKE_CURRENT_LIST_DIR}/*.mm)
file(GLOB OC_SYSTEM_EVENT_SOUYCES_PATH ${CMAKE_CURRENT_LIST_DIR}/system_event/*.mm)
set(
  SOUYCES_PATH 
    ${OC_ROOT_SOUYCES_PATH}
    # ${CMAKE_CURRENT_LIST_DIR}/window.mm
    # ${CMAKE_CURRENT_LIST_DIR}/message_handler.mm
    # ${CMAKE_CURRENT_LIST_DIR}/scheme_handler.mm
    ${OC_SYSTEM_EVENT_SOUYCES_PATH}
  )

target_link_libraries(window "-framework Cocoa -framework AppKit -framework CoreData")
target_link_libraries(window "-framework Foundation -framework WebKit")