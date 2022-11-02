#pragma once

#include "../sys/clipboard/clipboard.hpp"
#include "../util/messageBus.hpp"
#include <iostream>
#include <string>

namespace UW::App {

class Application {
public:
  Application() {
    bus = Bus::MessageBus();
    bus.on("clipboard::read", [](Bus::Message message) -> Bus::Message {
      std::cout << message.getString() << "clipboard::read application on bus"
                << std::endl;
      auto val = Sys::Clipboard::Read(message.getString());
      std::cout << "application on bus 调用 Clipboard::Read 结束" << std::endl;
      return Bus::Message(val);
    });
  }

public:
  Bus::MessageBus bus;
};
} // namespace UW::App