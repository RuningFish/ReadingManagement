//
//  RMMAddBookViewController.m
//  ReadingManagement
//
//  Created by runingfish on 2025/7/12.
//

#import "RMMAddBookViewController.h"

#define KCellItemHeight 50

@interface RMMAddBookViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *rmm_addBook_mainTableview;
@property (nonatomic, strong) NSMutableArray *rmm_book_type_lists;
@property (nonatomic, strong) NSMutableArray *rmm_book_tag_lists;
@property (nonatomic, strong) NSMutableArray *rmm_info_item_textFields;
@property (nonatomic, copy) NSString *rmm_select_book_type;
@property (nonatomic, copy) NSString *rmm_select_book_tag;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@end

@implementation RMMAddBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle:@"添加新书"];
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    
    UIButton *rmm_add_book_nav_right_button = [UIButton buttonWithType:UIButtonTypeSystem];
    [rmm_add_book_nav_right_button setTitle:@"保存" forState:UIControlStateNormal];
    rmm_add_book_nav_right_button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [rmm_add_book_nav_right_button addTarget:self action:@selector(rmm_add_book_nav_right_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rmm_add_book_nav_right_button];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.rmm_addBook_mainTableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.rmm_addBook_mainTableview];
    self.rmm_addBook_mainTableview.backgroundColor = [UIColor systemCyanColor];
    self.rmm_addBook_mainTableview.rowHeight = KCellItemHeight;
    self.rmm_addBook_mainTableview.delegate = self;
    self.rmm_addBook_mainTableview.dataSource = self;
    self.rmm_addBook_mainTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rmm_book_type_lists = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:KReadingBookTypeRecordPath]];
    self.rmm_book_tag_lists = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:KReadingBookTagRecordPath]];
    self.rmm_select_book_type = @"";
    self.rmm_select_book_tag = @"";
    self.rmm_info_item_textFields = [NSMutableArray array];
    [self.rmm_addBook_mainTableview reloadData];
    
    [self.view addSubview:self.indicatorView];
    
    [self addTableViewHeaderView];

}

