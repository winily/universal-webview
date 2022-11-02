#include "system_event_handler.h"

#include "clipboard_event_register.h"

#include <Foundation/Foundation.h>

#include <iostream>
#include <map>
#include <string>

// std::map<std::string, SystemEventHandler> SYSTEM_EVENT_TABLE();

// clipboardEventRegister(SYSTEM_EVENT_TABLE);

namespace UW::Window {
NSDictionary *selector(SystemEvent event) {

  NSDictionary *result = @{};

  if ((result = clipboardEventSelector(event)) != nullptr)
    return result;

  // for (const auto &[key, value] : SYSTEM_EVENT_TABLE) {
  //   if (event.key.compare(key)) {
  //     return value(event.data);
  //   }
  // }
  return result;
}

NSDictionary *process_event(NSDictionary *body) {
  auto event = SystemEvent();
  event.key = [body[@"key"] UTF8String];
  event.data = body[@"data"];
  std::cout << "进入一个事件，准备选择api运行 key:" << event.key << std::endl;
  return selector(event);
}
}