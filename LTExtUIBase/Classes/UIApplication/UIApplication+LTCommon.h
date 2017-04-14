//
//  UIApplication+LTCommon.h
//  YJQB
//
//  Created by yelon on 2017/4/13.
//  Copyright © 2017年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (LTCommon)

- (void)lt_setStatusBarBackgroundColor:(UIColor *)color;

- (void)lt_setStatusBarBackgroundColor:(UIColor *)color animated:(BOOL)animated;

- (void)lt_openURL:(NSURL *)url
           options:(NSDictionary<NSString *,id> *)options
 completionHandler:(void (^)(BOOL))completion;
@end
