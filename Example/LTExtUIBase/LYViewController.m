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

@interface LYViewController ()

@end

@implementation LYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    btn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:btn];
    
    [btn lt_handleControlEvent:UIControlEventTouchUpInside
                conditionBlock:^BOOL(id obj, ActionBlock actionBlock) {
                    
                    NSLog(@"actionBlock=%@",actionBlock);
                    return YES;
                }
                   actionBlock:^(id obj) {
                       
                       NSLog(@"obj=%@",obj);
                   }];
    
    AmountTextField *amoutTF = [[AmountTextField alloc]initWithFrame:CGRectMake(20, 40, 200, 40)];
    amoutTF.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:amoutTF];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}


@end
