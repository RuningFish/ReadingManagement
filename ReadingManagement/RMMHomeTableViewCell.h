//
//  RMMHomeTableViewCell.h
//  ReadingManagement
//
//  Created by runingfish on 2025/7/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RMMHomeTableViewCell : UITableViewCell
@property (nonatomic,strong) NSDictionary *item_dict;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
