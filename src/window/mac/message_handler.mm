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
}

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message
                 replyHandler:
                     (void (^)(id _Nullable reply,
                               NSString *_Nullable errorMessage))reply {
  std::string name([message.name UTF8String]);
  NSDictionary *body = message.body;

  // 暴露系统事件通信口给 js
  if ([message.name isEqualToString:@SYSTEM_EVENT]) {
    auto system_result = UW::Window::Event::process_event(body);
    return reply(system_result, nil);
  }

  NSDictionary *result = @{
    @"helloString" : @"Hello, World!",
  };
  reply(result, nil);
}
@end