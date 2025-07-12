//
//  AppDelegate.m
//  ReadingManagement
//
//  Created by runingfish on 2025/7/12.
//

#import "AppDelegate.h"
#import "RMMSlpashViewController.h"

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[RMMSlpashViewController new]];
    self.window.rootViewController = nav;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:KReadingBookTypeRecordPath]) {
        [NSKeyedArchiver archiveRootObject:@[@"文学", @"科幻", @"历史", @"心理学", @"自助", @"传记", @"技术", @"商业"] toFile:KReadingBookTypeRecordPath];
    }
    
    return YES;
}
@end
