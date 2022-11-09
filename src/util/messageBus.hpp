#pragma once

#include <functional>
#include <map>
#include <string>
#include <utility>
#include <vector>

#include "../container/buffer.hpp"
#include "message.hpp"

namespace UW::Bus {

class MessageBus {
public:
  void on(std::string key, std::function<Message(Message)> const &handler) {
    _handler_vector.insert(std::make_pair(key, handler));
  }

  Message emit(std::string key, Message val) {
    if (_handler_vector.count(key)) {
      return _handler_vector[key](val);
    }
    return Message();
  }

private:
  std::map<std::string, std::function<Message(Message)>> _handler_vector;
};
} // namespace UW::Bus