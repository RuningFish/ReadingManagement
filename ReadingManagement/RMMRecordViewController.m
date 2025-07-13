//
//  RMMRecordViewController.m
//  ReadingManagement
//
//  Created by runingfish on 2025/7/12.
//

#import "RMMRecordViewController.h"
#import "RMMAddBookViewController.h"
#import "RMMHomeTableViewCell.h"
@interface RMMRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *rmm_manage_tableView;
@property (nonatomic, strong) NSMutableArray *rmm_manage_dataSource;
@end

@implementation RMMRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"书籍管理"];
    [self.view addSubview:self.rmm_manage_tableView];
    self.rmm_manage_tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    [self reloadDdata];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDdata) name:KReadingManagementRecordAddSuccessNotificationName object:nil];
}

- (void)reloadDdata {
    self.rmm_manage_dataSource = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:KReadingManagementRecordPath]];
    [self.rmm_manage_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rmm_manage_dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RMMHomeTableViewCell *cell = [RMMHomeTableViewCell cellWithTableView:tableView type:RMMTableViewCellTypeManage];
    if (indexPath.row < self.rmm_manage_dataSource.count) {
        NSDictionary *item_dict = self.rmm_manage_dataSource[indexPath.row];
        cell.item_dict = item_dict;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.rmm_manage_dataSource.count) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除书籍"
                                                                                 message:@"确定要删除书籍吗？"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSDictionary *dict = self.rmm_manage_dataSource[indexPath.row];
            [self.rmm_manage_dataSource removeObject:dict];
            [NSKeyedArchiver archiveRootObject:self.rmm_manage_dataSource toFile:KReadingManagementRecordPath];
            [[NSNotificationCenter defaultCenter] postNotificationName:KReadingManagementRecordAddSuccessNotificationName object:nil];
            [self reloadDdata];
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:sureAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *sectionFooterView = nil;
    if (section == 0 && self.rmm_manage_dataSource.count == 0) {
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
    return self.rmm_manage_dataSource.count == 0 ? 220.0f : 0.0f;
}

- (void)rmm_manage_nav_right_buttonClick:(UIButton *)button {
    RMMAddBookViewController *vc = [RMMAddBookViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Lazy
- (UITableView *)rmm_manage_tableView {
    if (!_rmm_manage_tableView) {
        _rmm_manage_tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _rmm_manage_tableView.delegate = self;
        _rmm_manage_tableView.dataSource = self;
        _rmm_manage_tableView.rowHeight = UITableViewAutomaticDimension;
        _rmm_manage_tableView.estimatedRowHeight = 144;
        _rmm_manage_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _rmm_manage_tableView;
}

@end

