//
//  DatePickerViewController.m
//  LTExtUIBase
//
//  Created by yelon on 2018/1/31.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@property(nonatomic,strong,readonly) UIDatePicker *picker;
@end

@implementation DatePickerViewController
@synthesize picker = _picker;


-(UIDatePicker *)picker{
    
    if (!_picker){
        _picker = [[UIDatePicker alloc]init];
        _picker.backgroundColor = [UIColor whiteColor];
    }
    return _picker;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIColor *tintColor = self.navigationController.navigationBar.tintColor;
    
    if (!tintColor) {
        
        tintColor = [UIColor whiteColor];
    }
    UIButton *btn_left = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    btn_left.backgroundColor = [UIColor clearColor];
    btn_left.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btn_left setTitle:@"关闭" forState:UIControlStateNormal];
    
    [btn_left setTitleColor:tintColor forState:UIControlStateNormal];
    [btn_left setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn_left addTarget:self
                 action:@selector(leftAction)
       forControlEvents:UIControlEventTouchUpInside];
    [btn_left sizeToFit];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn_left];
    
    UIButton *btn_right = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    btn_right.backgroundColor = [UIColor clearColor];
    btn_right.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btn_right setTitle:@"确定" forState:UIControlStateNormal];
    
    [btn_right setTitleColor:tintColor forState:UIControlStateNormal];
    [btn_right setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn_right addTarget:self
                  action:@selector(rightAction)
        forControlEvents:UIControlEventTouchUpInside];
    [btn_right sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn_right];
    
    if ([self.delegate respondsToSelector:@selector(datePickerViewControllerNavigationTitle)]) {
        
        self.navigationItem.title = [self.delegate datePickerViewControllerNavigationTitle];
    }
    
    if ([self.delegate respondsToSelector:@selector(datePickerView:)]) {
        
        [self.delegate datePickerView:self.picker];
    }
    
    UIView *superView = self.view;
    
    self.picker.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addSubview:self.picker];
    
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.picker
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.picker
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.picker
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.picker
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
}

- (void)leftAction{
    
    if ([self.delegate respondsToSelector:@selector(datePickerViewControllerDidCancel)]) {
        
        [self.delegate datePickerViewControllerDidCancel];
    }
}
- (void)rightAction{
    
    if ([self.delegate respondsToSelector:@selector(datePickerViewControllerDidSelectDate:)]) {
        
        [self.delegate datePickerViewControllerDidSelectDate:self.picker.date];
    }
}

@end
