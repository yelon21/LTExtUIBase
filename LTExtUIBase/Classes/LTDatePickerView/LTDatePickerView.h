//
//  LTDatePickerView.h
//  LTExtUIBase
//
//  Created by yelon on 2018/1/31.
//

#import <UIKit/UIKit.h>

@class LTDatePickerView;
@class LTNavigationController;

@protocol LTDatePickerViewDelegate <NSObject>

@optional
- (void)ltDatePickerView:(LTDatePickerView *)ltDatePickerView
              datePicker:(UIDatePicker *)datePicker;
- (void)ltDatePickerView:(LTDatePickerView *)ltDatePickerView
           didSelectDate:(NSDate *)date;
- (void)ltDatePickerViewDidCancel:(LTDatePickerView *)ltDatePickerView;
@end

@interface LTDatePickerView : UIView

+ (instancetype)LT_ShowPickerViewInView:(UIView *)inView
                        navigationTitle:(NSString *)title
                               delegate:(id<LTDatePickerViewDelegate>)delegate;

@property(nonatomic,strong)NSString *title;

@property(nonatomic,strong,readonly)LTNavigationController *pickerNav;

@end
