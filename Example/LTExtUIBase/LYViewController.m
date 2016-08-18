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
    NSArray *imageArray;
    NSInteger imageIndex;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation LYViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor blackColor];
    listArray = @[@{@"title":@"名称1",
                    @"value":@"000",@"image":@"eeee"},
                  @{@"title":@"名称2",@"value":@"000",@"image":@"eeee"},
                  @{@"title":@"名称3",@"value":@"000",@"image":@"eeee"}];
    
//    NSArray *images = @[[UIImage imageNamed:@"1.png"],[UIImage imageNamed:@"2.png"],[UIImage imageNamed:@"3.png"]];
//    self.imageView.animationImages = images;
//    self.imageView.animationDuration = 9.0;
//    self.imageView.animationRepeatCount = 0;
//    
//    [self.imageView startAnimating];
    
    imageArray = @[@"1.png",@"2.png",@"3.png"];
    
    self.imageView.image = [UIImage imageNamed:imageArray[imageIndex]];
    imageIndex = ++imageIndex%[imageArray count];
    self.bgImageView.image = [UIImage imageNamed:imageArray[imageIndex]];
    
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(updateImages) userInfo:nil repeats:YES];
}

- (void)updateImages{

    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.imageView.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         
                         self.imageView.image = [UIImage imageNamed:imageArray[imageIndex]];
                         imageIndex = ++imageIndex%[imageArray count];
                         [UIView animateWithDuration:1.0
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              
                                              self.imageView.alpha = 1.0;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              self.bgImageView.image = [UIImage imageNamed:imageArray[imageIndex]];
                                          }];
                     }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [LTPickerView showPickerViewInView:self.view
                       navigationTitle:@"2131"
                              delegate:self];
    
//    LTPickerView *picker = [LTPickerView showPickerViewInView:self.view
//                              delegate:self];
//    picker.title = @"www";
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
