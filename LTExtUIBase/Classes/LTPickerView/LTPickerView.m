//
//  LTPickerView.m
//  YJNew
//
//  Created by yelon on 16/3/2.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTPickerView.h"
#import "PickerViewController.h"
#import "UIView+LTTransform.h"

@interface LTPickerView ()<PickerViewControllerDelegate>

@property(nonatomic,strong)id<LTPickerViewDelegate>delegate;
@property(nonatomic,strong)PickerViewController *pickerVC;
@property(nonatomic,strong)UINavigationController *pickerNav;
@end

@implementation LTPickerView

+ (instancetype)showPickerViewInView:(UIView *)inView
                            delegate:(id<LTPickerViewDelegate>)delegate{

    return [LTPickerView showPickerViewInView:inView
                              navigationTitle:nil
                                     delegate:delegate];
}

+ (instancetype)showPickerViewInView:(UIView *)inView
                     navigationTitle:(NSString *)title
                            delegate:(id<LTPickerViewDelegate>)delegate{
    
    LTPickerView *pickerView = [[LTPickerView alloc]initWithSuperView:inView];
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
    self.pickerVC = [[PickerViewController alloc] init];
    self.pickerVC.delegate = self;
    self.pickerNav = [[UINavigationController alloc]initWithRootViewController:self.pickerVC];
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
                                                           constant:0]];
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

-(UINavigationBar *)navigationBar{

    return self.pickerNav.navigationBar;
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

    [self pickerViewControllerDidSelectIndex:-1];
}

- (void)hidePickerVC{
    
    [self.pickerNav.view lt_setTransform:CGAffineTransformMakeTranslation(0.0, CGRectGetHeight(self.bounds))
                                animated:YES
                              completion:^(BOOL finished) {
                                  
                                  [self removeFromSuperview];
                              }];
}

- (NSString *)pickerViewControllerNavigationTitle{

    return self.title;
}

-(void)pickerViewControllerDidSelectIndex:(NSInteger)index{

    [self hidePickerVC];
    if (index<0) {
        
        return;
    }
    if ([self.delegate respondsToSelector:@selector(ltPickerView:didSelectRowAtIndex:)]) {
        
        [self.delegate ltPickerView:self didSelectRowAtIndex:index];
    }
}

- (NSUInteger)pickerViewControllerNumberOfItems{

    NSUInteger count = 0;
    if ([self.delegate respondsToSelector:@selector(numberOfItemInltPickerView:)]) {
        
        count = [self.delegate numberOfItemInltPickerView:self];
    }
    return count;
}

- (NSString *)pickerViewControllerTitleForRowAtIndex:(NSInteger)rowIndex{

    NSString *title = @"";
    
    if ([self.delegate respondsToSelector:@selector(ltPickerView:titleForRowAtIndex:)]) {
        
        title = [self.delegate ltPickerView:self titleForRowAtIndex:rowIndex];
    }
    return title;
}

- (void)pickerViewControllerDidChangeToIndex:(NSInteger)index{

    if ([self.delegate respondsToSelector:@selector(ltPickerView:didChangeToIndex:)]) {
        
        [self.delegate ltPickerView:self didChangeToIndex:index];
    }
}

@end
