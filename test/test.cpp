#include "../src/app/application.hpp"
#include "../src/config/config.hpp"
#include "../src/util/util.hpp"
#include "../src/window/window.hpp"

#include <iostream>

#define CATCH_CONFIG_MAIN
#include "../catch.hpp"

using namespace UW;

TEST_CASE("test") {

  std::cout << "hello world" << std::endl;
  UW::Config::Config config{};
  config.window_.title_ = "第一窗口";
  config.icon_path_ = "/Users/winily/Downloads/icon.png";
  config.window_.width_ = 1200;
  config.window_.height_ = 750;
  auto app = App::Application();
  Window::Window window(config, app);
  // window.open("http://localhost:3000/");
  window.open("uwfile://native/index.html");
  // window.open("https://www.zhihu.com");
  REQUIRE(true);
}
