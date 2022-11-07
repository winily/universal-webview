#include "../src/app/application.hpp"
#include "../src/util/util.hpp"
#include "../src/window/window.hpp"
#include "config/config.hpp"
#include "config/menu.hpp"
#include "config/window.hpp"

#include <filesystem>
#include <fstream>
#include <iostream>
#include <string>

using namespace UW;

int main() {
  auto current_path = std::filesystem::current_path();
  auto config_path = "/Users/winily/Projects/Open-Source/super-clipboard/"
                     "universal-webview/uw.config.json";
  std::ifstream config_doc(config_path, std::ifstream::binary);
  Json::Value root;
  config_doc >> root;
  Config::Config config(root);
  // auto menu = app_config["menu"].as<Config::MenuConfig>();
  std::cout << "解析 json" << std::endl;

  // TODO 读配置文件启动

  // return 1;
  // Window::WindowConfig config{};
  // config.title = "第一窗口";
  // config.icon_path = "/Users/winily/Downloads/icon.png";
  // config.width = 1200;
  // config.height = 750;
  auto app = App::Application();
  Window::Window window(config, app);
  // window.open("http://localhost:3000/");
  window.open("uwfile://native/index.html");
}
