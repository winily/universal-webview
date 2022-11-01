add_executable(uwtest test.cpp)
target_link_libraries(uwtest universal-webview)

add_test(
  NAME
    test_universal_webview
  COMMAND
    $<TARGET_FILE:uwtest>
  )