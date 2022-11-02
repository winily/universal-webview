#pragma once
#include "../app/application.hpp"
#include "window_config.hpp"

namespace UW::Window {
class Platform {
public:
  Platform(WindowConfig &config, App::Application &app)
      : _config(config), app(app){};

  App::Application &app;

private:
  WindowConfig &_config;
};
} // namespace UW::Window