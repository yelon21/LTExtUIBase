//
//  UIColor+LTCommon.h
//  YLkit
//
//  Created by yelon on 15/7/19.
//  Copyright (c) 2015年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define UIColorRGB(r,g,b) UIColorRGBA(r,g,b,1.0)

#define UIColorRGBHex(rgbValue) UIColorRGBAHex(rgbValue,1.0)

#define UIColorRGBAHex(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
@interface UIColor (LTCommon)
/**
 *  @author yelon
 *
 *  根据色值返回颜色对象
 *
 *  @param hex 十六进制RGB色值
 *
 *  @return 颜色UIColor
 */
+ (UIColor *)LT_colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithRGBHex:(UInt32)hex NS_DEPRECATED_IOS(2_0, 3_0);
/**
 *  @author yelon
 *
 *  根据色值返回颜色对象
 *
 *  @param stringToConvert 十六进制RGB色值字符串
 *
 *  @return 颜色UIColor
 */
+ (UIColor *)LT_colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert NS_DEPRECATED_IOS(2_0, 3_0);

/**
 取反色

 @return 反色
 */
- (UIColor *)lt_inverseColor;
@end
