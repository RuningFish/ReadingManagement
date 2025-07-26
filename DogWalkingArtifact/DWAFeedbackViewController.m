//
//  DWAFeedbackViewController.m
//  DogWalkingArtifact
//
//  Created by runingfish on 2025/7/26.
//

#import "DWAFeedbackViewController.h"

@implementation DWAFeedbackViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    
    UILabel *dwa_feedback_title_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, [UIScreen mainScreen].bounds.size.width - 20, 30)];
    [self.view addSubview:dwa_feedback_title_label];
    dwa_feedback_title_label.text = @"请输入你所遇到的问题";
    dwa_feedback_title_label.textColor = [UIColor blackColor];
    dwa_feedback_title_label.textAlignment = NSTextAlignmentLeft;
    dwa_feedback_title_label.font = [UIFont systemFontOfSize:16];
    
    UITextView *dwa_feedback_textView = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(dwa_feedback_title_label.frame) + 25, self.view.frame.size.width - 20, 158)];
    [self.view addSubview:dwa_feedback_textView];
    dwa_feedback_textView.layer.borderWidth = 1;
    dwa_feedback_textView.layer.borderColor = [UIColor whiteColor].CGColor;
    dwa_feedback_textView.layer.cornerRadius = 5;
    dwa_feedback_textView.layer.masksToBounds = YES;
    
    UIButton *dwa_feedback_confirm_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:dwa_feedback_confirm_button];
    dwa_feedback_confirm_button.frame = CGRectMake(10, CGRectGetMaxY(dwa_feedback_textView.frame) + 25, [UIScreen mainScreen].bounds.size.width - 20, 44);
    [dwa_feedback_confirm_button setTitle:@"提交" forState:UIControlStateNormal];
    [dwa_feedback_confirm_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dwa_feedback_confirm_button.titleLabel.font = [UIFont systemFontOfSize:20];
    [dwa_feedback_confirm_button addTarget:self action:@selector(dwa_feedback_confirm_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    dwa_feedback_confirm_button.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
    dwa_feedback_confirm_button.layer.cornerRadius = 10;
    dwa_feedback_confirm_button.layer.masksToBounds = YES;
}

- (void)dwa_feedback_confirm_buttonClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
