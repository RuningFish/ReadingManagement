//
//  DogAppDelegate.m
//  DogWalkingArtifact
//
//  Created by runingfish on 2025/7/26.
//

#import "DogAppDelegate.h"
#import "DWASlaspViewController.h"
@implementation DogAppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[DWASlaspViewController new]];
    self.window.rootViewController = nav;
    
    return YES;
}
@end
