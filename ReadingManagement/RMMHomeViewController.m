//
//  RMMHomeViewController.m
//  ReadingManagement
//
//  Created by runingfish on 2025/7/12.
//

#import "RMMHomeViewController.h"
#import "RMMAddBookViewController.h"
#import "RMMHomeTableViewCell.h"
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
    
    UIButton *rmm_home_nav_right_button = [UIButton buttonWithType:UIButtonTypeSystem];
    [rmm_home_nav_right_button setTitle:@"+" forState:UIControlStateNormal];
    rmm_home_nav_right_button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [rmm_home_nav_right_button setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    [rmm_home_nav_right_button addTarget:self action:@selector(rmm_home_nav_right_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rmm_home_nav_right_button];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDdata) name:KReadingManagementRecordAddSuccessNotificationName object:nil];
}

- (void)reloadDdata {
    [self.rmm_home_tableView reloadData];
}

- (NSArray *)rmm_home_dataSource {
    return [NSArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:KReadingManagementRecordPath]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rmm_home_dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RMMHomeTableViewCell *cell = [RMMHomeTableViewCell cellWithTableView:tableView];
    if (indexPath.row < self.rmm_home_dataSource.count) {
        NSDictionary *item_dict = self.rmm_home_dataSource[indexPath.row];
        cell.item_dict = item_dict;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {

    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width - 40, 30)];
    [sectionHeaderView addSubview:titleLabel];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = @"我的书籍";
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *sectionFooterView = nil;
    if (section == 0 && self.rmm_home_dataSource.count == 0) {
        sectionFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 220)];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,0, [UIScreen mainScreen].bounds.size.width - 40, sectionFooterView.frame.size.height)];
        [sectionFooterView addSubview:titleLabel];
        titleLabel.text = @"还没有书籍哦，赶快去添加吧～";
        titleLabel.textColor = [UIColor systemRedColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return sectionFooterView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.rmm_home_dataSource.count == 0 ? 220.0f : 0.0f;
}

- (void)rmm_home_nav_right_buttonClick:(UIButton *)button {
    RMMAddBookViewController *vc = [RMMAddBookViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Lazy
- (UITableView *)rmm_home_tableView {
    if (!_rmm_home_tableView) {
        _rmm_home_tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _rmm_home_tableView.delegate = self;
        _rmm_home_tableView.dataSource = self;
        _rmm_home_tableView.rowHeight = UITableViewAutomaticDimension;
        _rmm_home_tableView.estimatedRowHeight = 144;
        _rmm_home_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _rmm_home_tableView;
}

@end
