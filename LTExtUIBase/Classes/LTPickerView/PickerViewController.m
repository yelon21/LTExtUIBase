//
//  PickerViewController.m
//  YJNew
//
//  Created by yelon on 16/3/3.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>{

    UIPickerView *dataPickerView;
    NSInteger selectedRow;
}

@end

@implementation PickerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIButton *btn_left = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    btn_left.backgroundColor = [UIColor clearColor];
    btn_left.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btn_left setTitle:@"关闭" forState:UIControlStateNormal];

    [btn_left setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
    
    [btn_right setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_right setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn_right addTarget:self
                 action:@selector(rightAction)
       forControlEvents:UIControlEventTouchUpInside];
    [btn_right sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn_right];
    
    UIView *superView = self.view;
    
    dataPickerView = [UIPickerView new];
    dataPickerView.backgroundColor = [UIColor whiteColor];
    dataPickerView.delegate     = self;
    dataPickerView.dataSource   = self;
    dataPickerView.showsSelectionIndicator = YES;
    dataPickerView.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addSubview:dataPickerView];
    [dataPickerView reloadAllComponents];
    
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:dataPickerView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:dataPickerView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:dataPickerView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:dataPickerView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
}

- (void)leftAction{

    if ([self.delegate respondsToSelector:@selector(pickerViewControllerDidSelectIndex:)]) {
        
        [self.delegate pickerViewControllerDidSelectIndex:-1];
    }
}
- (void)rightAction{
    
    if ([self.delegate respondsToSelector:@selector(pickerViewControllerDidSelectIndex:)]) {
        
        [self.delegate pickerViewControllerDidSelectIndex:selectedRow];
    }
}

#pragma mark ================================
#pragma mark pickerViewDelegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSUInteger count = 0;
    
    if ([self.delegate respondsToSelector:@selector(pickerViewControllerNumberOfItems)]) {
        
        count = [self.delegate pickerViewControllerNumberOfItems];
    }
    return count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *title = @"";
    
    if ([self.delegate respondsToSelector:@selector(pickerViewControllerTitleForRowAtIndex:)]) {
        
        title = [self.delegate pickerViewControllerTitleForRowAtIndex:row];
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    selectedRow = row;
    if ([self.delegate respondsToSelector:@selector(pickerViewControllerDidChangeToIndex:)]) {
        
        [self.delegate pickerViewControllerDidChangeToIndex:row];
    }
}

@end
