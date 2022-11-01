#include "../src/app/application.hpp"
#include "../src/util/util.hpp"
#include "../src/window/window.hpp"
#include "../src/window/window_config.hpp"

#include <iostream>

#include "yaml-cpp/yaml.h"

#define CATCH_CONFIG_MAIN
#include "../catch.hpp"

TEST_CASE("test") {

  YAML::Node node = YAML::Load("[1, 2, 3]");
  assert(node.Type() != YAML::NodeType::Sequence);
  assert(node.IsSequence()); // a shortcut!

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
  REQUIRE(true);
}
