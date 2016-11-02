//
//  AppDelegate.m
//  Gravity
//
//  Created by 陈志浩 on 16/6/5.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

#import "GRALoginViewController.h"
#import "GRARegisterFirstViewController.h"
#import "GRARegisterSecondViewController.h"
#import "GRARegisterThirdViewController.h"
#import "GRARegisterFourthViewController.h"
#import "GRAHomePageViewController.h"
#import "GRALocationManager.h"
#import "GRASignatureViewController.h"
#import "GRABasicInformationViewController.h"
#import "GRAGeneralSettingsViewController.h"
#import "GRANotificationPageViewController.h"
#import "GRASystemWingmanViewController.h"
#import "GRAInviteFriendsViewController.h"
#import "GRACardPageViewController.h"
#import "GRAMainPageViewController.h"
#import "GRAOthersInformationViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    GRARegisterSecondViewController * register2 = [[GRARegisterSecondViewController alloc]init];
//    GRARegisterThirdViewController * register3 = [[GRARegisterThirdViewController alloc]init];
//    GRARegisterFourthViewController * register4 = [[GRARegisterFourthViewController alloc]init];
//    GRALoginViewController * login = [[GRALoginViewController alloc]init];
//    GRAHomePageViewController * homepage = [[GRAHomePageViewController alloc]init];
//    GRASignatureViewController * signature = [[GRASignatureViewController alloc]init];
//    GRABasicInformationViewController * basicInfo = [[GRABasicInformationViewController alloc]init];
//    GRAGeneralSettingsViewController * generalSettings = [[GRAGeneralSettingsViewController alloc]init];
//    GRANotificationPageViewController * notifitaionPage = [[GRANotificationPageViewController alloc]init];
//    GRASystemWingmanViewController * systemWingman = [[GRASystemWingmanViewController alloc]init];
//    GRAInviteFriendsViewController * inviteFriends = [[GRAInviteFriendsViewController alloc]init];
//    GRACardPageViewController * cardpage = [[GRACardPageViewController alloc]init];
//    GRAMainPageViewController * mainpage = [[GRAMainPageViewController alloc]init];
//    GRAOthersInformationViewController * othersInfo = [[GRAOthersInformationViewController alloc]init];
    [self configureBasicUI];
    [self configureLocationManager];
    [self locationManagerConfiguration:launchOptions];
    
    return YES;
}

- (void)locationManagerConfiguration:(NSDictionary *)launchOptions {
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey]) {
        [[GRALocationManager sharedManager] requestAlwaysAuthorization];
        [[GRALocationManager sharedManager] setAllowsBackgroundLocationUpdates:YES];
        [[GRALocationManager sharedManager] setLocationMode:GRALocationBackgroundMode];
    }
}

- (void)configureBasicUI {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    GRARegisterFirstViewController * register1 = [[GRARegisterFirstViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:register1];
    [nav.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [nav.navigationBar setShadowImage:[[UIImage alloc]init]];
    CALayer * layer = nav.navigationBar.layer;
    layer.masksToBounds = NO;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(0, 2.5);
    layer.shadowOpacity = 0.1;
    layer.shouldRasterize = YES;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}

- (void)configureLocationManager {
    [[GRALocationManager sharedManager] setAllowsBackgroundLocationUpdates:YES];
    [[GRALocationManager sharedManager] setLocationMode:GRALocationForegroundMode];
}

- (void)configureNotifications {
    UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"Failed to request authorization.");
        }
        if (!granted) {
            NSLog(@"User denied to give authorization.");
        } else {
            NSLog(@"Authorization succeed!");
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[GRALocationManager sharedManager] setLocationMode:GRALocationBackgroundMode];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[GRALocationManager sharedManager] setLocationMode:GRALocationForegroundMode];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
