#include "../window.hpp"
#include "iostream"

Window::Window(WindowConfig config) : _config(config) { this->init(); };
void Window::init() { std::cout << "windows init function" << std::endl; }