//
//  DWATabbarViewController.m
//  DogWalkingArtifact
//
//  Created by runingfish on 2025/7/26.
//

#import "DWATabbarViewController.h"

@implementation DWATabbarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 15.0, *)) {
        UITabBarAppearance *appearance = [UITabBarAppearance new];
        self.tabBar.scrollEdgeAppearance = appearance;
        self.tabBar.standardAppearance = appearance;
     }
}

@end
