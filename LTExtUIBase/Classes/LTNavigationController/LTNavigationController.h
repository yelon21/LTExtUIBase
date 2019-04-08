//
//  LTNavigationController.h
//  FBSnapshotTestCase
//
//  Created by yelon on 2018/4/27.
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+LTUtil.h"

@interface LTNavigationController : UINavigationController

@property(nonatomic,strong) UIViewController *lt_topContentViewController;

+ (LTNavigationController *)LT_NavigationController:(UIViewController *)rootViewController;
@end

@interface UIViewController (ltnavigationController)

@property(nonatomic,strong,readonly) LTNavigationController *lt_NavigationController;

- (UIBarButtonItem *)lt_backItem;
- (void)lt_backAction:(id)sender;
@end
