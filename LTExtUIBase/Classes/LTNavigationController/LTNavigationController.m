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

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{

    if (self = [super initWithRootViewController:rootViewController]) {
        
        [self.navigationBar setTranslucent:NO];
        [self.navigationBar lt_setBackgroundImageByColor:[UIColor blackColor]];
        [self.navigationBar setTintColor:[UIColor whiteColor]];
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    }
    return self;
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
    
    return controller;
}

+ (UIImage*) imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage{
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        
        [self.navigationBar setBackgroundImage:backgroundImage
                                forBarPosition:UIBarPositionTopAttached
                                    barMetrics:UIBarMetricsDefault];
    }
    else{
        
        [self.navigationBar setBackgroundImage:backgroundImage
                                 forBarMetrics:UIBarMetricsDefault];
    }
}
@end
