#import "platform.hpp"
#include <AppKit/AppKit.h>
#include <Foundation/Foundation.h>
#include <WebKit/WebKit.h>
#include <iostream>

namespace UW::Window {
void Platform::initMenu() {
  // @autoreleasepool {
  Config::Menu menuConfig = config_.menu_;
  // auto mainMenu = [NSApp mainMenu];
  auto mainMenu = [[NSMenu alloc] init];

  int index = 2;
  // 初始化导航栏菜单
  // for (Config::MenuItem item : menuConfig.navigation_) {
  //   std::cout << "装载菜单：" << item.name_ << std::endl;
  //   auto nsmenuItem = [[NSMenuItem alloc]
  //       initWithTitle:[NSString stringWithUTF8String:item.name_.c_str()]
  //              action:nil
  //       keyEquivalent:[NSString stringWithUTF8String:item.key_.c_str()]];
  //   // [nsmenuItem setTitle:[NSString
  //   stringWithUTF8String:item.name_.c_str()]];

  //   auto subMenu = [[NSMenu alloc]
  //       initWithTitle:[NSString stringWithUTF8String:item.name_.c_str()]];
  //   for (Config::MenuItem subItem : item.children_) {
  //     [subMenu
  //         addItemWithTitle:[NSString
  //         stringWithUTF8String:subItem.name_.c_str()]
  //                   action:nil
  //            keyEquivalent:[NSString
  //                              stringWithUTF8String:subItem.key_.c_str()]];
  //   }
  //   [nsmenuItem setSubmenu:subMenu];

  //   // [nsmenuItem setEnabled:TRUE];
  //   // [nsmenuItem setHidden:FALSE];
  //   [mainMenu insertItem:nsmenuItem atIndex:index];
  //   index++;
  // }

  std::cout << "装载菜单：1" << std::endl;
  auto nsmenuItem = [[NSMenuItem alloc] initWithTitle:@"hahaha"
                                               action:nil
                                        keyEquivalent:@"A"];

  std::cout << "装载菜单：2" << std::endl;
  [nsmenuItem setTitle:@"hahah"];
  [mainMenu addItem:nsmenuItem];

  std::cout << "装载菜单：3 二级" << std::endl;
  auto subMenu = [[NSMenu alloc] initWithTitle:@"hahaha"];
  [subMenu addItemWithTitle:@"haha1" action:nil keyEquivalent:@"Aa"];
  [subMenu addItemWithTitle:@"haha2" action:nil keyEquivalent:@"Ab"];
  [subMenu addItemWithTitle:@"haha3" action:nil keyEquivalent:@"Ac"];

  NSLog(@"hahah menu %@ - %@", mainMenu, [mainMenu itemArray]);

  std::cout << "装载菜单：4" << std::endl;
  [NSApp setMainMenu:mainMenu];
}
}