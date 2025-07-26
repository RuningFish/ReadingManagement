//
//  DWASelectRootViewController.m
//  DogWalkingArtifact
//
//  Created by runingfish on 2025/7/26.
//

#import "DWASelectRootViewController.h"
#import "DWATabbarViewController.h"
#import "DWADogViewController.h"
#import "DWACatViewController.h"
#import "DWASettingViewController.h"
@implementation DWASelectRootViewController
+ (void)dwa_selectRootViewController {
    DWATabbarViewController *tabVC = [DWATabbarViewController new];
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    DWADogViewController *vc_1 = [DWADogViewController new];
    vc_1.title = @"遛狗";
    UINavigationController *nav_1 = [[UINavigationController alloc] initWithRootViewController:vc_1];
    
    DWACatViewController *vc_2 = [DWACatViewController new];
    vc_2.title = @"遛猫";
    UINavigationController *nav_2 = [[UINavigationController alloc] initWithRootViewController:vc_2];
    
    DWASettingViewController *vc_3 = [DWASettingViewController new];
    vc_3.title = @"设置";
    UINavigationController *nav_3 = [[UINavigationController alloc] initWithRootViewController:vc_3];
    
    [viewControllers addObject:nav_1];
    [viewControllers addObject:nav_2];
    [viewControllers addObject:nav_3];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    tabVC.viewControllers = viewControllers;
    keyWindow.rootViewController = tabVC;
}
@end
