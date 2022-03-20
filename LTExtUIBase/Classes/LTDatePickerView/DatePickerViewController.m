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
        if (@available(iOS 13.4, *)) {
            _picker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        } else {
            // Fallback on earlier versions
        }
        if (@available(iOS 13.0, *)) {
            _picker.backgroundColor = [UIColor secondarySystemGroupedBackgroundColor];
        } else {
            _picker.backgroundColor = [UIColor whiteColor];
        }
    }
    return _picker;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    if (@available(iOS 13.0, *)) {
        
        UINavigationBarAppearance * appearance = [self.navigationController.navigationBar standardAppearance];
        if (!appearance) {
            
            appearance = [[UINavigationBarAppearance alloc] init];
        }
        
        // 背景色
        appearance.backgroundColor = [UIColor secondarySystemGroupedBackgroundColor];
        
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        self.navigationController.navigationBar.standardAppearance = appearance;
    }
    else{
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(leftAction)];
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc]initWithTitle:@"确定"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(rightAction)];
    
    [items addObject:confirmItem];
    
    do {

        if ([self.delegate respondsToSelector:@selector(datePickerViewControllerAssistedButtonTitle)]) {
            
            NSString *assistedButtonTitle = [self.delegate datePickerViewControllerAssistedButtonTitle];
            
            if (assistedButtonTitle.length==0) {
                break;
            }
            
            UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:assistedButtonTitle
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(assistedButtonAction:)];
            
            [items addObject:item];
        }
        
        break;
    } while (YES);
    
    
    self.navigationItem.rightBarButtonItems =  items;
    
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

- (void)assistedButtonAction:(UIBarButtonItem *)item{
    
    if ([self.delegate respondsToSelector:@selector(datePickerViewControllerAssistedButtonPressed:)]) {
        
        [self.delegate datePickerViewControllerAssistedButtonPressed:item.title];
    }
}

@end
