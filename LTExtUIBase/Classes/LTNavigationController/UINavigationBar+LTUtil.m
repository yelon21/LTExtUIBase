//
//  UINavigationBar+LTUtil.m
//  LTBarrage
//
//  Created by yelon on 16/8/27.
//  Copyright © 2016年 yelon21. All rights reserved.
//

#import "UINavigationBar+LTUtil.h"

@implementation UINavigationBar (LTUtil)

- (void)lt_setOffsetY:(CGFloat)offsetY{

    CGAffineTransform transform = self.transform;
    transform.ty = offsetY;
    self.transform = transform;
}

- (void)lt_setOffsetX:(CGFloat)offsetX{
    
    CGAffineTransform transform = self.transform;
    transform.tx = offsetX;
    self.transform = transform;
}

- (void)lt_setBackgroundImageByColor:(UIColor *)color{

    UIImage *backgroundImage = [UINavigationBar imageByColor:color];
    
    [self lt_setBackgroundImage:nil];
    [self lt_setBackgroundImage:backgroundImage];
}

- (void)lt_setBackgroundImage:(UIImage *)backgroundImage{

    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        
        [self setBackgroundImage:backgroundImage
                  forBarPosition:UIBarPositionTopAttached
                      barMetrics:UIBarMetricsDefault];
    }
    else{
        
        [self setBackgroundImage:backgroundImage
                   forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)lt_hideNavigationBarItem{

    [self lt_setNavigationBarItemAlpha:0.0];
}

- (void)lt_setNavigationBarItemAlpha:(CGFloat)alpha{

    if (alpha<0.01) {
        
        alpha = 0.01;
    }
    else if (alpha>1.0) {
        
        alpha = 1.0;
    }
    
    for (UIView *view in [self subviews]) {
        
        NSString *className = NSStringFromClass([view class]);
        if (![className isEqualToString:@"_UINavigationBarBackground"]) {
            
            if (view.alpha > 0.0) {
                
                view.alpha = alpha;
            }
        }
    }
}

- (void)lt_setNavigationBarBackgroundAlpha:(CGFloat)alpha{
    
    if (alpha<0.01) {
        
        alpha = 0.01;
    }
    else if (alpha>1.0) {
        
        alpha = 1.0;
    }
    
    for (UIView *view in [self subviews]) {
        
        NSString *className = NSStringFromClass([view class]);
        if ([className isEqualToString:@"_UINavigationBarBackground"]) {
            
            if (view.alpha > 0.0) {
                
                view.alpha = alpha;
            }
            break;
        }
    }
}

//根据颜色返回图片
+ (UIImage*)imageByColor:(UIColor*)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
