#import "message_handler.h"

#include "../util/message.hpp"
#include "system_event/system_event.h"

#include <iostream>
#include <string>

@implementation MessageHandler
- (void)initEvent {

  std::cout << "init system event" << std::endl;
  // 定义一个固定通信接口
  [self._nswebview.configuration.userContentController
      addScriptMessageHandlerWithReply:self
                          contentWorld:WKContentWorld.pageWorld
                                  name:@SYSTEM_EVENT];

  std::cout << "initEvent" << std::endl;
  // [self._nswebview.configuration.userContentController
  //     addScriptMessageHandler:self
  //                        name:@"jsToOc"];
  // [self._nswebview.configuration.userContentController
  //     addScriptMessageHandler:self
  //                        name:@"clipboard::read"];
}

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message
                 replyHandler:
                     (void (^)(id _Nullable reply,
                               NSString *_Nullable errorMessage))reply {
  std::string name([message.name UTF8String]);
  std::cout << "有事件进入 name: " << name << std::endl;
  NSDictionary *body = message.body;
  std::cout << "有事件进入 body: key: " << body[@"key"] << std::endl;
  std::cout << "有事件进入 body: data: " << body[@"data"] << std::endl;

  // 暴露系统事件通信口给 js
  if ([message.name isEqualToString:@SYSTEM_EVENT]) {
    std::cout << "调用了系统事件通信口" << std::endl;
    auto system_result = process_event(body);
    std::cout << "系统事件通信口调用完毕" << std::endl;
    return reply(system_result, nil);
  }

  // const FORMAT_PLAIN_TEXT = 'public.utf8-plain-text'
  // const FORMAT_FILE_URL = 'public.file-url'
  // webkit.messageHandlers['clipboard::read'].postMessage({})
  if ([message.name isEqualToString:@"clipboard::read"]) {

    std::cout << "clipboard::read" << std::endl;
    Bus::Message msg("public.utf8-plain-text");
    // Bus::Message msg("你猜猜这是什么！");
    auto result = self._platform->app.bus.emit(name, msg);
    std::cout << "clipboard::read 事件执行结束" << std::endl;
    std::cout << "clipboard::read 拿到了返回值"
              << std::string(reinterpret_cast<char *>(result.getBuffer().bytes))
              << std::endl;
  }

  NSDictionary *result = @{
    @"helloString" : @"Hello, World!",
  };
  reply(result, nil);
}
@end