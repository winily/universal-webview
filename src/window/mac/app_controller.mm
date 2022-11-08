#import "app_controller.h"

@interface AppController ()

@end

@implementation AppController
- (void)loadView {
  NSRect frame = [[[NSApplication sharedApplication] mainWindow] frame];
  self.view = [[NSView alloc] initWithFrame:frame];
}
- (void)viewDidLoad {
  [super viewDidLoad];
  // Do view setup here.
  // do like ios
  NSButton *button =
      [[NSButton alloc] initWithFrame:NSMakeRect(0, 0, 100, 100)];
  [button setTitle:@"button"];
  [self.view addSubview:button];
}

@end
