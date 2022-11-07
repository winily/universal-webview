#pragma once
#include "menu.hpp"
#include "window.hpp"
#include <cstddef>
#include <optional>

namespace UW::Config {
struct Config {
  Config() = default;
  Config(Json::Value root) {
    this->window = Window(root["root"]);
    this->menu = Menu(root["menu"]);
  }

  Window window{};
  Menu menu{};
};
} // namespace UW::Config