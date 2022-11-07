#pragma once

#include "json/value.h"
#include <string>

namespace UW::Config {
struct Window {
  Window() = default;
  Window(Json::Value window) {
    title = window["title"].asString();
    icon_path = window["icon_path"].asString();

    resizable = window.get("resizable", true).asBool();
    closable = window.get("closable", true).asBool();
    miniaturizable = window.get("miniaturizable", true).asBool();
    title_bar = window.get("title_bar", true).asBool();
    develop = window.get("develop", true).asBool();

    x = window.get("x", 0).asDouble();
    y = window.get("y", 0).asDouble();
    width = window.get("width", 800).asDouble();
    height = window.get("height", 800).asDouble();
  }

  std::string title;
  std::string icon_path;

  bool resizable{true};
  bool closable{true};
  bool miniaturizable{true};
  bool title_bar{true};
  bool develop{true};

  double x{0};
  double y{0};
  double width{800};
  double height{800};
};
} // namespace UW::Config