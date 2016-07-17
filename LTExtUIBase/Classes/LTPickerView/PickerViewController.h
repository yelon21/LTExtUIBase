//
//  PickerViewController.h
//  YJNew
//
//  Created by yelon on 16/3/3.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerViewControllerDelegate <NSObject>

- (void)pickerViewControllerDidSelectIndex:(NSInteger)index;

- (NSUInteger)pickerViewControllerNumberOfItems;
- (NSString *)pickerViewControllerTitleForRowAtIndex:(NSInteger)rowIndex;

@optional
- (void)pickerViewControllerDidChangeToIndex:(NSInteger)index;

@end
@interface PickerViewController : UIViewController

@property(nonatomic,assign)id<PickerViewControllerDelegate>delegate;
@end
