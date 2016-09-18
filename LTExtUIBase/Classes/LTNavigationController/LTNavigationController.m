//
//  LTNavigationController.m
//  LTBarrage
//
//  Created by yelon on 16/8/27.
//  Copyright © 2016年 yelon21. All rights reserved.
//

#import "LTNavigationController.h"

@interface LTNavigationController ()

@end

@implementation LTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate {
    
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

+ (LTNavigationController *)LT_NavigationController:(UIViewController *)rootViewController{
    
    LTNavigationController *controller = [[LTNavigationController alloc] initWithRootViewController:rootViewController];
    [controller.navigationBar setTranslucent:YES];
    [controller.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                                 forKey:NSForegroundColorAttributeName]];
    
    return controller;
}
@end
