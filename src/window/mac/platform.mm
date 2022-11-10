#import <AppKit/AppKit.h>
#import <Cocoa/Cocoa.h>
#import <CoreServices/CoreServices.h>
#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#include <iostream>
#import <memory>
#import <objc/objc-runtime.h>
#include <string>

#import "app_delegate.h"
#import "message_handler.h"
#import "platform.hpp"
#import "scheme_handler.h"

#include "../config/config.hpp"
#include "window.hpp"

#include "iostream"

namespace UW::Window {
// 构造函数
Platform::Platform(Config::Config &config, App::Application &app)
    : app_(app), config_(config) {
  auto app_delegate = [[AppDelegate alloc] init];
  @autoreleasepool {
    // 共享 application 实例，后续使用 NSApp 调用
    [NSApplication sharedApplication];

    [app_delegate setConfig:config_];
    [app_delegate setPlatform:this];
    NSApp.delegate = app_delegate;
  }
}

void Platform::load(std::string url) {
  @autoreleasepool {
    NSString *nsurl = [NSString stringWithUTF8String:url.c_str()];
    [(AppDelegate *)NSApp.delegate loadRequest:nsurl];
  }
}

void Platform::run() {
  initMenu();
  [NSApp run];
}
}