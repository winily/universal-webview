#import <AppKit/AppKit.h>
#import <Cocoa/Cocoa.h>
#import <CoreServices/CoreServices.h>
#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#include <iostream>
#import <memory>
#import <objc/objc-runtime.h>
#include <string>

#import "message_handler.h"
#import "platform.hpp"
#import "scheme_handler.h"

#include "../config/config.hpp"
#include "../sys/sys.hpp"
#include "window.hpp"

#include "iostream"

namespace UW::Window {

NSWindow *_nswindow;
WKWebView *_nswebview;

NSString *toNSString(std::string str) {
  return [NSString stringWithUTF8String:str.c_str()];
}

// ------------ WKScriptMessageHandler end ------------

// 构造函数
Platform::Platform(Config::Window &config, App::Application &app)
    : app(app), config_(config) {
  @autoreleasepool {
    // 共享 application 实例，后续使用 NSApp 调用
    [NSApplication sharedApplication];

    // 设置窗口激活类型，!!不设置 Dock 不显示磁贴
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
    [NSApp activateIgnoringOtherApps:YES];
  }
}

void Platform::load(std::string url) {
  @autoreleasepool {
    NSString *nsurl = [NSString stringWithUTF8String:url.c_str()];
    NSURL *nurl = [NSURL URLWithString:nsurl];
    NSString *scheme = nurl.scheme.lowercaseString;

    std::cout << "isfile" << [scheme UTF8String] << std::endl;

    // NSURLRequest *request =
    //     [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:nurl]];
    // [_nswebview loadRequest:request];
    [_nswebview loadRequest:[NSURLRequest requestWithURL:nurl]];
  }
}

void Platform::run() { [NSApp run]; }

void Platform::init() {
  initWindow();
  initWebview();
  _nswindow.contentView = _nswebview;
}

void Platform::evaluateJavaScript() {
  [_nswebview evaluateJavaScript:@"document.title"
               completionHandler:^(NSString *title, NSError *error) {
                 std::cout << [title UTF8String] << std::endl;
                 [_nswindow setTitle:title];
               }];
}

// -----------------private-----------------
void Platform::initWebview() {
  @autoreleasepool {
    // NSRect screenSize = NSScreen.mainScreen.frame;
    NSRect targetRect = CGRectMake(0, 0, config_.width_, config_.height_);
    auto schemeHandler = [[SchemeHandler alloc] init];

    WKWebViewConfiguration *config = [WKWebViewConfiguration new];

    // 添加自定义类型请求拦截
    [config setURLSchemeHandler:schemeHandler forURLScheme:@"uwfile"];

    WKUserContentController *userContentController =
        [[WKUserContentController alloc] init];
    config.userContentController = userContentController;
    // [config.userContentController.addScriptMessageHandler:controller
    //                                                  name:@"jsToOc"];

    MessageHandler *controller = [[MessageHandler alloc] init];

    _nswebview = [[WKWebView<NSWindowDelegate> alloc] initWithFrame:targetRect
                                                      configuration:config];
    controller._platform = this;
    controller._nswebview = _nswebview;

    [controller initEvent];
    // [_nswebview.configuration.userContentController
    //     addScriptMessageHandler:controller
    //                        name:@"jsToOc"];
    // [_nswebview.configuration.userContentController
    //     addScriptMessageHandler:controller
    //                        name:@"clipboard::read"];

    [_nswebview setAutoresizesSubviews:YES];
    [_nswebview setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];

    if (config_.develop_) {
      [_nswebview.configuration.preferences setValue:@YES
                                              forKey:@"developerExtrasEnabled"];
    }
  }
}

void Platform::initWindow() {
  @autoreleasepool {
    // Create the main window
    NSRect rc =
        NSMakeRect(config_.x_, config_.y_, config_.width_, config_.height_);
    NSUInteger uiStyle = NSWindowStyleMaskTitled | NSWindowStyleMaskResizable |
                         NSWindowStyleMaskClosable |
                         NSWindowStyleMaskMiniaturizable;
    NSBackingStoreType backingStoreStyle = NSBackingStoreBuffered;
    _nswindow = [[NSWindow alloc] initWithContentRect:rc
                                            styleMask:uiStyle
                                              backing:backingStoreStyle
                                                defer:NO];
    auto title = toNSString(config_.title_);
    [_nswindow setTitle:title];
    [_nswindow makeKeyAndOrderFront:_nswindow];
    [_nswindow makeMainWindow];
    // 控制窗口样式
    if (!config_.closable_) {
      [_nswindow
          setStyleMask:[_nswindow styleMask] & ~NSWindowStyleMaskClosable];
    }
    if (!config_.miniaturizable_) {
      [_nswindow setStyleMask:[_nswindow styleMask] &
                              ~NSWindowStyleMaskMiniaturizable];
    }
    if (!config_.resizable_) {
      [_nswindow
          setStyleMask:[_nswindow styleMask] & ~NSWindowStyleMaskResizable];
    }
    if (!config_.title_bar_) {
      [_nswindow setStyleMask:[_nswindow styleMask] & ~NSWindowStyleMaskTitled];
    }
    // 设置 icon
    auto icon_path = toNSString(config_.icon_path_);
    NSImage *image = [[NSImage alloc] initWithContentsOfFile:icon_path];
    NSApp.applicationIconImage = image;
  }
}

// ----------- window 通用接口具体实现 -----------
Window::Window(Config::Config &config, App::Application &app)
    : app_(app), config_(config) {
  platform_ = std::make_unique<Platform>(config_.window_, app);
  init();
};

void Window::init() {
  std::cout << "mac init function" << std::endl;
  platform_->init();
}
}