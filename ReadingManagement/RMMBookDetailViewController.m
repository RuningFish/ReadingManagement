//
//  RMMBookDetailViewController.m
//  ReadingManagement
//
//  Created by runingfish on 2025/7/13.
//

#import "RMMBookDetailViewController.h"

@interface RMMBookDetailViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITableView *rmm_book_detail_mainTableview;
@property (nonatomic, strong) NSMutableArray *rmm_book_type_lists;
@property (nonatomic, strong) NSMutableArray *rmm_book_tag_lists;
@property (nonatomic, strong) NSMutableArray *rmm_info_item_textFields;
@property (nonatomic, copy) NSString *rmm_select_book_type;
@property (nonatomic, copy) NSString *rmm_select_book_tag;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@end

@implementation RMMBookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"书籍详情"];
    
    UIButton *rmm_book_detail_nav_right_button = [UIButton buttonWithType:UIButtonTypeSystem];
    [rmm_book_detail_nav_right_button setTitle:@"保存" forState:UIControlStateNormal];
    rmm_book_detail_nav_right_button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [rmm_book_detail_nav_right_button addTarget:self action:@selector(rmm_book_detail_nav_right_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rmm_book_detail_nav_right_button];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.rmm_book_detail_mainTableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.rmm_book_detail_mainTableview];
    self.rmm_book_detail_mainTableview.backgroundColor = [UIColor systemCyanColor];
    self.rmm_book_detail_mainTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rmm_book_type_lists = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:KReadingBookTypeRecordPath]];
    self.rmm_book_tag_lists = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:KReadingBookTagRecordPath]];
    self.rmm_select_book_type = @"";
    self.rmm_select_book_tag = @"";
    self.rmm_info_item_textFields = [NSMutableArray array];
    [self.rmm_book_detail_mainTableview reloadData];
    
    [self.view addSubview:self.indicatorView];
    
    [self addTableViewHeaderView];

}

- (void)addTableViewHeaderView {
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400)];
    NSArray *info_items = @[
        @{
            @"title":@"基本信息",
            @"type":@"1",// 1.单行输入框， 2.多行输入框
            @"items":@[
                @{
                    @"title":@"书名",
                    @"value":self.item_book_dict[@"name"] ? : @"",
                    @"index":@"0",
                },
                @{
                    @"title":@"作者",
                    @"value":self.item_book_dict[@"author"] ? : @"",
                    @"index":@"1",
                },
                @{
                    @"title":@"总页数",
                    @"value":self.item_book_dict[@"page"] ? : @"",
                    @"index":@"2",
                },
            ]
        },
        @{
            @"title":@"分类",
            @"type":@"1",
            @"items":@[
                @{
                    @"title":@"",
                    @"value":self.item_book_dict[@"type"] ? : @"",
                    @"type":@"seleect-add",
                    @"index":@"3",
                },
            ]
        },
        @{
            @"title":@"标签",
            @"type":@"1",
            @"items":@[
                @{
                    @"title":@"",
                    @"value":self.item_book_dict[@"tag"] ? : @"",
                    @"type":@"seleect-add",
                    @"index":@"4",
                },
            ]
        },
        @{
            @"title":@"笔记",
            @"type":@"2",
            @"items":@[
                @{
                    @"title":self.item_book_dict[@"note"] ? : @"",
                    @"index":@"5",
                },
            ]
        },
    ];
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, tableHeaderView.frame.size.width - 20, tableHeaderView.frame.size.height - 10)];
    [tableHeaderView addSubview:containerView];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.layer.cornerRadius = 10;
    containerView.layer.masksToBounds = YES;
    
    CGFloat start_y = 10;
    for (int i = 0; i < info_items.count; i ++) {
        NSDictionary *item = info_items[i];
        UILabel *title_label = [[UILabel alloc] initWithFrame:CGRectMake(10, start_y, containerView.frame.size.width - 20, 40)];
        [containerView addSubview:title_label];
        title_label.text = item[@"title"];
        title_label.textColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];;
        title_label.textAlignment = NSTextAlignmentLeft;
        title_label.font = [UIFont boldSystemFontOfSize:17];
        
        NSString *type = item[@"type"];
        NSArray *items = item[@"items"];
        for (int j = 0; j < items.count; j ++) {
            NSDictionary *item_value = items[j];
            if ([type isEqualToString:@"1"]) {
                UITextField *input_textField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(title_label.frame) + j * 50, containerView.frame.size.width - 20, 40)];
                [containerView addSubview:input_textField];
                input_textField.placeholder = item_value[@"title"];
                input_textField.text = item_value[@"value"];
                input_textField.font = [UIFont systemFontOfSize:15];
                UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
                input_textField.leftView = leftview;
                input_textField.leftViewMode = UITextFieldViewModeAlways;
                input_textField.tag = [item_value[@"index"] integerValue];
                input_textField.delegate = self;
                input_textField.layer.cornerRadius = 5;
                input_textField.layer.masksToBounds = YES;
                input_textField.layer.borderColor = [UIColor systemGreenColor].CGColor;
                input_textField.layer.borderWidth = 1;
                
                NSString *type = item_value[@"type"];
                if (type.length > 0 && [type isEqualToString:@"seleect-add"]) {
                    UIButton *item_value_add_button = [UIButton buttonWithType:UIButtonTypeContactAdd];
                    item_value_add_button.tag = [item_value[@"index"] integerValue];
                    [item_value_add_button addTarget:self action:@selector(item_value_add_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                    UIView *righttview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
                    item_value_add_button.frame = righttview.bounds;
                    [righttview addSubview:item_value_add_button];
                    input_textField.rightView = righttview;
                    input_textField.rightViewMode = UITextFieldViewModeAlways;
                }
            
                start_y = CGRectGetMaxY(input_textField.frame) + 10;
                [self.rmm_info_item_textFields addObject:input_textField];
            } else if ([type isEqualToString:@"2"]) {
                UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(title_label.frame) + 10, containerView.frame.size.width - 20, 140)];
                [containerView addSubview:textView];
                textView.layer.borderWidth = 1;
                textView.layer.borderColor = [UIColor systemGreenColor].CGColor;
                textView.layer.cornerRadius = 5;
                textView.layer.masksToBounds = YES;
                textView.text = self.item_book_dict[@"note"] ? : @"";
                textView.tag = [item_value[@"index"] integerValue];
                
                start_y = CGRectGetMaxY(textView.frame) + 10;
                [self.rmm_info_item_textFields addObject:textView];
            }
        }

    }
    
    containerView.frame = CGRectMake(containerView.frame.origin.x, containerView.frame.origin.y, containerView.frame.size.width, start_y);
    tableHeaderView.frame = CGRectMake(tableHeaderView.frame.origin.x, tableHeaderView.frame.origin.y, tableHeaderView.frame.size.width, start_y + 30);
    self.rmm_book_detail_mainTableview.tableHeaderView = tableHeaderView;
}

