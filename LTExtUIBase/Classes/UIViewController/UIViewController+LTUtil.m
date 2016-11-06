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
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem LT_item:@"<"
                                                               color:[UIColor blackColor]
                                                              target:self
                                                                 sel:@selector(lt_popToLastVC)];
}

- (void)lt_popToLastVC{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)lt_popToLastVCAfter:(CGFloat)delay{

    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
       
        [self lt_popToLastVC];
    });
}

- (void)lt_setPresentedVCBackItem{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem LT_item:@"X"
                                                               color:[UIColor blackColor]
                                                              target:self
                                                                 sel:@selector(lt_dismissToLastVC)];
}

- (void)lt_dismissToLastVC{

    [self dismissViewControllerAnimated:YES completion:nil];
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
