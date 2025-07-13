//
//  RMMSelectRootViewController.m
//  ReadingManagement
//
//  Created by runingfish on 2025/7/12.
//

#import "RMMSelectRootViewController.h"
#import "RMMHomeViewController.h"
#import "RMMRecordViewController.h"
#import "RMMSettingViewController.h"
#import "RMMTabBarViewController.h"
@implementation RMMSelectRootViewController
+ (void)rmm_selectRootViewController {
    RMMTabBarViewController *tabVC = [RMMTabBarViewController new];
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    RMMHomeViewController *vc_1 = [RMMHomeViewController new];
    vc_1.title = @"首页";
    UINavigationController *nav_1 = [[UINavigationController alloc] initWithRootViewController:vc_1];
    
    RMMRecordViewController *vc_2 = [RMMRecordViewController new];
    vc_2.title = @"管理";
    UINavigationController *nav_2 = [[UINavigationController alloc] initWithRootViewController:vc_2];
    
    RMMSettingViewController *vc_3 = [RMMSettingViewController new];
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
