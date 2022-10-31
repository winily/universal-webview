#pragma once

#include <Foundation/Foundation.h>
#include <string>

NSDictionary *process_event(NSDictionary *body);

struct SystemEvent {
  std::string key;
  NSDictionary *data;
};