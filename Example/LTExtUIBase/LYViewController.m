//
//  LYViewController.m
//  LTExtUIBase
//
//  Created by yelon21 on 09/18/2016.
//  Copyright (c) 2016 yelon21. All rights reserved.
//

#import "LYViewController.h"
#import "UIControl+LTBlock.h"
#import "LTPickerView.h"
#import "LTNavigationController.h"
#import "AmountTextField.h"
#import "MobileNoTextField.h"
#import "CardTextField.h"
#import "LTLoadingButton.h"
#import "NavViewController.h"
#import "UIView+LTCommon.h"
#import "UIImage+LTCommon.h"
#import "LTActionSheet.h"
#import "LTDatePickerView.h"
@interface LYViewController ()<LTDatePickerViewDelegate,LTActionSheetDelegate>

@property (weak, nonatomic) IBOutlet LTLoadingButton *btn;
@property (weak, nonatomic) IBOutlet UIView *twxtVeiw;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    btn.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:btn];
    
    [btn lt_handleControlEvent:UIControlEventTouchUpInside
                conditionBlock:^BOOL(id obj, ActionBlock actionBlock) {
                    
                    NSLog(@"actionBlock=%@",actionBlock);
                    return YES;
                }
                   actionBlock:^(id obj) {
                       
                       NSLog(@"obj=%@",obj);
                   }];
    
    self.btn.layer.cornerRadius = 5.0;
//    self.btn.progressBgColor = [UIColor lightGrayColor];
    self.btn.progressColor = [UIColor blueColor];
    MobileNoTextField *amoutTF = [[MobileNoTextField alloc]initWithFrame:CGRectMake(50, 200, 200, 40)];
    amoutTF.backgroundColor = [UIColor blueColor];
    amoutTF.textColor = [UIColor whiteColor];
    //[amoutTF setContentAmount:@1234565];
    //amoutTF.maxValue = 50000.00;
//    amoutTF.layer.cornerRadius = 5.0;
    
//    [self.view addSubview:amoutTF];
    
//    [amoutTF addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self testHH];
}

- (void)testHH{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];

    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSArray *iders = [NSLocale availableLocaleIdentifiers];
    
    [iders enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        

        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:obj]];
        NSString *stringRes= [formatter stringFromNumber:@(1234567890.123)];
        if ([stringRes rangeOfString:@" "].location != NSNotFound) {
            
            NSLog(@"%@=%@", obj, [formatter numberFromString:@"1234567890.123"]);
        }
        NSLog(@"%@=%@", obj, [stringRes stringByReplacingOccurrencesOfString:@" " withString:@""]);
    }];
    
}

- (IBAction)btnAction:(LTLoadingButton *)sender {
    
//    [sender startLoading];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        [sender stopLoading];
//    });
    
//    [LTActionSheet LT_ShowActionSheet:@"e3234324"
//                              buttons:@[@"w",@"4e",@"w2"]
//                           clickBlock:nil
//                          cancelBlock:nil];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

//    self.navigationController.navigationBar.tintColor = [UIColor redColor];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"123"
//                                                                            style:UIBarButtonItemStylePlain
//                                                                           target:nil
//                                                                           action:nil];
    
//    LYViewController *viewCon = [[LYViewController alloc]initWithNibName:@"LYViewController"
//                                                                  bundle:nil];
//    [self.navigationController pushViewController:viewCon animated:YES];
    
//    [self.view endEditing:YES];
//    //日期选择演示
//    [self datePickerAction];
//    NavViewController *viewCon = [[NavViewController alloc]initWithNibName:@"NavViewController" bundle:nil];
//    [self.navigationController pushViewController:viewCon animated:YES];
    
//    UIImage *image = [[UIImage imageNamed:@"imageLoadingFailed"] lt_imageWithTintColor:[UIColor redColor]];
//
//    self.imageView.image = [image lt_imageWithMarkString:@"要是有些事我没说，"
//                                                   color:[UIColor whiteColor]
//                                                    font:[UIFont systemFontOfSize:14.0]];
    
    LTActionSheet *sheet = [[LTActionSheet alloc]init];
    sheet.delegate = self;
    [sheet lt_reload];
}
#pragma mark LTActionSheetDelegate
- (NSUInteger)numberOfButtonsInActionSheet:(LTActionSheet *)actionSheet{
    
    return 3;
}

- (void)ltActionSheet:(LTActionSheet *)actionSheet
        iconImageView:(UIImageView *)iconImageView
      buttonTextLabel:(UILabel *)label
              atIndex:(NSUInteger)index{
    
    iconImageView.image = [UIImage imageNamed:@"eg_tulip.jpg"];
    label.text = [NSString stringWithFormat:@"%@",@(index)];
}

- (void)ltActionSheetDidCancel:(LTActionSheet *)actionSheet{
    
}

- (void)ltActionSheet:(LTActionSheet *)actionSheet
         clickAtIndex:(NSUInteger)index
          buttonTitle:(NSString *)buttonTitle{
    
    
}
#pragma mark datePicker
- (void)datePickerAction{
    
    [LTDatePickerView LT_ShowPickerViewInView:self.view
                              navigationTitle:@"你说啥"
                                     delegate:self];
}

-(void)ltDatePickerView:(LTDatePickerView *)ltDatePickerView datePicker:(UIDatePicker *)datePicker{
    
    NSLog(@"日期选择配置");
    datePicker.datePickerMode = UIDatePickerModeDate;
}

-(void)ltDatePickerView:(LTDatePickerView *)ltDatePickerView
          didSelectDate:(NSDate *)date{
    
    NSLog(@"日期选择确认：%@",date);
}

-(void)ltDatePickerViewDidCancel:(LTDatePickerView *)ltDatePickerView{
    
    NSLog(@"日期选择取消");
}

-(void)ltDatePickerView:(LTDatePickerView *)ltDatePickerView assistedButtonPressed:(NSString *)buttonTitle{
    
    NSLog(@"buttonTitle=%@",buttonTitle);
}

-(NSString *)ltDatePickerViewAssistedButtonTitle:(LTDatePickerView *)ltDatePickerView{
    
    return nil;
}

@end
