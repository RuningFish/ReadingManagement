//
//  RMMBookDetailViewController.h
//  ReadingManagement
//
//  Created by runingfish on 2025/7/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RMMBookDetailViewController : UIViewController
@property (nonatomic, strong) NSDictionary *item_book_dict;
@property (nonatomic, assign) NSInteger item_book_index;
@end

NS_ASSUME_NONNULL_END
