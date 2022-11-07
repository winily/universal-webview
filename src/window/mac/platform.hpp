#pragma once

#include "../../app/application.hpp"
#include "../../config/config.hpp"

namespace UW::Window {
class Platform {
public:
  Platform(Config::Window &window_config, App::Application &app);

  // 稀构函数，代理 Objective-C 的内存回收
  // ~Platform() { [_pool drain]; }
  void load(std::string url);

  void run();
  void init();

  void evaluateJavaScript();

public:
  App::Application &app;

private:
  void initWebview();
  void initWindow();

private:
  Config::Window &config_;
};

// class Platform;
// void Platform::run();
} // namespace UW::Window