#pragma once

#import <AppKit/AppKit.h>
#import <WebKit/WebKit.h>

#import "platform.hpp"

#define SYSTEM_EVENT "system::event"

// 不需要回复 js 响应使用 MessageHandler 需要回复响应使用
// WKScriptMessageHandlerWithReply
// @interface MessageHandler : NSObject <WKScriptMessageHandler>
@interface MessageHandler : NSObject <WKScriptMessageHandlerWithReply>
@property(nonatomic) UW::Window::Platform *_platform;
@property(nonatomic, assign) WKWebView *_nswebview;
- (void)initEvent;
@end