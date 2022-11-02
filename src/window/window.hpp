#pragma once

#include "../app/application.hpp"
#include "window_config.hpp"
// #include <memory>

#if defined(__linux__)
#include "linux/platform.hpp"
#elif defined(__WIN32__)
#include "windows/platform.hpp"
#elif defined(__APPLE__)
#include "mac/platform.hpp"
#endif

namespace UW::Window {
class Window {
public:
  Window(WindowConfig &config, App::Application &app);

  void open(std::string url) {
    this->_platform->load(url);
    this->_platform->run();
  }

public:
  App::Application &app;

private:
  WindowConfig &_config;
  std::unique_ptr<Platform> _platform = nullptr;
  // 初始化窗口样式
  void init();
};
} // namespace UW::Window