- (void)addTableViewHeaderView {
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 190)];
    self.rmm_addBook_mainTableview.tableHeaderView = tableHeaderView;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, tableHeaderView.frame.size.width - 20, 30)];
    [tableHeaderView addSubview:titleLabel];
    titleLabel.text = @"基本信息";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:15];
    
    NSArray *info_items = @[@"书名", @"作者", @"总页数",];
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame) + 10, tableHeaderView.frame.size.width - 20, tableHeaderView.frame.size.height - CGRectGetMaxY(titleLabel.frame) - 10)];
    [tableHeaderView addSubview:containerView];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.layer.cornerRadius = 10;
    containerView.layer.masksToBounds = YES;
    for (int i = 0; i < info_items.count; i ++) {
        UITextField *input_textField = [[UITextField alloc] initWithFrame:CGRectMake(0, i * 50, containerView.frame.size.width, 50)];
        [containerView addSubview:input_textField];
        input_textField.placeholder = info_items[i];
        input_textField.font = [UIFont systemFontOfSize:15];
        UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
        input_textField.leftView = leftview;
        input_textField.leftViewMode = UITextFieldViewModeAlways;
        
        UIView *bottom_line = [[UIView alloc] initWithFrame:CGRectMake(0, input_textField.frame.size.height - 0.2, containerView.frame.size.width, 0.2)];
        [input_textField addSubview:bottom_line];
        bottom_line.backgroundColor = [UIColor lightGrayColor];
        
        [self.rmm_info_item_textFields addObject:input_textField];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.rmm_book_type_lists.count;
    } else if (section == 1) {
        return self.rmm_book_tag_lists.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = [NSString stringWithFormat:@"RMMAddBookViewControllerCell-%ld", indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    NSInteger bg_view_tag = [self get_cell_bg_view_tagWithSection:indexPath.section];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor clearColor];
        
        UIView *bg_view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, KCellItemHeight)];
        [cell.contentView addSubview:bg_view];
        bg_view.backgroundColor = [UIColor whiteColor];
        bg_view.tag = bg_view_tag;
        
        UILabel *title_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, bg_view.frame.size.width - 20, bg_view.frame.size.height)];
        [bg_view addSubview:title_label];
        title_label.text = @"";
        title_label.textColor = [UIColor blackColor];
        title_label.textAlignment = NSTextAlignmentLeft;
        title_label.font = [UIFont systemFontOfSize:17];
        title_label.tag = 100010;
        
        UIView *bottom_line = [[UIView alloc] initWithFrame:CGRectMake(0, KCellItemHeight - 0.2, bg_view.frame.size.width, 0.2)];
        [bg_view addSubview:bottom_line];
        bottom_line.backgroundColor = [UIColor lightGrayColor];
        
    }
    
    UIView *bg_view = [cell viewWithTag:bg_view_tag];
    UILabel *title_label = [bg_view viewWithTag:100010];
    title_label.textColor = [UIColor blackColor];
    if (indexPath.section == 0) {
        if (indexPath.row < self.rmm_book_type_lists.count) {
            NSString *title = self.rmm_book_type_lists[indexPath.row];
            title_label.text = title;
            if ([title isEqualToString:self.rmm_select_book_type]) {
                title_label.textColor = [UIColor systemRedColor];
            }
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row < self.rmm_book_tag_lists.count) {
            NSString *title = self.rmm_book_tag_lists[indexPath.row];
            title_label.text = title;
            if ([title isEqualToString:self.rmm_select_book_tag]) {
                title_label.textColor = [UIColor systemRedColor];
            }
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self saveSelectBookStateWithTableView:tableView indexPath:indexPath bookList:self.rmm_book_type_lists];
    } else if (indexPath.section == 1) {
        [self saveSelectBookStateWithTableView:tableView indexPath:indexPath bookList:self.rmm_book_tag_lists];
    }
}

