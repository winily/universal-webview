#pragma once
#include "menu.hpp"
#include "window.hpp"
#include <cstddef>
#include <optional>
#include <string>

namespace UW::Config {
class Config {
public:
  Config() = default;
  Config(Json::Value root) {
    icon_path_ = root["icon_path"].asString();
    main_path_ = root["main_path"].asString();
    window_ = Window(root["window"]);
    menu_ = Menu(root["menu"]);
  }

  std::string icon_path_;
  std::string main_path_;

  Window window_{};
  Menu menu_{};
};
} // namespace UW::Config