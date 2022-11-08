// #pragma once

#import <Cocoa/Cocoa.h>

#import "../config/config.hpp"
#import "mac/platform.hpp"

@interface AppDelegate : NSObject <NSApplicationDelegate>
- (void)setConfig:(UW::Config::Config &)config;

- (void)setPlatform:(UW::Window::Platform *)platform;

- (void)loadRequest:(NSString *)url;
@end