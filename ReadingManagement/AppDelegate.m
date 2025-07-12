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
    return YES;
}
@end
