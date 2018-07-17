//
//  UIApplication+LTCommon.m
//  YJQB
//
//  Created by yelon on 2017/4/13.
//  Copyright © 2017年 yelon. All rights reserved.
//

#import "UIApplication+LTCommon.h"

@implementation UIApplication (LTCommon)

-(void)lt_setStatusBarBackgroundColor:(UIColor *)color{

    [self lt_setStatusBarBackgroundColor:color animated:YES];
}

- (void)lt_setStatusBarBackgroundColor:(UIColor *)color animated:(BOOL)animated{
    
    UIView* statusBar = [self valueForKey:@"statusBar"];
    
    UIColor *curColor = statusBar.backgroundColor;
    @synchronized (self) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!CGColorEqualToColor(curColor.CGColor, color.CGColor)) {
                
                [UIView animateWithDuration:animated?0.35:0
                                 animations:^{
                                     
                                     statusBar.backgroundColor = color;
                                 }];
            }
            
        });
    }
}

- (void)lt_openURL:(NSURL *)url
           options:(NSDictionary<NSString *,id> *)options
 completionHandler:(void (^)(BOOL))completion{
    
    if (@available(iOS 10.0, *)) {
        
        [self openURL:url
              options:options
    completionHandler:completion];
    } else {
        
        BOOL flag = [self openURL:url];
        
        if (completion) {
            completion(flag);
        }
    }
}
@end
