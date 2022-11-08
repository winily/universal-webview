#import "platform.hpp"
#include <AppKit/AppKit.h>
#include <WebKit/WebKit.h>

namespace UW::Window {
void Platform::evaluateJavaScript() {
  auto _nswindow = NSApp.mainWindow;
  auto _nswebview = NSApp.mainWindow.contentView;
  [_nswebview evaluateJavaScript:@"document.title"
               completionHandler:^(NSString *title, NSError *error) {
                 std::cout << [title UTF8String] << std::endl;
                 [_nswindow setTitle:title];
               }];
}
}