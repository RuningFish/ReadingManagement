//
//  RMMHomeViewController.m
//  ReadingManagement
//
//  Created by runingfish on 2025/7/12.
//

#import "RMMHomeViewController.h"
#import "RMMAddBookViewController.h"
@interface RMMHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *rmm_home_tableView;
@property (nonatomic, strong) NSArray *rmm_home_dataSource;
@end

@implementation RMMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"读书管理"];
    [self.view addSubview:self.rmm_home_tableView];
    self.rmm_home_tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    self.rmm_home_dataSource = @[@"清除缓存",@"版本更新",@"意见反馈"];
    
    UIButton *rmm_home_nav_right_button = [UIButton buttonWithType:UIButtonTypeSystem];
    [rmm_home_nav_right_button setTitle:@"+" forState:UIControlStateNormal];
    rmm_home_nav_right_button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [rmm_home_nav_right_button setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    [rmm_home_nav_right_button addTarget:self action:@selector(rmm_home_nav_right_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rmm_home_nav_right_button];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rmm_home_dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[NSString stringWithFormat:@"COPSettingViewController-%ld",indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row < self.rmm_home_dataSource.count) {
        NSString *title = self.rmm_home_dataSource[indexPath.row];
        cell.textLabel.text = title;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {

    }
}

- (void)rmm_home_nav_right_buttonClick:(UIButton *)button {
    RMMAddBookViewController *vc = [RMMAddBookViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Lazy
- (UITableView *)rmm_home_tableView {
    if (!_rmm_home_tableView) {
        _rmm_home_tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _rmm_home_tableView.delegate = self;
        _rmm_home_tableView.dataSource = self;
        _rmm_home_tableView.rowHeight = 44;
        _rmm_home_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _rmm_home_tableView;
}

@end
