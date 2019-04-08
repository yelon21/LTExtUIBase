//
//  UIViewController+LTUtil.h
//  YJBM
//
//  Created by yelon on 15/12/4.
//  Copyright © 2015年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIBarButtonItem+LTItem.h"
#import "UIColor+LTCommon.h"

#import "UIImage+LTCommon.h"
#import "UIView+LTCommon.h"
#import "UIView+LTTransform.h"

#import "LTRouter.h"

@interface UIViewController (LTUtil)

- (void)lt_setNavBackItem;

- (void)lt_setNavBackItem:(NSString *)imageName;

- (void)lt_setNavBackItemImg:(UIImage *)image;

- (void)lt_closeSelfAction;
- (void)lt_closeSelfActionAfter:(CGFloat)delay;
//获取最前端的 ViewController (parent)
+ (UIViewController *)LT_FrontViewController;
//获取最前端的 ViewController (child)
+ (UIViewController *)LT_TopFrontViewController;

//获取最前端的 UINavigationController
+ (UINavigationController *)LT_FrontNavigationViewController;
@end
