//
//  LTDatePickerView.m
//  LTExtUIBase
//
//  Created by yelon on 2018/1/31.
//

#import "LTDatePickerView.h"
#import "DatePickerViewController.h"
#import "UIView+LTTransform.h"
#import "LTNavigationController.h"

#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
@interface LTDatePickerView ()<DatePickerViewControllerDelegate>

@property(nonatomic,strong) id<LTDatePickerViewDelegate> delegate;
@property(nonatomic,strong) DatePickerViewController     *pickerVC;
@property(nonatomic,strong) LTNavigationController       *pickerNav;
@end

@implementation LTDatePickerView

+(instancetype)LT_ShowPickerViewInView:(UIView *)inView
                       navigationTitle:(NSString *)title
                              delegate:(id<LTDatePickerViewDelegate>)delegate{
    
    LTDatePickerView *pickerView = [[LTDatePickerView alloc]initWithSuperView:inView];
    pickerView.delegate = delegate;
    pickerView.title = title;
    return pickerView;
}

-(instancetype)initWithSuperView:(UIView *)superView{
    
    if (self = [self initWithFrame:superView.bounds]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [superView addSubview:self];
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:0]];
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:0]];
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:0]];
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:0]];
        
        [self initPickerVC];
        [self moveInPickerVC];
    }
    return self;
}

- (void)initPickerVC{
    
    if (self.pickerVC) {
        
        return;
    }
    self.pickerVC = [[DatePickerViewController alloc] init];
    self.pickerVC.delegate = self;
    self.pickerNav = [LTNavigationController LT_NavigationController:self.pickerVC];
    self.pickerNav.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *superView = self;
    [superView addSubview:self.pickerNav.view];
    
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.pickerNav.view
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.pickerNav.view
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.pickerNav.view
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:KIsiPhoneX?-34:0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.pickerNav.view
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:260.0]];
    
    [self moveOutPickerVC];
}

-(void)setTitle:(NSString *)title{
    
    if (_title != title) {
        
        _title = title;
        if (self.pickerNav) {
            
            self.pickerNav.navigationItem.title = _title;
        }
    }
}

- (void)moveOutPickerVC{
    
    [self.pickerNav.view lt_setTransform:CGAffineTransformMakeTranslation(0.0, CGRectGetHeight(self.bounds))
                                animated:NO];
    [self lt_setAlpha:0.0 animated:NO];
}

- (void)moveInPickerVC{
    
    [self lt_setAlpha:1.0 animated:NO];
    
    [self.pickerNav.view lt_resetTransform:YES];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self datePickerViewControllerDidCancel];
}

- (void)hidePickerVC{
    
    [self.pickerNav.view lt_setTransform:CGAffineTransformMakeTranslation(0.0, CGRectGetHeight(self.bounds))
                                animated:YES
                              completion:^(BOOL finished) {
                                  
                                  [self removeFromSuperview];
                              }];
}

#pragma mark delegate
- (NSString *)datePickerViewControllerNavigationTitle{
    
    return self.title;
}

-(void)datePickerView:(UIDatePicker *)datePicker{
    
    if ([self.delegate respondsToSelector:@selector(ltDatePickerView:datePicker:)]) {
        
        [self.delegate ltDatePickerView:self
                             datePicker:datePicker];
    }
}

-(void)datePickerViewControllerDidSelectDate:(NSDate *)date{
    
    [self hidePickerVC];
    
    if ([self.delegate respondsToSelector:@selector(ltDatePickerView:didSelectDate:)]) {
        
        [self.delegate ltDatePickerView:self
                          didSelectDate:date];
    }
}

-(void)datePickerViewControllerDidCancel{
    
     [self hidePickerVC];
    
    if ([self.delegate respondsToSelector:@selector(ltDatePickerViewDidCancel:)]) {
        
        [self.delegate ltDatePickerViewDidCancel:self];
    }
}

-(NSString *)datePickerViewControllerAssistedButtonTitle{
    
    if ([self.delegate respondsToSelector:@selector(ltDatePickerViewAssistedButtonTitle:)]) {
        
        return [self.delegate ltDatePickerViewAssistedButtonTitle:self];
    }
    return @"";
}

-(void)datePickerViewControllerAssistedButtonPressed:(NSString *)buttonTitle{
    
    [self hidePickerVC];
    
    if ([self.delegate respondsToSelector:@selector(ltDatePickerView:assistedButtonPressed:)]) {
        
        return [self.delegate ltDatePickerView:self assistedButtonPressed:buttonTitle];
    }
}

@end
