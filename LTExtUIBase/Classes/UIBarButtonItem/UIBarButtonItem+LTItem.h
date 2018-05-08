//
//  UIBarButtonItem+Item.h
//  YJPay
//
//  Created by yelon on 15/5/11.
//  Copyright (c) 2015年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LTItem)

// Deprecated: use LT_customItemImageName:highlightImageName: target: sel:
+(UIBarButtonItem *)LT_item:(NSString *)imageName
                  highlight:(NSString *)imageNameH
                     target:(NSObject *)target
                        sel:(SEL)sel NS_DEPRECATED_IOS(0_1, 0_2,"Deprecated: use LT_customItemImageName:highlightImageName: target: sel: instead");

+(UIBarButtonItem *)LT_customItemImageName:(NSString *)imageName
                        highlightImageName:(NSString *)highlightImageName
                                    target:(NSObject *)target
                                       sel:(SEL)sel;

// Deprecated: use LT_customItemImage: highlightImage: target: sel:(SEL)sel
+(UIBarButtonItem *)LT_itemImage:(UIImage *)image
                       highlight:(UIImage *)imageH
                          target:(NSObject *)target
                             sel:(SEL)sel NS_DEPRECATED_IOS(0_1, 0_2,"Deprecated: use LT_customItemImage: highlightImage: target: sel: instead");

+(UIBarButtonItem *)LT_customItemImage:(UIImage *)image
                        highlightImage:(UIImage *)highlightImage
                                target:(NSObject *)target
                                   sel:(SEL)sel;

// Deprecated: use LT_customItemImage: highlightImage: target: sel:(SEL)sel
+(UIBarButtonItem *)LT_item:(NSString *)title
                      color:(UIColor *)titleColor
                     target:(NSObject *)target
                        sel:(SEL)sel NS_DEPRECATED_IOS(0_1, 0_2,"Deprecated: use LT_customItemImage: highlightImage: target: sel:(SEL)sel instead");

+(UIBarButtonItem *)LT_customItem:(NSString *)title
                            color:(UIColor *)titleColor
                           target:(NSObject *)target
                              sel:(SEL)sel;

// Deprecated: use LT_customItem: color: font: target: sel:
+(UIBarButtonItem *)LT_item:(NSString *)title
                      color:(UIColor *)titleColor
                       font:(UIFont *)font
                     target:(NSObject *)target
                        sel:(SEL)sel NS_DEPRECATED_IOS(0_1, 0_2,"deprecated: use LT_customItem: color: font: target: sel: instead");

+(UIBarButtonItem *)LT_customItem:(NSString *)title
                            color:(UIColor *)titleColor
                             font:(UIFont *)font
                           target:(NSObject *)target
                              sel:(SEL)sel;

+(UIBarButtonItem *)LT_customItem:(NSString *)title
                       titleColor:(UIColor *)titleColor
                 highlightedColor:(UIColor *)highlightedColor
                             font:(UIFont *)font
                           target:(NSObject *)target
                              sel:(SEL)sel;

+(UIBarButtonItem *)LT_systemItemWithTitle:(NSString *)title
                                    target:(NSObject *)target
                                       sel:(SEL)sel;

+(UIBarButtonItem *)LT_systemItemWithImage:(UIImage *)image
                                    target:(NSObject *)target
                                       sel:(SEL)sel;
@end
