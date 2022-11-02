#include <AppKit/AppKit.h>
#include <Foundation/Foundation.h>
#include <_types/_uint32_t.h>
#include <_types/_uint8_t.h>

#include "../sys/clipboard/clipboard.hpp"
#include "clipboard_event_register.h"
#include "system_event.h"

#include <iostream>
namespace UW::Window {
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
  auto format = [data[@"format"] UTF8String];
  auto *clipdord_data = [data[@"data"] UTF8String];
  // Buffer buffer{};
  // buffer.bytes = (uint8_t *)clipdord_data.bytes;
  // buffer.length = (uint32_t)clipdord_data.length;
  Sys::Clipboard::Write(format, clipdord_data);
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
}