add_executable(automata main.cpp)

add_subdirectory(app)
add_subdirectory(container)
add_subdirectory(sys)
add_subdirectory(util)
add_subdirectory(window)

target_link_libraries(automata
  PRIVATE
    app
    container
    sys
    util
    window
  )