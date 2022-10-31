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

#include "../../sys/sys.hpp"
#include "../window.hpp"
#include "../window_config.hpp"

#include "iostream"

NSWindow *_nswindow;
WKWebView *_nswebview;

NSString *toNSString(std::string str) {
  return [NSString stringWithUTF8String:str.c_str()];
}

// ------------ WKScriptMessageHandler end ------------

// 构造函数
Platform::Platform(WindowConfig &config, Application &app)
    : app(app), _config(config) {
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
  this->initWindow();
  this->initWebview();
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
    NSRect targetRect =
        CGRectMake(0, 0, this->_config.width, this->_config.height);
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

    if (this->_config.develop) {
      [_nswebview.configuration.preferences setValue:@YES
                                              forKey:@"developerExtrasEnabled"];
    }
  }
}

void Platform::initWindow() {
  @autoreleasepool {
    // Create the main window
    NSRect rc = NSMakeRect(this->_config.x, this->_config.y,
                           this->_config.width, this->_config.height);
    NSUInteger uiStyle = NSWindowStyleMaskTitled | NSWindowStyleMaskResizable |
                         NSWindowStyleMaskClosable |
                         NSWindowStyleMaskMiniaturizable;
    NSBackingStoreType backingStoreStyle = NSBackingStoreBuffered;
    _nswindow = [[NSWindow alloc] initWithContentRect:rc
                                            styleMask:uiStyle
                                              backing:backingStoreStyle
                                                defer:NO];
    auto title = toNSString(this->_config.title);
    [_nswindow setTitle:title];
    [_nswindow makeKeyAndOrderFront:_nswindow];
    [_nswindow makeMainWindow];
    // 控制窗口样式
    if (!this->_config.closable) {
      [_nswindow
          setStyleMask:[_nswindow styleMask] & ~NSWindowStyleMaskClosable];
    }
    if (!this->_config.miniaturizable) {
      [_nswindow setStyleMask:[_nswindow styleMask] &
                              ~NSWindowStyleMaskMiniaturizable];
    }
    if (!this->_config.resizable) {
      [_nswindow
          setStyleMask:[_nswindow styleMask] & ~NSWindowStyleMaskResizable];
    }
    if (!this->_config.title_bar) {
      [_nswindow setStyleMask:[_nswindow styleMask] & ~NSWindowStyleMaskTitled];
    }
    // 设置 icon
    auto icon_path = toNSString(this->_config.icon_path);
    NSImage *image = [[NSImage alloc] initWithContentsOfFile:icon_path];
    NSApp.applicationIconImage = image;
  }
}

// ----------- window 通用接口具体实现 -----------
Window::Window(WindowConfig &config, Application &app)
    : app(app), _config(config) {
  _platform = std::make_unique<Platform>(config, app);
  this->init();
};

void Window::init() {
  std::cout << "mac init function" << std::endl;
  this->_platform->init();
}