#include "window.hpp"
#include "iostream"

namespace UW::Window {
Window::Window(WindowConfig &config, App::Application &app)
    : app(app), _config(config) {
  _platform = std::make_unique<Platform>(config, app);
  this->init();
};
void Window::init() { std::cout << "linux init function" << std::endl; }
} // namespace UW::Window