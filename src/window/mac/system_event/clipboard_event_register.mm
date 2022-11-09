#include <AppKit/AppKit.h>
#include <Foundation/Foundation.h>
#include <_types/_uint32_t.h>
#include <_types/_uint8_t.h>

#include "../sys/clipboard/clipboard.hpp"
#include "clipboard_event_register.h"
#include "system_event.h"

#include <iostream>
namespace UW::Window::Event {
NSDictionary *clipboard_clear() {
  Sys::Clipboard::Clear();
  return nullptr;
}

NSDictionary *clipboard_read(NSDictionary *data) {
  auto format = [data[@"format"] UTF8String];
  auto buffer_result = Sys::Clipboard::Read(format);

  NSString *string_result =
      [NSString stringWithCString:reinterpret_cast<char *>(buffer_result.bytes)
                         encoding:NSUTF8StringEncoding];
  return @{@"result" : string_result};
}

NSDictionary *clipboard_write(NSDictionary *data) {
  auto format = [data[@"format"] UTF8String];
  auto *clipdord_data = [data[@"data"] UTF8String];
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