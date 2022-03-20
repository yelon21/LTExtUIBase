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
}

@end

@implementation PickerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor secondarySystemGroupedBackgroundColor];
        
        UINavigationBarAppearance * appearance = [self.navigationController.navigationBar standardAppearance];
        if (!appearance) {
            
            appearance = [[UINavigationBarAppearance alloc] init];
        }
        
        // 背景色
        appearance.backgroundColor = [UIColor secondarySystemGroupedBackgroundColor];
        
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        self.navigationController.navigationBar.standardAppearance = appearance;
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    }
    
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(leftAction)];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                          style:UIBarButtonItemStyleDone
                                                                         target:self
                                                                         action:@selector(rightAction)];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    if ([self.delegate respondsToSelector:@selector(pickerViewControllerNavigationTitle)]) {
        
        self.navigationItem.title = [self.delegate pickerViewControllerNavigationTitle];
    }
    
    UIView *superView = self.view;
    
    dataPickerView = [UIPickerView new];
  
    dataPickerView.delegate     = self;
    dataPickerView.dataSource   = self;
    dataPickerView.showsSelectionIndicator = YES;
    dataPickerView.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addSubview:dataPickerView];
    [dataPickerView reloadAllComponents];
    if ([self.delegate respondsToSelector:@selector(pickerViewControllerSelectRowIndex)]) {
        
        [dataPickerView selectRow:[self.delegate pickerViewControllerSelectRowIndex]
                      inComponent:0 animated:YES];
    }
    
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
        
        [self.delegate pickerViewControllerDidSelectIndex:[dataPickerView selectedRowInComponent:0]];
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
    
    if ([self.delegate respondsToSelector:@selector(pickerViewControllerDidChangeToIndex:)]) {
        
        [self.delegate pickerViewControllerDidChangeToIndex:row];
    }
}

@end
