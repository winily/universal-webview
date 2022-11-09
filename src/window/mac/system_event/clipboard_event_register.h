#pragma once

#include "../sys_api/clipboard/clipboard.hpp"
#include "system_event.h"
#include <map>
#include <string>

namespace UW::Window::Event {
NSDictionary *clipboardEventSelector(SystemEvent event);
}