#pragma once
#include <cstdint>

namespace UW {
struct Buffer {
  uint8_t *bytes;
  uint32_t length;
};
} // namespace UW