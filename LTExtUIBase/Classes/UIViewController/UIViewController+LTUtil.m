//
//  UIViewController+LTUtil.m
//  YJBM
//
//  Created by yelon on 15/12/4.
//  Copyright © 2015年 yelon. All rights reserved.
//

#import "UIViewController+LTUtil.h"

@implementation UIViewController (LTUtil)

- (void)lt_setNavBackItem{
    
    [self lt_setNavBackItem:@"nav_back"];
}

- (void)lt_setNavBackItem:(NSString *)imageName{
    
    [self lt_setNavBackItemImg:[UIImage imageNamed:imageName]];
}

- (void)lt_setNavBackItemImg:(UIImage *)image{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem LT_itemImage:image
                                                                highlight:nil
                                                                   target:self
                                                                      sel:@selector(lt_popToLastVC)];
}

- (void)lt_closeSelfAction{
    
    [LTRouter LT_CloseViewController:self animated:YES];
}

- (void)lt_closeSelfActionAfter:(CGFloat)delay{

    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
       
        [self lt_closeSelfAction];
    });
}

+ (UIViewController *)LT_FrontViewController{
    
    UIViewController *viewCon = [[UIApplication sharedApplication].delegate window].rootViewController;
    return [UIViewController LT_FrontViewController:viewCon];
}

+ (UIViewController *)LT_FrontViewController:(UIViewController *)root{
    
    UIViewController *rootVC = root;
    
    if (rootVC.presentedViewController) {
        
        return [self LT_FrontViewController:rootVC.presentedViewController];
    }
    return rootVC;
}
@end
