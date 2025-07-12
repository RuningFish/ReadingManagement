//
//  RMMSettingViewController.m
//  ReadingManagement
//
//  Created by runingfish on 2025/7/12.
//

#import "RMMSettingViewController.h"
#import "RMMFeedbackViewController.h"
@interface RMMSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *rmm_setting_tableView;
@property (nonatomic, strong) NSArray *rmm_setting_dataSource;
@end

@implementation RMMSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.rmm_setting_tableView];
    self.rmm_setting_tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    self.rmm_setting_dataSource = @[@"清除缓存",@"版本更新",@"意见反馈"];
    
    NSLog(@"RMMSettingViewController --- log");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rmm_setting_dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[NSString stringWithFormat:@"RMMSettingViewController-%ld",indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row < self.rmm_setting_dataSource.count) {
        NSString *title = self.rmm_setting_dataSource[indexPath.row];
        cell.textLabel.text = title;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清理成功"
                                                                                 message:@""
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:sureAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if (indexPath.row == 1){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"当前已是最新版本"
                                                                                 message:@""
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:sureAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if (indexPath.row == 2){
        RMMFeedbackViewController *vc = [RMMFeedbackViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        vc.view.backgroundColor = MAIN_VIEW_COLOR;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - Lazy
- (UITableView *)rmm_setting_tableView{
    if (!_rmm_setting_tableView) {
        _rmm_setting_tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _rmm_setting_tableView.delegate = self;
        _rmm_setting_tableView.dataSource = self;
        _rmm_setting_tableView.rowHeight = 44;
        _rmm_setting_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _rmm_setting_tableView;
}

@end
