//
//  UIBarButtonItem+Item.m
//  YJPay
//
//  Created by yelon on 15/5/11.
//  Copyright (c) 2015年 yelon. All rights reserved.
//

#import "UIBarButtonItem+LTItem.h"
#import "UIControl+LTBlock.h"

@implementation UIBarButtonItem (LTItem)

+(UIBarButtonItem *)LT_item:(NSString *)imageName
               highlight:(NSString *)imageNameH
                  target:(NSObject *)target
                     sel:(SEL)sel{
    
    return [UIBarButtonItem LT_customItemImage:[UIImage imageNamed:imageName]
                                highlightImage:imageNameH?[UIImage imageNamed:imageNameH]:nil
                                        target:target
                                           sel:sel];
}

+(UIBarButtonItem *)LT_customItemImageName:(NSString *)imageName
                        highlightImageName:(NSString *)highlightImageName
                                    target:(NSObject *)target
                                       sel:(SEL)sel{
    
    return [UIBarButtonItem LT_customItemImage:[UIImage imageNamed:imageName]
                                highlightImage:highlightImageName?[UIImage imageNamed:highlightImageName]:nil
                                        target:target
                                           sel:sel];
}

+(UIBarButtonItem *)LT_itemImage:(UIImage *)image
                  highlight:(UIImage *)imageH
                     target:(NSObject *)target
                        sel:(SEL)sel{
    
    return [UIBarButtonItem LT_customItemImage:image
                                highlightImage:imageH
                                        target:target
                                           sel:sel];
}

+(UIBarButtonItem *)LT_customItemImage:(UIImage *)image
                        highlightImage:(UIImage *)highlightImage
                                target:(NSObject *)target
                                   sel:(SEL)sel{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    
    if (image) {
        
        [btn setImage:image
             forState:UIControlStateNormal];
    }
    
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.contentMode = UIViewContentModeLeft;
    [btn sizeToFit];
    CGRect frame = btn.frame;
    frame.size.width = MAX(frame.size.width, 20.0);
    btn.frame = frame;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}

+(UIBarButtonItem *)LT_item:(NSString *)title
                   color:(UIColor *)titleColor
                  target:(NSObject *)target
                     sel:(SEL)sel{
    
    return [self LT_item:title
                   color:titleColor
                    font:[UIFont systemFontOfSize:17.0]
                  target:target
                     sel:sel];
}
//
+(UIBarButtonItem *)LT_customItem:(NSString *)title
                            color:(UIColor *)titleColor
                           target:(NSObject *)target
                              sel:(SEL)sel{
    
    return [self LT_customItem:title
                         color:titleColor
                          font:[UIFont systemFontOfSize:17.0]
                        target:target
                           sel:sel];
}

+(UIBarButtonItem *)LT_item:(NSString *)title
                      color:(UIColor *)titleColor
                       font:(UIFont *)font
                     target:(NSObject *)target
                        sel:(SEL)sel{
    
    return [UIBarButtonItem LT_customItem:title
                               titleColor:titleColor
                         highlightedColor:nil
                                     font:font
                                   target:target
                                      sel:sel];
}
//
+(UIBarButtonItem *)LT_customItem:(NSString *)title
                            color:(UIColor *)titleColor
                             font:(UIFont *)font
                           target:(NSObject *)target
                              sel:(SEL)sel{
    
    return [UIBarButtonItem LT_customItem:title
                               titleColor:titleColor
                         highlightedColor:nil
                                     font:font
                                   target:target
                                      sel:sel];
}

+(UIBarButtonItem *)LT_customItem:(NSString *)title
                       titleColor:(UIColor *)titleColor
                 highlightedColor:(UIColor *)highlightedColor
                             font:(UIFont *)font
                           target:(NSObject *)target
                              sel:(SEL)sel{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    btn.backgroundColor = [UIColor clearColor];
    if (font) {
        
        btn.titleLabel.font = font;
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    if (!titleColor) {
        
        titleColor = [UIColor whiteColor];
    }

    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    
    if (!highlightedColor) {
        
        highlightedColor = [UIColor whiteColor];
    }
    
    [btn setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    CGRect frame = btn.frame;
    frame.size.width = MAX(frame.size.width, 20.0);
    btn.frame = frame;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}

+(UIBarButtonItem *)LT_systemItemWithTitle:(NSString *)title
                                    target:(NSObject *)target
                                       sel:(SEL)sel{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:title
                                                            style:UIBarButtonItemStylePlain
                                                           target:target
                                                           action:sel];
    return item;
}

+(UIBarButtonItem *)LT_systemItemWithImage:(UIImage *)image
                                    target:(NSObject *)target
                                       sel:(SEL)sel{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image
                                                            style:UIBarButtonItemStylePlain
                                                           target:target
                                                           action:sel];
    return item;
}
@end
