add_library(universal-webview main.cpp)

add_subdirectory(app)
add_subdirectory(config)
add_subdirectory(container)
add_subdirectory(sys_api)
add_subdirectory(util)
add_subdirectory(window)

target_link_libraries(universal-webview
  PRIVATE
    app
    config
    container
    sys_api
    util
    window

    jsoncpp
  )

add_executable(uw uw.cpp)

link_libraries(jsoncpp)

target_link_libraries(uw universal-webview jsoncpp)