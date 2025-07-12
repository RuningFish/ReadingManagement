//
//  RMMTabBarViewController.m
//  ReadingManagement
//
//  Created by runingfish on 2025/7/12.
//

#import "RMMTabBarViewController.h"

@interface RMMTabBarViewController ()

@end

@implementation RMMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    if (@available(iOS 15.0, *)) {
        UITabBarAppearance *appearance = [UITabBarAppearance new];
        self.tabBar.scrollEdgeAppearance = appearance;
        self.tabBar.standardAppearance = appearance;
     }
}

@end
