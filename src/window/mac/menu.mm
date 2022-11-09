#import "platform.hpp"
#include <AppKit/AppKit.h>
#include <Foundation/Foundation.h>
#include <WebKit/WebKit.h>
#include <iostream>

@interface UWMenuItem : NSMenuItem
@property(nonatomic, strong) NSString *key_;
@end
@implementation UWMenuItem
- (void)setKey:(NSString *)key {
  self.key_ = key;
}
@end

@interface MenuSelector : NSObject
@property UW::Config::Config config_;
@end
@implementation MenuSelector
- (void)selector_item:(id)sender {
  auto menuItem = ((UWMenuItem *)sender);
  auto js = [NSString
      stringWithFormat:@"SystemApi.eventBus.emit('menu::%@')", menuItem.key_];
  auto _nswindow = NSApp.mainWindow;
  auto _nswebview = NSApp.mainWindow.contentView;
  // js 通知到 webview 菜单点击事件
  [_nswebview evaluateJavaScript:js completionHandler:nil];
}
@end

namespace UW::Window {

void assemblyMenu(MenuSelector *menu_selector, NSMenu *nsmenu,
                  std::vector<Config::MenuItem> menu_list) {
  for (auto item : menu_list) {
    auto name = [NSString stringWithUTF8String:item.name_.c_str()];
    auto key = [NSString stringWithUTF8String:item.key_.c_str()];

    // 是否有子项
    if (item.children_.size() > 0) {
      // 预注册一个菜单项
      [nsmenu addItemWithTitle:name action:NULL keyEquivalent:@""];
      // 创建菜单项
      auto nsmenuItem = [[NSMenu alloc] initWithTitle:name];
      assemblyMenu(menu_selector, nsmenuItem, item.children_);
      // 装载菜单项
      [nsmenu setSubmenu:nsmenuItem forItem:[nsmenu itemWithTitle:name]];
    } else {
      // 创建菜单项
      auto nsmenuItem =
          [[UWMenuItem alloc] initWithTitle:name
                                     action:@selector(selector_item:)
                              keyEquivalent:@""];
      [nsmenuItem setTarget:menu_selector];
      [nsmenuItem setKey:key];
      [nsmenu addItem:nsmenuItem];
    }
  }
}

void Platform::initMenu() {
  @autoreleasepool {
    Config::Menu menuConfig = config_.menu_;
    auto navigation_bar = [[NSMenu alloc] init];
    auto menu_selector = [[MenuSelector alloc] init];
    assemblyMenu(menu_selector, navigation_bar, menuConfig.navigation_);

    [NSApp setMainMenu:navigation_bar];
  }
}
}