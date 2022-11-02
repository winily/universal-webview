#pragma once

#include <string>

namespace UW::Window {
struct WindowConfig {
  std::string title;
  std::string icon_path;
  bool resizable{true};
  bool closable{true};
  bool miniaturizable{true};
  bool title_bar{true};
  double x{0};
  double y{0};
  double width{800};
  double height{800};

  bool develop{true};
};
} // namespace UW::Window