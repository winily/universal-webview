#include "notification.hpp"

#import <AppKit/AppKit.h>
#import <CoreServices/CoreServices.h>
#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

@interface NotificationDelegate : NSObject <UNUserNotificationCenterDelegate>
@end

@implementation NotificationDelegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:
             (void (^)(UNNotificationPresentationOptions options))
                 completionHandler __IOS_AVAILABLE(10.0)__TVOS_AVAILABLE(10.0)
                     __WATCHOS_AVAILABLE(3.0) {
  NSLog(@"将提出通知");
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
    didReceiveNotificationResponse:(UNNotificationResponse *)response
             withCompletionHandler:(void (^)(void))completionHandler
    __IOS_AVAILABLE(10.0)__WATCHOS_AVAILABLE(3.0)__TVOS_PROHIBITED {
  NSLog(@"确实收到通知响应");
}

@end

namespace UW::SysApi::Notification {
void send() {
  //
  NSLog(@"发送一个通知====================================================");
  @try {
    NSLog(@"通知中心 %@", UNUserNotificationCenter.currentNotificationCenter);
  } @catch (NSException *e) {
    NSLog(@"通知发送错误 %@", e);
  }

  NSLog(@"发送一个通知====================================================");
  //--------注册通知
  UNUserNotificationCenter *center =
      [UNUserNotificationCenter currentNotificationCenter];
  NSLog(@"通知中心 %@", center);
  //--------获取权限（角标，通知，音效）
  [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge |
                                          UNAuthorizationOptionAlert |
                                          UNAuthorizationOptionSound
                        completionHandler:^(BOOL granted,
                                            NSError *_Nullable error) {
                          if (granted) {
                            NSLog(@"seccess");
                          }
                        }];
  //--------设置通知内容
  UNMutableNotificationContent *content = [UNMutableNotificationContent new];
  content.title = @"这是一个本地通知";
  content.subtitle = @"这是本地通知副标题";
  content.body = @"这是本地通知的正文内容";
  content.badge = @1;
  //    content.sound = [UNNotificationSound soundNamed:@""];
  //--------设置触发机制
  UNTimeIntervalNotificationTrigger *trigger =
      [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:60
                                                         repeats:YES];
  UNNotificationRequest *request =
      [UNNotificationRequest requestWithIdentifier:@"REQUEST"
                                           content:content
                                           trigger:trigger];
  //---------添加通知到通知中心
  [[UNUserNotificationCenter currentNotificationCenter]
      addNotificationRequest:request
       withCompletionHandler:^(NSError *_Nullable error) {
         NSLog(@"error : %@", error);
       }];
}

void alert() {
  NSLog(@"发送一个 Alert");

  // NSAlert *alert = [[NSAlert alloc] init];
  // alert.alertStyle = NSWarningAlertStyle;
  // [alert addButtonWithTitle:@"确定"];
  // [alert addButtonWithTitle:@"取消"];
  // alert.messageText = @"提示";
  // alert.informativeText = @"你输入的用户名或者密码不正确";

  // [alert beginSheetModalForWindow:[NSApplication sharedApplication].keyWindow
  //               completionHandler:^(NSModalResponse returnCode) {
  //                 //        NSLog(@"%d", returnCode);
  //                 if (returnCode == NSAlertFirstButtonReturn) {
  //                   NSLog(@"确定");
  //                 } else if (returnCode == NSAlertSecondButtonReturn) {
  //                   NSLog(@"取消");
  //                 } else {
  //                   NSLog(@"其他按钮");
  //                 }
  //               }];
}
}