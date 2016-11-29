//
//  LYAppDelegate.m
//  LTExtUIBase
//
//  Created by yelon21 on 09/18/2016.
//  Copyright (c) 2016 yelon21. All rights reserved.
//

#import "LYAppDelegate.h"
#import "LYViewController.h"
#import "LTNavigationController.h"

@implementation LYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    LYViewController *viewCon = [[LYViewController alloc]init];
    
    NSNumber *number = @(1234567890);
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
   
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_Hans_CN"]];
    
    [formatter setPaddingPosition:NSNumberFormatterPadAfterSuffix];
    
    [formatter setUsesGroupingSeparator:YES];
    [formatter setGroupingSize:4];//四个一组
    [formatter setGroupingSeparator:@" "];
    
    [formatter setNumberStyle:NSNumberFormatterNoStyle];
    NSLog(@"NSNumberFormatterNoStyle=%@",[formatter stringFromNumber:number]);

    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSLog(@"NSNumberFormatterDecimalStyle=%@",[formatter stringFromNumber:number]);
    
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSLog(@"NSNumberFormatterCurrencyStyle=%@",[formatter stringFromNumber:number]);
    
    [formatter setNumberStyle:NSNumberFormatterPercentStyle];
    NSLog(@"NSNumberFormatterPercentStyle=%@",[formatter stringFromNumber:number]);
    
    [formatter setNumberStyle:NSNumberFormatterScientificStyle];
    NSLog(@"NSNumberFormatterScientificStyle=%@",[formatter stringFromNumber:number]);
    
    [formatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    NSLog(@"NSNumberFormatterSpellOutStyle=%@",[formatter stringFromNumber:number]);
    
    [formatter setNumberStyle:NSNumberFormatterOrdinalStyle];
    NSLog(@"NSNumberFormatterOrdinalStyle=%@",[formatter stringFromNumber:number]);
    
    [formatter setNumberStyle:NSNumberFormatterCurrencyISOCodeStyle];
    NSLog(@"NSNumberFormatterCurrencyISOCodeStyle=%@",[formatter stringFromNumber:number]);
    
    [formatter setNumberStyle:NSNumberFormatterCurrencyPluralStyle];
    NSLog(@"NSNumberFormatterCurrencyPluralStyle=%@",[formatter stringFromNumber:number]);
    
    [formatter setNumberStyle:NSNumberFormatterCurrencyAccountingStyle];
    NSLog(@"NSNumberFormatterCurrencyAccountingStyle=%@",[formatter stringFromNumber:number]);
    
    self.window.rootViewController = [LTNavigationController LT_NavigationController:viewCon];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
