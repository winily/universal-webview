#pragma once

#include "../app/application.hpp"
#include "../config/config.hpp"
#include <iostream>
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
  Window(Config::Config &config, App::Application &app)
      : app_(app), config_(config) {
    platform_ = std::make_unique<Platform>(config_, app);
  };

  void open(std::string url) {
    app_.bus.on("applicationDidFinishLaunching",
                [this, url](Bus::Message message) -> Bus::Message {
                  std::cout
                      << "Message BUS applicationDidFinishLaunching 事件通知"
                      << std::endl;
                  platform_->load(url);
                  return Bus::Message{};
                });
    platform_->run();
  }

public:
  App::Application &app_;

private:
  Config::Config &config_;
  std::unique_ptr<Platform> platform_ = nullptr;
};
} // namespace UW::Window