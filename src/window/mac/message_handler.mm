#import "message_handler.h"

#include "../util/message.hpp"
#include "system_event/system_event.h"

#include <iostream>
#include <string>
@implementation MessageHandler
- (void)initEvent {
  // 定义一个固定通信接口
  [self.nswebview_.configuration.userContentController
      addScriptMessageHandlerWithReply:self
                          contentWorld:WKContentWorld.pageWorld
                                  name:@SYSTEM_EVENT];

  // [self.nswebview_.configuration.userContentController
  //     addScriptMessageHandlerWithReply:self
  //                         contentWorld:WKContentWorld.pageWorld
  //                                 name:@"open"];
}

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message
                 replyHandler:
                     (void (^)(id _Nullable reply,
                               NSString *_Nullable errorMessage))reply {
  std::string name([message.name UTF8String]);
  NSDictionary *body = message.body;

  self.platform_->evaluateJavaScript();

  // 暴露系统事件通信口给 js
  if ([message.name isEqualToString:@SYSTEM_EVENT]) {
    auto system_result = UW::Window::process_event(body);
    return reply(system_result, nil);
  }

  // if ([message.name isEqualToString:@"open"]) {
  //   self.platform_->load("https://www.baidu.com");
  //   return reply(@{
  //     @"success" : @"ok",
  //   },
  //                nil);
  // }

  // if ([message.name isEqualToString:@"clipboard::read"]) {

  //   std::cout << "clipboard::read" << std::endl;
  //   UW::Bus::Message msg("public.utf8-plain-text");
  //   auto result = self.platform_->app_.bus.emit(name, msg);
  // }

  NSDictionary *result = @{
    @"helloString" : @"Hello, World!",
  };
  reply(result, nil);
}
@end