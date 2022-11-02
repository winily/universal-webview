#pragma once

#include "../container/buffer.hpp"

#include <string>

namespace UW::Bus {

enum MessageType { EMPTY, STRING, BUFFER };

class Message {
public:
  Message() : _type(EMPTY) {}
  Message(Buffer val) : _type(BUFFER), _buffer_val(val) {}
  Message(std::string val) : _type(STRING), _string_val(val) {}
  MessageType getType() { return _type; }
  std::string getString() { return _string_val; }
  Buffer getBuffer() { return _buffer_val; }
  void setValue(std::string val) { _string_val = val; }
  void setValue(Buffer val) { _buffer_val = val; }

private:
  MessageType _type;
  Buffer _buffer_val;
  std::string _string_val;
};
} // namespace UW::Bus