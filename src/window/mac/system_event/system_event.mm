#include "app_event_register.h"
#include "clipboard_event_register.h"

#include <Foundation/Foundation.h>

#include <iostream>
#include <map>
#include <string>

namespace UW::Window::Event {
NSDictionary *selector(SystemEvent event) {

  NSDictionary *result = @{};

  if ((result = clipboardEventSelector(event)) != nullptr)
    return result;

  if ((result = appEventSelector(event)) != nullptr)
    return result;

  return result;
}

NSDictionary *process_event(NSDictionary *body) {
  auto event = SystemEvent();
  event.key = [body[@"key"] UTF8String];
  event.data = body[@"data"];
  return selector(event);
}
}