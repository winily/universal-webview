#import "../config/config.hpp"
#import "mac/platform.hpp"

#import "app_controller.h"
#import "app_delegate.h"
#include "mac/message_handler.h"
#include "mac/scheme_handler.h"
#include <Foundation/Foundation.h>
#include <WebKit/WebKit.h>

@interface AppDelegate ()

@property(strong) IBOutlet NSWindow *window_;
@property(strong) IBOutlet WKWebView *webview_;
@property(strong) IBOutlet AppController *app_controller_;
@property UW::Config::Config config_;
@property(nonatomic) UW::Window::Platform *platform_;
@end

@implementation AppDelegate

- (void)setConfig:(UW::Config::Config &)config {
  self.config_ = config;
}

- (void)setPlatform:(UW::Window::Platform *)platform {
  self.platform_ = platform;
}

- (void)initWindow {
  NSLog(@"构建了窗口");
  @autoreleasepool {
    auto window_config = self.config_.window_;
    // Create the main window
    NSRect rc = NSMakeRect(window_config.x_, window_config.y_,
                           window_config.width_, window_config.height_);
    NSUInteger uiStyle = NSWindowStyleMaskTitled | NSWindowStyleMaskResizable |
                         NSWindowStyleMaskClosable |
                         NSWindowStyleMaskMiniaturizable;
    NSBackingStoreType backingStoreStyle = NSBackingStoreBuffered;
    self.window_ = [[NSWindow alloc] initWithContentRect:rc
                                               styleMask:uiStyle
                                                 backing:backingStoreStyle
                                                   defer:NO];
    auto title = [NSString stringWithUTF8String:window_config.title_.c_str()];
    [self.window_ setTitle:title];
    [self.window_ makeKeyAndOrderFront:self.window_];
    [self.window_ makeMainWindow];
    [self.window_ center];
    // 控制窗口样式
    if (!window_config.closable_) {
      [self.window_
          setStyleMask:[self.window_ styleMask] & ~NSWindowStyleMaskClosable];
    }
    if (!window_config.miniaturizable_) {
      [self.window_ setStyleMask:[self.window_ styleMask] &
                                 ~NSWindowStyleMaskMiniaturizable];
    }
    if (!window_config.resizable_) {
      [self.window_
          setStyleMask:[self.window_ styleMask] & ~NSWindowStyleMaskResizable];
    }
    if (!window_config.title_bar_) {
      [self.window_
          setStyleMask:[self.window_ styleMask] & ~NSWindowStyleMaskTitled];
    }
  }
}

- (void)initWebview {
  NSLog(@"构建了 Webview");
  @autoreleasepool {
    auto window_config = self.config_.window_;
    // NSRect screenSize = NSScreen.mainScreen.frame;
    NSRect targetRect =
        CGRectMake(0, 0, window_config.width_, window_config.height_);
    auto schemeHandler = [[SchemeHandler alloc] init];

    WKWebViewConfiguration *config = [WKWebViewConfiguration new];

    // 添加自定义类型请求拦截
    [config setURLSchemeHandler:schemeHandler forURLScheme:@"uwfile"];

    WKUserContentController *userContentController =
        [[WKUserContentController alloc] init];
    config.userContentController = userContentController;

    MessageHandler *controller = [[MessageHandler alloc] init];

    self.webview_ =
        [[WKWebView<NSWindowDelegate> alloc] initWithFrame:targetRect
                                             configuration:config];
    controller.platform_ = self.platform_;
    controller.nswebview_ = self.webview_;

    [controller initEvent];

    [self.webview_ setAutoresizesSubviews:YES];
    [self.webview_
        setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];

    if (self.config_.window_.develop_) {
      [self.webview_.configuration.preferences
          setValue:@YES
            forKey:@"developerExtrasEnabled"];
      [self.webview_.configuration.preferences
          setJavaScriptCanOpenWindowsAutomatically:YES];
    }
  }
}

- (void)loadRequest:(NSString *)url {
  NSURL *nurl = [NSURL URLWithString:url];
  NSString *scheme = nurl.scheme.lowercaseString;
  [self.webview_ loadRequest:[NSURLRequest requestWithURL:nurl]];
}

- (void)orderFrontStandardInfoPanel:(id)sender {
  NSLog(@"orderFrontStandardInfoPanel");
  // function details here
}

- (void)orderFrontStandardintoPanel:(id)sender {
  NSLog(@"orderFrontStandardInfoPanel");
  // function details here
}

// app 准备完成的时候被调用
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  NSLog(@"applicationDidFinishLaunching");

  // UW::Config::Menu menuConfig = self.config_.menu_;
  // // auto mainMenu = [NSApp mainMenu];
  // NSMenu *menu;
  // NSMenu *info;
  // NSMenu *into;

  // menu = [NSMenu new];
  // [menu addItemWithTitle:@"Info" action:NULL keyEquivalent:@""];
  // [menu addItemWithTitle:@"into" action:NULL keyEquivalent:@"h"];
  // [menu addItemWithTitle:@"Quit"
  //                 action:@selector(terminate:)
  //          keyEquivalent:@"q"];
  // [menu setAccessibilityEnabled:YES];

  // info = [NSMenu new];
  // [info addItemWithTitle:@"Info Panel..."
  //                 action:@selector(orderFrontStandardInfoPanel:)
  //          keyEquivalent:@""];
  // [info addItemWithTitle:@"Preferences" action:NULL keyEquivalent:@""];
  // [info addItemWithTitle:@"Help"
  //                 action:@selector(orderFrontHelpPanel:)
  //          keyEquivalent:@"?"];

  // [menu setSubmenu:info forItem:[menu itemWithTitle:@"Info"]];

  // into = [[NSMenu alloc] initWithTitle:@"into"];
  // [into addItemWithTitle:@"into Panel..."
  //                 action:@selector(orderFrontStandardintoPanel:)
  //          keyEquivalent:@""];
  // [into addItemWithTitle:@"Preferences" action:NULL keyEquivalent:@""];
  // [into addItemWithTitle:@"Help"
  //                 action:@selector(orderFrontHelpPanel:)
  //          keyEquivalent:@"?"];

  // [menu setSubmenu:into forItem:[menu itemWithTitle:@"into"]];

  // [NSApp setMainMenu:menu];

  [self initWindow];
  [self initWebview];

  self.window_.contentView = self.webview_;

  // 设置窗口激活类型，!!不设置 Dock 不显示磁贴
  [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
  [NSApp activateIgnoringOtherApps:YES];

  // 设置 icon
  auto icon_path =
      [NSString stringWithUTF8String:self.config_.icon_path_.c_str()];
  NSImage *image = [[NSImage alloc] initWithContentsOfFile:icon_path];
  NSApp.applicationIconImage = image;

  // Insert code here to initialize your application

  self.platform_->app_.bus.emit("applicationDidFinishLaunching",
                                UW::Bus::Message{});
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
  NSLog(@"applicationWillTerminate");
  // Insert code here to tear down your application
}

- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
  NSLog(@"applicationSupportsSecureRestorableState");
  return YES;
}

@end