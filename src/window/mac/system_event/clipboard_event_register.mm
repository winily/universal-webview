#include <Foundation/Foundation.h>
#include <_types/_uint32_t.h>

#include "../../../sys/clipboard/clipboard.hpp"
#include "clipboard_event_register.h"
#include "system_event.h"

#include <iostream>

NSDictionary *clipboard_clear() {
  std::cout << "调用剪贴板 clipboard_clear" << std::endl;
  Sys::Clipboard::Clear();
  return nullptr;
}

NSDictionary *clipboard_read(NSDictionary *data) {
  std::cout << "调用剪贴板 clipboard_read" << std::endl;
  auto format = [data[@"format"] UTF8String];
  std::cout << "调用剪贴板 clipboard_read format: " << format << std::endl;
  auto buffer_result = Sys::Clipboard::Read(format);

  NSString *string_result =
      [NSString stringWithCString:reinterpret_cast<char *>(buffer_result.bytes)
                         encoding:NSUTF8StringEncoding];
  return @{@"result" : string_result};
}

NSDictionary *clipboard_write(NSDictionary *data) {
  std::cout << "调用剪贴板 clipboard_write" << std::endl;
  auto byte = (uint8_t *)[data[@"data"] bytes];
  auto format = [data[@"format"] UTF8String];
  Buffer buffer{};
  buffer.bytes = byte;
  buffer.length = sizeof(byte) / 2;
  Sys::Clipboard::Write(format, buffer);
  return nullptr;
}

NSDictionary *clipboardEventSelector(SystemEvent event) {
  if (event.key == "clipboard::clear") {
    return clipboard_clear();
  }

  if (event.key == "clipboard::read") {
    return clipboard_read(event.data);
  }

  if (event.key == "clipboard::write") {
    return clipboard_write(event.data);
  }

  return nullptr;
}

// REGISTER_SYSTEM_EVENT("clipboard::clear", clipboard_clear);