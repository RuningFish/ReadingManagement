//
//  RMMHomeTableViewCell.h
//  ReadingManagement
//
//  Created by runingfish on 2025/7/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    RMMTableViewCellTypeHome = 0,
    RMMTableViewCellTypeManage = 1,
} RMMHomeTableViewCellType;

@interface RMMHomeTableViewCell : UITableViewCell
@property (nonatomic,strong) NSDictionary *item_dict;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (instancetype)cellWithTableView:(UITableView *)tableView type:(RMMHomeTableViewCellType)type;
@end

NS_ASSUME_NONNULL_END
