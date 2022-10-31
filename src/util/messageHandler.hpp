#pragma once

#include "message.hpp"
namespace Bus {

class MessageHandler {
public:
  MessageHandler(std::string key) : _key(key) {}
  void on(Message message);

  std::string getKey() { return _key; }

private:
  std::string _key;
};
} // namespace Bus