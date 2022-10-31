#include "app/application.hpp"
#include "util/util.hpp"
#include "window/window.hpp"
#include "window/window_config.hpp"

#include <iostream>

int main() {
  std::cout << "hello world" << std::endl;
  WindowConfig config{};
  config.title = "第一窗口";
  config.icon_path = "/Users/winily/Downloads/icon.png";
  config.width = 1200;
  config.height = 750;
  auto app = Application();
  Window window(config, app);
  // window.open("http://localhost:3000/");
  window.open("uwfile://native/index.html");
  // window.open("https://www.zhihu.com");
  return 0;
}