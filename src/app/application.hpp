#pragma once

#include "../util/messageBus.hpp"
#include <iostream>
#include <string>

namespace UW::App {

class Application {
public:
  Application() { bus = Bus::MessageBus(); }

public:
  Bus::MessageBus bus;
};
} // namespace UW::App