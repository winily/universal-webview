#pragma once

#include "json/value.h"
#include <string>

namespace UW::Config {
class Window {
public:
  Window() = default;
  Window(Json::Value window) {
    title_ = window["title"].asString();
    icon_path_ = window["icon_path"].asString();

    resizable_ = window.get("resizable", true).asBool();
    closable_ = window.get("closable", true).asBool();
    miniaturizable_ = window.get("miniaturizable", true).asBool();
    title_bar_ = window.get("title_bar", true).asBool();
    develop_ = window.get("develop", true).asBool();

    x_ = window.get("x", 0).asDouble();
    y_ = window.get("y", 0).asDouble();
    width_ = window.get("width", 800).asDouble();
    height_ = window.get("height", 800).asDouble();
  }

  std::string title_;
  std::string icon_path_;

  bool resizable_{true};
  bool closable_{true};
  bool miniaturizable_{true};
  bool title_bar_{true};
  bool develop_{true};

  double x_{0};
  double y_{0};
  double width_{800};
  double height_{800};
};
} // namespace UW::Config