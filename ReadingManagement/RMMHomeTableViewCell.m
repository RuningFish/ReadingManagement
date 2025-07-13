//
//  RMMHomeTableViewCell.m
//  ReadingManagement
//
//  Created by runingfish on 2025/7/13.
//

#import "RMMHomeTableViewCell.h"

@interface RMMHomeTableViewCell ()
@property (nonatomic, strong) UIImageView *rmm_home_list_imageView;
@property (nonatomic, strong) UILabel *rmm_home_list_nameLabel;
@property (nonatomic, strong) UILabel *rmm_home_list_authorLabel;
@property (nonatomic, strong) UILabel *rmm_home_list_pagesLabel;
@property (nonatomic, strong) UILabel *rmm_home_list_dateLabel;
@property (nonatomic, strong) UILabel *rmm_home_list_deleteLabel;
@property (nonatomic, assign) RMMHomeTableViewCellType rmm_cell_type;
@end

@implementation RMMHomeTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [self cellWithTableView:tableView type:RMMTableViewCellTypeHome];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView type:(RMMHomeTableViewCellType)type {
    NSString *identifier = [NSString stringWithFormat:@"RMMHomeTableViewCell- %ld",type];
    RMMHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[RMMHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier type:type];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.rmm_cell_type = type;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(RMMHomeTableViewCellType)type {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.backgroundColor = [UIColor clearColor];
        UIView *bottomView = [[UIView alloc] init];
        [self.contentView addSubview:bottomView];
        bottomView.backgroundColor = [UIColor clearColor];
        bottomView.layer.cornerRadius = 8;
        bottomView.layer.masksToBounds = YES;
        bottomView.layer.borderColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1].CGColor;
        bottomView.layer.borderWidth = 1;
        
        self.rmm_home_list_imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [bottomView addSubview:self.rmm_home_list_imageView];
        self.rmm_home_list_imageView.image = [UIImage imageNamed:@"book"];
        self.rmm_home_list_imageView.layer.cornerRadius = 5;
        self.rmm_home_list_imageView.layer.masksToBounds = YES;
        
        self.rmm_home_list_nameLabel = [[UILabel alloc] init];
        [bottomView addSubview:self.rmm_home_list_nameLabel];
        self.rmm_home_list_nameLabel.font = [UIFont systemFontOfSize:18];
        self.rmm_home_list_nameLabel.textColor = [UIColor blackColor];
        self.rmm_home_list_nameLabel.textAlignment = NSTextAlignmentLeft;
        
        self.rmm_home_list_authorLabel = [[UILabel alloc] init];
        [bottomView addSubview:self.rmm_home_list_authorLabel];
        self.rmm_home_list_authorLabel.font = [UIFont systemFontOfSize:15];
        self.rmm_home_list_authorLabel.textColor = [UIColor blackColor];
        self.rmm_home_list_authorLabel.textAlignment = NSTextAlignmentLeft;
        
        self.rmm_home_list_pagesLabel = [[UILabel alloc] init];
        [bottomView addSubview:self.rmm_home_list_pagesLabel];
        self.rmm_home_list_pagesLabel.font = [UIFont systemFontOfSize:15];
        self.rmm_home_list_pagesLabel.textColor = [UIColor blackColor];
        self.rmm_home_list_pagesLabel.textAlignment = NSTextAlignmentLeft;
        
        self.rmm_home_list_dateLabel = [[UILabel alloc] init];
        [bottomView addSubview:self.rmm_home_list_dateLabel];
        self.rmm_home_list_dateLabel.font = [UIFont systemFontOfSize:15];
        self.rmm_home_list_dateLabel.textColor = [UIColor blackColor];
        self.rmm_home_list_dateLabel.textAlignment = NSTextAlignmentLeft;
        
        self.rmm_home_list_deleteLabel = [[UILabel alloc] init];
        [bottomView addSubview:self.rmm_home_list_deleteLabel];
        self.rmm_home_list_deleteLabel.font = [UIFont systemFontOfSize:15];
        self.rmm_home_list_deleteLabel.textColor = [UIColor redColor];
        self.rmm_home_list_deleteLabel.textAlignment = NSTextAlignmentCenter;
        self.rmm_home_list_deleteLabel.text = @"删除";
        self.rmm_home_list_deleteLabel.hidden = type == RMMTableViewCellTypeHome ? YES : NO;
        
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.offset(10);
            make.right.offset(-10);
            make.bottom.offset(0);
        }];
         
        [self.rmm_home_list_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(20);
            make.left.offset(10);
            make.width.height.mas_equalTo(50);
        }];
        
        [self.rmm_home_list_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(10);
            make.left.equalTo(self.rmm_home_list_imageView.mas_right).offset(10);
            make.right.offset(-10);
            make.height.mas_equalTo(30);
        }];
        
        [self.rmm_home_list_deleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rmm_home_list_nameLabel.mas_bottom).offset(0);
            make.right.offset(-10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
        }];
        
        [self.rmm_home_list_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.rmm_home_list_nameLabel.mas_left).offset(0);
            make.top.equalTo(self.rmm_home_list_nameLabel.mas_bottom).offset(0);
            make.right.offset(type == RMMTableViewCellTypeHome ? -10 : -80);
            make.height.mas_equalTo(30);
        }];
        
        [self.rmm_home_list_pagesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.rmm_home_list_nameLabel.mas_left).offset(0);
            make.right.offset(-10);
            make.top.equalTo(self.rmm_home_list_authorLabel.mas_bottom).offset(0);
            make.height.mas_equalTo(self.rmm_home_list_authorLabel);
            if (type == RMMTableViewCellTypeManage) {
                make.bottom.offset(-10);
            }
        }];
        
        [self.rmm_home_list_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.rmm_home_list_nameLabel.mas_left).offset(0);
            make.right.offset(-10);
            make.top.equalTo(self.rmm_home_list_pagesLabel.mas_bottom).offset(0);
            make.height.mas_equalTo(self.rmm_home_list_authorLabel);
            if (type == RMMTableViewCellTypeHome) {
                make.bottom.offset(-10);
            }
        }];
    
    }
    
    return self;
}

- (void)setItem_dict:(NSDictionary *)item_dict {
    _item_dict = item_dict;
    
    self.rmm_home_list_nameLabel.text = [NSString stringWithFormat:@"书名:%@",item_dict[@"name"]];
    self.rmm_home_list_authorLabel.text = [NSString stringWithFormat:@"作者:%@",item_dict[@"author"]];
    self.rmm_home_list_pagesLabel.text = [NSString stringWithFormat:@"页数:%@",item_dict[@"page"]];
    self.rmm_home_list_dateLabel.text = [NSString stringWithFormat:@"时间:%@",item_dict[@"time"] ? : @""];
    
    self.rmm_home_list_dateLabel.hidden = self.rmm_cell_type == RMMTableViewCellTypeManage ? YES : NO;
}
@end
