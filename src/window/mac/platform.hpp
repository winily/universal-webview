#pragma once

#include "../../app/application.hpp"
#include "../../config/config.hpp"

namespace UW::Window {
class Platform {
public:
  Platform(Config::Config &config, App::Application &app);

  // 析构函数，代理 Objective-C 的内存回收
  // ~Platform() { [_pool drain]; }
  void load(std::string url);

  void run();
  void evaluateJavaScript();

public:
  App::Application &app_;

private:
  void initMenu();

private:
  Config::Config &config_;
};
} // namespace UW::Window