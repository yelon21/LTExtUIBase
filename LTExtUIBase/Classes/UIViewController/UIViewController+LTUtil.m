//
//  UIViewController+LTUtil.m
//  YJBM
//
//  Created by yelon on 15/12/4.
//  Copyright © 2015年 yelon. All rights reserved.
//

#import "UIViewController+LTUtil.h"
#import "LTNavigationController.h"
@implementation UIViewController (LTUtil)

- (void)lt_setNavBackItem{
    
    [self lt_setNavBackItem:@"nav_back"];
}

- (void)lt_setNavBackItem:(NSString *)imageName{
    
    [self lt_setNavBackItemImg:[UIImage imageNamed:imageName]];
}

- (void)lt_setNavBackItemImg:(UIImage *)image{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem LT_systemItemWithImage:image
                                                                             target:self
                                                                        sel:@selector(lt_closeSelfAction)];
}

- (void)lt_closeSelfAction{
    
    [LTRouter LT_CloseViewController:self animated:YES];
}

- (void)lt_closeSelfActionAfter:(CGFloat)delay{

    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay*NSEC_PER_SEC);
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

+ (UIViewController *)LT_TopFrontViewController{
    
    UIViewController *viewCon = [[UIApplication sharedApplication].delegate window].rootViewController;
    return [UIViewController LT_FrontTopViewController:viewCon];
}

+ (UIViewController *)LT_FrontTopViewController:(UIViewController *)root{
    
    UIViewController *rootVC = root;
    
    if (rootVC.presentedViewController) {
        
        return [self LT_FrontTopViewController:rootVC.presentedViewController];
    }
    else if ([rootVC isKindOfClass:[LTNavigationController class]]) {
        
        return [(LTNavigationController *)rootVC lt_topContentViewController];
    }
    else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        
        return [(UINavigationController *)rootVC topViewController];
    }
    else if ([rootVC isKindOfClass:[UITabBarController class]]) {
        
        return [self LT_FrontTopViewController:[(UITabBarController *)rootVC selectedViewController]];
    }
    else if ([[rootVC childViewControllers] count]>0) {
        
        return [self LT_FrontTopViewController:[[rootVC childViewControllers]lastObject]];
    }
    else if ([rootVC isKindOfClass:[UIViewController class]]) {
        
        return rootVC;
    }
    
    return rootVC;
}

//获取最前端的 UINavigationController
+ (UINavigationController *)LT_FrontNavigationViewController{
    
    UIViewController *viewCon = [self LT_FrontViewController];
    
    return [self LT_FindFrontNavigationViewController:viewCon];
}

+ (UINavigationController *)LT_FindFrontNavigationViewController:(UIViewController *)root{
    
    UIViewController *rootVC = root;
    
    if (rootVC.presentedViewController) {
        
        return [self LT_FindFrontNavigationViewController:rootVC.presentedViewController];
    }
    else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        
        return (UINavigationController *)rootVC;
    }
    else if ([rootVC isKindOfClass:[UITabBarController class]]) {
        
        return [self LT_FindFrontNavigationViewController:[(UITabBarController *)rootVC selectedViewController]];
    }
    else if ([rootVC isKindOfClass:[UIViewController class]]) {
        
        return rootVC.navigationController;
    }
    return nil;
}
@end
