#include "./clipboard.hpp"

#include <cstdint>

#import <AppKit/AppKit.h>
#import <CoreServices/CoreServices.h>
#import <Foundation/Foundation.h>

namespace Sys {
namespace Clipboard {

void Clear() { [NSPasteboard.generalPasteboard clearContents]; }
// 读取剪贴板
Buffer Read(std::string format) {
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  NSString *dataType = [NSString stringWithUTF8String:format.c_str()];
  NSData *data = [NSPasteboard.generalPasteboard dataForType:dataType];
  uint8_t *bytes = (uint8_t *)data.bytes;
  uint32_t length = (uint32_t)data.length;
  [pool drain];
  return Buffer{.bytes = bytes, .length = length};
}
// 写入剪贴板
bool Write(std::string format_str, Buffer buffer) {
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  NSString *format = [NSString stringWithUTF8String:format_str.c_str()];

  uint8_t *buf = buffer.bytes;
  size_t length = buffer.length;

  NSData *data = [NSData dataWithBytes:buf length:(NSUInteger)length];
  [NSPasteboard.generalPasteboard declareTypes:@[ format ] owner:nil];
  BOOL success = [NSPasteboard.generalPasteboard setData:data forType:format];
  [pool drain];
  return success;
}
}
}