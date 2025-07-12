//
//  RMMFeedbackViewController.m
//  ReadingManagement
//
//  Created by runingfish on 2025/7/12.
//

#import "RMMFeedbackViewController.h"

@interface RMMFeedbackViewController ()

@end

@implementation RMMFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = MAIN_VIEW_COLOR;
    
    UILabel *rmm_feedback_title_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, self.view.frame.size.width-20, 40)];
    [self.view addSubview:rmm_feedback_title_label];
    rmm_feedback_title_label.text = @"请将您的意见或建议填入下方，以便我们改进";
    rmm_feedback_title_label.textColor = [UIColor blackColor];
    rmm_feedback_title_label.textAlignment = NSTextAlignmentLeft;
    rmm_feedback_title_label.font = [UIFont systemFontOfSize:16];
    
    UISegmentedControl *rmm_seg_control = [[UISegmentedControl alloc] initWithItems:@[@"建议", @"问题", @"表扬", @"其它",]];
    [self.view addSubview:rmm_seg_control];
    rmm_seg_control.frame = CGRectMake(20, 160, self.view.frame.size.width - 40, 40);
    rmm_seg_control.selectedSegmentIndex = 0;
    rmm_seg_control.selectedSegmentTintColor = [UIColor systemBlueColor];
    
    UITextView *rmm_feedback_textView = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(rmm_seg_control.frame) + 35, self.view.frame.size.width - 20, 133)];
    [self.view addSubview:rmm_feedback_textView];
    rmm_feedback_textView.layer.borderWidth = 1;
    rmm_feedback_textView.layer.borderColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1].CGColor;
    rmm_feedback_textView.layer.cornerRadius = 5;
    rmm_feedback_textView.layer.masksToBounds = YES;
    
    UIButton *rmm_feedback_confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:rmm_feedback_confirmButton];
    rmm_feedback_confirmButton.frame = CGRectMake(10, CGRectGetMaxY(rmm_feedback_textView.frame) + 33, [UIScreen mainScreen].bounds.size.width-20, 44);
    [rmm_feedback_confirmButton setTitle:@"提交" forState:UIControlStateNormal];
    [rmm_feedback_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rmm_feedback_confirmButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [rmm_feedback_confirmButton addTarget:self action:@selector(rmm_feedback_confirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    rmm_feedback_confirmButton.backgroundColor = [UIColor systemBlueColor];
    rmm_feedback_confirmButton.layer.cornerRadius = 10;
    rmm_feedback_confirmButton.layer.masksToBounds = YES;
}

- (void)rmm_feedback_confirmButtonClick:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
