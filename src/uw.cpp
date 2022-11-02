#include "../src/app/application.hpp"
#include "../src/util/util.hpp"
#include "../src/window/window.hpp"
#include "../src/window/window_config.hpp"
#include "yaml-cpp/node/node.h"
#include "yaml-cpp/node/parse.h"

#include <filesystem>
#include <iostream>
#include <string>

using namespace UW;

int main() {
  // auto current_path = std::filesystem::current_path();
  // auto config_path = "/Users/winily/Projects/Open-Source/super-clipboard/"
  //                    "universal-webview/uw.config.json";
  // YAML::Node app_config = YAML::Load(config_path);
  // // TODO 读配置文件启动
  // std::cout << "hello world" << app_config["navigation"].as<std::string>()
  //           << std::endl;

  // return 1;
  Window::WindowConfig config{};
  config.title = "第一窗口";
  config.icon_path = "/Users/winily/Downloads/icon.png";
  config.width = 1200;
  config.height = 750;
  auto app = App::Application();
  Window::Window window(config, app);
  // window.open("http://localhost:3000/");
  window.open("uwfile://native/index.html");
}
