#pragma once

// #include <Foundation/Foundation.h>

#include "../sys/clipboard/clipboard.hpp"
#include "../sys/clipboard/clipboard_event.hpp"

#include "system_event.h"
#include <map>
#include <string>

// NSDictionary *clipboard_clear(NSDictionary *data);

NSDictionary *clipboardEventSelector(SystemEvent event);
