#pragma once
#include "menu.hpp"
#include "window.hpp"
#include <cstddef>
#include <optional>

namespace UW::Config {
class Config {
public:
  Config() = default;
  Config(Json::Value root) {
    window_ = Window(root["root"]);
    menu_ = Menu(root["menu"]);
  }

  Window window_{};
  Menu menu_{};
};
} // namespace UW::Config