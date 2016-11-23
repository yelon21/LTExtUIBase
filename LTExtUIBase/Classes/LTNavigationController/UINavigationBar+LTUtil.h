//
//  UINavigationBar+LTUtil.h
//  LTBarrage
//
//  Created by yelon on 16/8/27.
//  Copyright © 2016年 yelon21. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (LTUtil)

- (void)lt_setOffsetY:(CGFloat)offsetY;
- (void)lt_setOffsetX:(CGFloat)offsetX;

- (void)lt_setBackgroundImageByColor:(UIColor *)color;

- (void)lt_setBackgroundImage:(UIImage *)backgroundImage;

- (void)lt_hideNavigationBarItem;
- (void)lt_setNavigationBarItemAlpha:(CGFloat)alpha;
@end
