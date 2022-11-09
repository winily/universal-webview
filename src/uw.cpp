#include "../src/app/application.hpp"
#include "../src/util/util.hpp"
#include "../src/window/window.hpp"
#include "config/config.hpp"
#include "config/menu.hpp"
#include "config/window.hpp"

#include <filesystem>
#include <fstream>
#include <iostream>
#include <ostream>
#include <string>

using namespace UW;

int main(int argc, char *argv[]) {
  std::cout << argv[1] << std::endl;
  auto current_path = std::filesystem::current_path();

  std::filesystem::path path = "";
  path /= current_path;
  path /= argv[1];
  std::ifstream config_doc(path, std::ifstream::binary);
  Json::Value root;
  config_doc >> root;
  Config::Config config(root);
  // TODO 读配置文件启动
  auto app = App::Application();
  Window::Window window(config, app);
  // window.open("http://localhost:3000/");
  window.open("uwfile://native/index.html");
}
