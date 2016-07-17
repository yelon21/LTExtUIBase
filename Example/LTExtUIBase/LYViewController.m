//
//  LYViewController.m
//  LTExtUIBase
//
//  Created by yelon21 on 07/17/2016.
//  Copyright (c) 2016 yelon21. All rights reserved.
//

#import "LYViewController.h"
#import <LTExtUIBase/LTPickerView.h>
@interface LYViewController ()<LTPickerViewDelegate>{
    
    NSArray *listArray;
}


@end

@implementation LYViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    listArray = @[@{@"title":@"名称1",
                    @"value":@"000",@"image":@"eeee"},
                  @{@"title":@"名称2",@"value":@"000",@"image":@"eeee"},
                  @{@"title":@"名称3",@"value":@"000",@"image":@"eeee"}];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    [LTPickerView showPickerViewInView:self.view
                              delegate:self];
}

- (NSUInteger)numberOfItemInltPickerView:(LTPickerView *)ltPickerView{
    
    return [listArray count];
}
- (NSString *)ltPickerView:(LTPickerView *)ltPickerView
        titleForRowAtIndex:(NSInteger)rowIndex{
    
    return listArray[rowIndex][@"title"];
}
- (void)ltPickerView:(LTPickerView *)ltPickerView
 didSelectRowAtIndex:(NSInteger)rowIndex{
    
    NSLog(@"didSelect=%@",listArray[rowIndex][@"title"]);
}
- (void)ltPickerView:(LTPickerView *)ltPickerView
    didChangeToIndex:(NSInteger)rowIndex{
    
    NSLog(@"didChange=%@",listArray[rowIndex][@"title"]);
}

@end
