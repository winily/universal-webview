#include "../src/app/application.hpp"
#include "../src/util/util.hpp"
#include "../src/window/window.hpp"
#include "../src/window/window_config.hpp"

#include <iostream>

#define CATCH_CONFIG_MAIN
#include "../catch.hpp"

using namespace UW;

TEST_CASE("test") {

  std::cout << "hello world" << std::endl;
  Window::WindowConfig config{};
  config.title = "第一窗口";
  config.icon_path = "/Users/winily/Downloads/icon.png";
  config.width = 1200;
  config.height = 750;
  auto app = App::Application();
  Window::Window window(config, app);
  // window.open("http://localhost:3000/");
  window.open("uwfile://native/index.html");
  // window.open("https://www.zhihu.com");
  REQUIRE(true);
}
