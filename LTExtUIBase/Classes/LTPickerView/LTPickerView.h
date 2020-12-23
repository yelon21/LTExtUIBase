//
//  LTPickerView.h
//  YJNew
//
//  Created by yelon on 16/3/2.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTPickerView;
@class LTNavigationController;

@protocol LTPickerViewDelegate <NSObject>

- (NSUInteger)numberOfItemInltPickerView:(LTPickerView *)ltPickerView;
- (NSString *)ltPickerView:(LTPickerView *)ltPickerView
        titleForRowAtIndex:(NSInteger)rowIndex;
- (void)ltPickerView:(LTPickerView *)ltPickerView
 didSelectRowAtIndex:(NSInteger)rowIndex;
@optional
- (void)ltPickerView:(LTPickerView *)ltPickerView
 didChangeToIndex:(NSInteger)rowIndex;
@end

@interface LTPickerView : UIView

+ (instancetype)showPickerViewInView:(UIView *)inView
                            delegate:(id<LTPickerViewDelegate>)delegate;
+ (instancetype)showPickerViewInView:(UIView *)inView
                     navigationTitle:(NSString *)title
                            delegate:(id<LTPickerViewDelegate>)delegate;

@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)NSUInteger selectRowIndex;

@property(nonatomic,strong,readonly)LTNavigationController *pickerNav;
@end
