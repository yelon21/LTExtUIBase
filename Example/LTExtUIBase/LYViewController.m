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
@interface LYViewController ()<LTPickerViewDelegate>

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
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [LTPickerView showPickerViewInView:self.view
                       navigationTitle:@"3242"
                              delegate:self];
}

- (NSUInteger)numberOfItemInltPickerView:(LTPickerView *)ltPickerView{

    return 5;
}

- (NSString *)ltPickerView:(LTPickerView *)ltPickerView
        titleForRowAtIndex:(NSInteger)rowIndex{

    return [NSString stringWithFormat:@"%@",@(rowIndex)];
}

- (void)ltPickerView:(LTPickerView *)ltPickerView
 didSelectRowAtIndex:(NSInteger)rowIndex{


}

@end
