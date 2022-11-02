#pragma once

#include <map>
#include <string>
#include <utility>
#include <vector>

#include "../container/buffer.hpp"
#include "message.hpp"
#include "messageHandler.hpp"

namespace UW::Bus {

typedef Message (*handler)(Message);

class MessageBus {
public:
  void on(std::string key, handler handler) {
    _handler_vector.insert(std::make_pair(key, handler));
  }

  Message emit(std::string key, Message val) {
    if (_handler_vector.contains(key)) {
      return _handler_vector[key](val);
    }
    return Message();
  }

private:
  std::map<std::string, handler> _handler_vector;
};
} // namespace UW::Bus