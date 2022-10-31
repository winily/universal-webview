#import "scheme_handler.h"
#include <Foundation/Foundation.h>
#include <filesystem>
#include <iostream>

auto mathContentType(NSString *extension) {
  NSDictionary *contentTypeTable = @{
    @"html" : @"text/html;charset=utf-8",
    @"js" : @"application/javascript;charset=utf-8",
    @"css" : @"text/css; charset=utf-8",
    @"png" : @"image/png",
    @"gif" : @"image/gif",
    @"jpg" : @"image/jpeg",
    @"jpeg" : @"image/jpeg",
    @"svg" : @"image/svg+xml",
  };

  if ([[contentTypeTable allKeys] containsObject:extension]) {
    NSString *contentType = contentTypeTable[extension];
    return contentType;
  }

  return @"text/plain";
}

// uwfile 自定义协议，用来访问本地资源

@implementation SchemeHandler

- (void)webView:(WKWebView *)webView
    startURLSchemeTask:(id<WKURLSchemeTask>)urlSchemeTask {
  NSString *scheme = urlSchemeTask.request.URL.scheme.lowercaseString;
  if ([scheme isEqualToString:@"uwfile"]) {
    auto urlPath = urlSchemeTask.request.URL.relativePath;

    auto baseUrl =
        [NSString stringWithUTF8String:std::filesystem::current_path().c_str()];
    baseUrl = [baseUrl stringByAppendingString:@"/resource"];

    auto filePath = [baseUrl stringByAppendingString:urlPath];
    auto contentType = mathContentType([filePath pathExtension]);

    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc]
         initWithURL:urlSchemeTask.request.URL
          statusCode:200
         HTTPVersion:@"HTTP/1.1"
        headerFields:@{@"Content-Type" : contentType}];
    [urlSchemeTask didReceiveResponse:response];
    [urlSchemeTask didReceiveData:data];
    [urlSchemeTask didFinish];
  }
}

- (void)webView:(WKWebView *)webView
    stopURLSchemeTask:(id<WKURLSchemeTask>)urlSchemeTask {
}

@end