//
//  AppDelegate.m
//  Gravity
//
//  Created by 陈志浩 on 16/6/5.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

#import "GRAAppSettings.h"
#import "GRALocationManager.h"

#import "GRAStartpageViewController.h"
#import "GRAMainPageViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureLocationManager];
    [self locationManagerConfiguration:launchOptions];
    [self configureBasicUI];
    return YES;
}

- (void)configureLocationManager {
    [[GRALocationManager sharedManager] setAllowsBackgroundLocationUpdates:YES];
}

- (void)locationManagerConfiguration:(NSDictionary *)launchOptions {
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey]) {
        [[GRALocationManager sharedManager] requestAlwaysAuthorization];
        [[GRALocationManager sharedManager] setAllowsBackgroundLocationUpdates:YES];
    }
}

- (void)configureBasicUI {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    UINavigationController * navigation;
    if ([GRAAppSettings sharedSettings].isLogin) {
        GRAMainPageViewController * main = [[GRAMainPageViewController alloc]init];
        [[GRALocationManager sharedManager]setLocationMode:GRALocationForegroundMode];
        navigation = [[UINavigationController alloc]initWithRootViewController:main];

    } else {
        GRAStartpageViewController * start = [[GRAStartpageViewController alloc]init];
        navigation = [[UINavigationController alloc]initWithRootViewController:start];

    }
    [self configureNavitionController:navigation];
    self.window.rootViewController = navigation;
    [self.window makeKeyAndVisible];
}

- (void)configureNavitionController:(UINavigationController *)navigation {
    [navigation.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [navigation.navigationBar setShadowImage:[[UIImage alloc]init]];
    CALayer * layer = navigation.navigationBar.layer;
    layer.masksToBounds = NO;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(0, 2.5);
    layer.shadowOpacity = 0.1;
    layer.shouldRasterize = YES;
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
    if ([GRAAppSettings sharedSettings].isLogin) {
        [[GRALocationManager sharedManager] setLocationMode:GRALocationBackgroundMode];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    if ([GRAAppSettings sharedSettings].isLogin) {
        [[GRALocationManager sharedManager] setLocationMode:GRALocationForegroundMode];
    }
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