- (void)rmm_book_detail_nav_right_buttonClick:(UIButton *)button {
    [self.view endEditing:YES];
    BOOL isAllInput = YES;
    for (UITextField *obj in self.rmm_info_item_textFields) {
        if (obj.text.length == 0 && obj.tag < 3) {
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
        @"name": [self.rmm_info_item_textFields[0] text] ? : @"",
        @"author": [self.rmm_info_item_textFields[1] text] ? : @"",
        @"page": [self.rmm_info_item_textFields[2] text] ? : @"",
        @"type": [self.rmm_info_item_textFields[3] text] ? : @"",
        @"tag": [self.rmm_info_item_textFields[4] text] ? : @"",
        @"note": [self.rmm_info_item_textFields[5] text] ? : @"",
        @"time": self.item_book_dict[@"time"] ? : @"",
    };
    
    [rmm_record_arrays replaceObjectAtIndex:self.item_book_index withObject:item_dict];
    [NSKeyedArchiver archiveRootObject:rmm_record_arrays toFile:filePath];
    [[NSNotificationCenter defaultCenter] postNotificationName:KReadingManagementRecordAddSuccessNotificationName object:nil];
    
    [self.indicatorView startAnimating];
    dispatch_time_t timer = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    dispatch_after(timer, dispatch_get_main_queue(), ^{
        [self.indicatorView stopAnimating];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存成功"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [alertController addAction:sureAction];
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

- (void)item_value_add_buttonClick:(UIButton *)button {

    NSString *name = button.tag == 3 ? @"分类" : (button.tag == 4 ? @"标签" : @"");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@名称", name]
                                                                             message:@""
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = [NSString stringWithFormat:@"请输入%@名称", name];
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *text_field = alertController.textFields[0];
        if (text_field.text.length > 0) {
            if (button.tag == 3) {
                if (![self.rmm_book_type_lists containsObject:text_field.text]) {
                    [self.rmm_book_type_lists addObject:text_field.text];
                    [NSKeyedArchiver archiveRootObject:self.rmm_book_type_lists toFile:KReadingBookTypeRecordPath];
                }
            } else if (button.tag == 4) {
                if (![self.rmm_book_tag_lists containsObject:text_field.text]) {
                    [self.rmm_book_tag_lists addObject:text_field.text];
                    [NSKeyedArchiver archiveRootObject:self.rmm_book_tag_lists toFile:KReadingBookTagRecordPath];
                }
            }
        }
    }];
    
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag == 3 || textField.tag == 4) {
        [self selectTypeAndTagWithTextField:textField];
        return NO;
    }
    return YES;
}

- (void)selectTypeAndTagWithTextField:(UITextField *)textField {
    NSMutableArray *dataSourceArr = nil;
    if (textField.tag == 3) {
        dataSourceArr = self.rmm_book_type_lists;
    } else if (textField.tag == 4) {
        dataSourceArr = self.rmm_book_tag_lists;
    }
    
    if (dataSourceArr.count == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                                 message:@"暂无标签"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确定");
        }];
        [alertController addAction:sureAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        BRTextPickerView *pickView = [[BRTextPickerView alloc] initWithPickerMode:BRTextPickerComponentSingle];
        pickView.dataSourceArr = dataSourceArr;
        [pickView show];
        pickView.singleResultBlock = ^(BRTextModel * _Nullable model, NSInteger index) {
            textField.text = model.text;
        };
    }
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
