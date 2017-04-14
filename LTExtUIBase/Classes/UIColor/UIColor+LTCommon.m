//
//  UIColor+LTCommon.m
//  YLkit
//
//  Created by yelon on 15/7/19.
//  Copyright (c) 2015年 yelon. All rights reserved.
//

#import "UIColor+LTCommon.h"

@implementation UIColor (LTCommon)

+ (UIColor *)colorWithRGBHex:(UInt32)hex {

    return [UIColor LT_colorWithRGBHex:hex];
}

+ (UIColor *)LT_colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {

    return [UIColor LT_colorWithHexString:stringToConvert];
}
+ (UIColor *)LT_colorWithHexString:(NSString *)stringToConvert {
    
    NSString *hexString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [self LT_colorWithRGBHex:hexNum];
}

- (UIColor *)lt_inverseColor {

    CGColorRef oldCGColor = self.CGColor;
    
    CGFloat alpha = CGColorGetAlpha(oldCGColor);
    
    if (alpha==0.0) {
        
        return [UIColor blackColor];
    }
    
    size_t componentsCount = CGColorGetNumberOfComponents(oldCGColor);
    
    const CGFloat *oldComponentColors = CGColorGetComponents(oldCGColor);
    
    CGFloat newComponentColors[componentsCount];
    
    if (componentsCount==1) {
        
        return [UIColor colorWithCGColor:oldCGColor];
    }
    
    long i = componentsCount - 1;
    
    newComponentColors[i] = oldComponentColors[i]; // alpha
    
    while (--i >= 0) {
        
        newComponentColors[i] = 1 - oldComponentColors[i];
    }
    CGColorRef newCGColor = CGColorCreate(CGColorGetColorSpace(oldCGColor), newComponentColors);
    UIColor *newColor = [UIColor colorWithCGColor:newCGColor];
    CGColorRelease(newCGColor);
    
    return [newColor colorWithAlphaComponent:1.0];
}
@end
