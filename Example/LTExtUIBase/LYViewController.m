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
@interface LYViewController ()

@property (weak, nonatomic) IBOutlet LTLoadingButton *btn;

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
    
    self.btn.layer.cornerRadius = 5.0;
//    self.btn.progressBgColor = [UIColor lightGrayColor];
    self.btn.progressColor = [UIColor blueColor];
    AmountTextField *amoutTF = [[AmountTextField alloc]initWithFrame:CGRectMake(120, 200, 100, 40)];
    amoutTF.backgroundColor = [UIColor blueColor];
    amoutTF.textColor = [UIColor whiteColor];
    [amoutTF setContentAmount:1234565];
//    amoutTF.layer.cornerRadius = 5.0;
    
    [self.view addSubview:amoutTF];
    
//    [amoutTF addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)btnAction:(LTLoadingButton *)sender {
    
    [sender startLoading];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [sender stopLoading];
    });
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
    
//    NavViewController *viewCon = [[NavViewController alloc]initWithNibName:@"NavViewController" bundle:nil];
//    [self.navigationController pushViewController:viewCon animated:YES];
}


@end
