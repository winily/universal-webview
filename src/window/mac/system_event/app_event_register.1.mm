#include <AppKit/AppKit.h>

#include "system_event.h"

#include <iostream>
namespace UW::Window::Event {
NSDictionary *app_terminate() {
  [NSApp terminate:nil];
  return nullptr;
}

NSDictionary *app_hide() {
  if (!NSApp.isHidden)
    [NSApp hide:nil];
  return nullptr;
}

NSDictionary *app_show() {
  if (NSApp.isHidden) {
    [NSApp unhide:nil];
    [NSApp activateIgnoringOtherApps:YES];
  }
  return nullptr;
}

NSDictionary *appEventSelector(SystemEvent event) {
  if (event.key == "app::terminate")
    return app_terminate();

  if (event.key == "app::hide")
    return app_hide();

  if (event.key == "app::show")
    return app_show();

  return nullptr;
}
}