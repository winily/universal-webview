#pragma once
#include "../../app/application.hpp"
#include "../window_config.hpp"
class Platform {
public:
  Platform(WindowConfig &config, Application &app)
      : _config(config), app(app){};

  Application &app;

private:
  WindowConfig &_config;
};