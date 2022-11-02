#pragma once

#include <Foundation/Foundation.h>
#include <string>

namespace UW::Window {

NSDictionary *process_event(NSDictionary *body);

struct SystemEvent {
  std::string key;
  NSDictionary *data;
};

}