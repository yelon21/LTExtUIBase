//
//  DatePickerViewController.h
//  LTExtUIBase
//
//  Created by yelon on 2018/1/31.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewControllerDelegate <NSObject>

- (void)datePickerViewControllerDidSelectDate:(NSDate *)date;
- (void)datePickerViewControllerDidCancel;
@optional

- (NSString *)datePickerViewControllerNavigationTitle;

- (NSString *)datePickerViewControllerAssistedButtonTitle;
- (void)datePickerViewControllerAssistedButtonPressed:(NSString *)buttonTitle;

- (void)datePickerView:(UIDatePicker *)datePicker;
@end

@interface DatePickerViewController : UIViewController

@property(nonatomic,assign)id<DatePickerViewControllerDelegate>delegate;
@end
