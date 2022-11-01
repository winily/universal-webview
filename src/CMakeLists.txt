add_library(universal-webview main.cpp)
# add_executable(universal-webview main.cpp)

add_subdirectory(app)
add_subdirectory(container)
add_subdirectory(sys)
add_subdirectory(util)
add_subdirectory(window)

target_link_libraries(universal-webview
  PRIVATE
    app
    container
    sys
    util
    window

    yaml-cpp
  )