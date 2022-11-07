#pragma once

#include "../app/application.hpp"
#include "../config/config.hpp"
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
  Window(Config::Config &config, App::Application &app);

  void open(std::string url) {
    platform_->load(url);
    platform_->run();
  }

public:
  App::Application &app_;

private:
  Config::Config &config_;
  std::unique_ptr<Platform> platform_ = nullptr;
  // 初始化窗口样式
  void init();
};
} // namespace UW::Window