- (void)saveSelectBookStateWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath bookList:(NSMutableArray *)bookList {
    if (indexPath.row < bookList.count) {
        NSInteger bg_view_tag = [self get_cell_bg_view_tagWithSection:indexPath.section];
        NSArray *visibleCells = [tableView visibleCells];
        for (UITableViewCell *cell in visibleCells) {
            UIView *bg_view = [cell viewWithTag:bg_view_tag];
            UILabel *title_label = [bg_view viewWithTag:100010];
            title_label.textColor = [UIColor blackColor];
        }
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UIView *bg_view = [cell viewWithTag:bg_view_tag];
        UILabel *title_label = [bg_view viewWithTag:100010];
        title_label.textColor = [UIColor systemRedColor];
        if (indexPath.section == 0) {
            self.rmm_select_book_type = bookList[indexPath.row];
        } else if (indexPath.section == 1) {
            self.rmm_select_book_tag = bookList[indexPath.row];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width - 40, 50)];
    [sectionHeaderView addSubview:titleLabel];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:15];
    if (section == 0) {
        titleLabel.text = @"分类";
    } else if (section == 1) {
        titleLabel.text = @"标签";
    }
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    UIButton *section_add_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [sectionHeaderView addSubview:section_add_button];
    section_add_button.frame = CGRectMake(30, 10, [UIScreen mainScreen].bounds.size.width - 60, 40);
    [section_add_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    section_add_button.titleLabel.font = [UIFont systemFontOfSize:18];
    [section_add_button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    section_add_button.layer.cornerRadius = section_add_button.frame.size.height / 2;
    section_add_button.layer.masksToBounds = YES;
    section_add_button.backgroundColor = [UIColor whiteColor];
    section_add_button.tag = section;

    if (section == 0) {
        [section_add_button setTitle:@"+ 添加分类" forState:UIControlStateNormal];
    } else if (section == 1) {
        [section_add_button setTitle:@"+ 添加标签" forState:UIControlStateNormal];
    }
    
    [section_add_button addTarget:self action:@selector(section_footer_add_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 60;
}

- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
    NSArray *items = indexPath.section == 0 ? self.rmm_book_type_lists : self.rmm_book_tag_lists;
    CGFloat cornerRadius = 10;
    UIView *bgView = [cell viewWithTag:[self get_cell_bg_view_tagWithSection:indexPath.section]];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(0, 0)];;
    if (items.count > 1){
        if (indexPath.row == 0){
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        } else if (indexPath.row == items.count - 1){
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
    } else if (items.count == 1) {
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    }
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = bgView.bounds;
    shapeLayer.path = bezierPath.CGPath;
    bgView.layer.mask = shapeLayer;
    shapeLayer.strokeColor = [UIColor yellowColor].CGColor;
}

- (void)rmm_add_book_nav_right_buttonClick:(UIButton *)button {
    [self.view endEditing:YES];
    BOOL isAllInput = YES;
    for (UITextField *obj in self.rmm_info_item_textFields) {
        if (obj.text.length == 0) {
            isAllInput = NO;
            break;
        }
    }
    
    if (!isAllInput) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                                 message:@"请输入基本信息"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:sureAction];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    NSString *filePath = KReadingManagementRecordPath;
    NSMutableArray *rmm_record_arrays = [NSMutableArray array];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        rmm_record_arrays = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *now = [NSDate date];
    NSString *dateString = [formatter stringFromDate:now];
    
    NSDictionary *item_dict = @{
        @"name":[self.rmm_info_item_textFields[0] text] ? : @"",
        @"author":[self.rmm_info_item_textFields[1] text] ? : @"",
        @"page":[self.rmm_info_item_textFields[2] text] ? : @"",
        @"type":self.rmm_select_book_type ? : @"",
        @"tag":self.rmm_select_book_tag ? : @"",
        @"time":dateString ? : @""
    };
    
    [rmm_record_arrays addObject:item_dict];
    [NSKeyedArchiver archiveRootObject:rmm_record_arrays toFile:filePath];
    [NSKeyedArchiver archiveRootObject:self.rmm_book_type_lists toFile:KReadingBookTypeRecordPath];
    [NSKeyedArchiver archiveRootObject:self.rmm_book_tag_lists toFile:KReadingBookTagRecordPath];
    [[NSNotificationCenter defaultCenter] postNotificationName:KReadingManagementRecordAddSuccessNotificationName object:nil];
    
    [self.indicatorView startAnimating];
    dispatch_time_t timer = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    dispatch_after(timer, dispatch_get_main_queue(), ^{
        [self.indicatorView stopAnimating];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"添加成功"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [alertController addAction:sureAction];
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

- (void)section_footer_add_buttonClick:(UIButton *)button {

    NSString *name = [button.currentTitle stringByReplacingOccurrencesOfString:@"+ 添加" withString:@""];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@名称", name]
                                                                             message:@""
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = [NSString stringWithFormat:@"请输入%@名称", name];
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *text_field = alertController.textFields[0];
        if (text_field.text.length > 0) {
            if (button.tag == 0) {
                if (![self.rmm_book_type_lists containsObject:text_field.text]) {
                    [self.rmm_book_type_lists addObject:text_field.text];
                }
            } else if (button.tag == 1) {
                if (![self.rmm_book_tag_lists containsObject:text_field.text]) {
                    [self.rmm_book_tag_lists addObject:text_field.text];
                }
            }
            [self.rmm_addBook_mainTableview reloadData];
        }
    }];
    
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (NSInteger)get_cell_bg_view_tagWithSection:(NSInteger)section {
    return 100 * (section + 1);
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _indicatorView.color = [UIColor lightGrayColor];
        _indicatorView.frame = self.view.bounds;
    }
    return _indicatorView;
}

@end
