//
//  AppDelegate.m
//  Gravity
//
//  Created by 陈志浩 on 16/6/5.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

#import "GRALocationManager.h"
#import "GRAStartpageViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureBasicUI];
    [self configureLocationManager];
    [self locationManagerConfiguration:launchOptions];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"login"];
    return YES;
}

- (void)configureBasicUI {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    GRAStartpageViewController * start = [[GRAStartpageViewController alloc]init];
    self.window.rootViewController = start;
    [self.window makeKeyAndVisible];
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
    BOOL isLogin = [[NSUserDefaults standardUserDefaults]boolForKey:@"login"];
    if (isLogin)
        [[GRALocationManager sharedManager] setLocationMode:GRALocationBackgroundMode];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    BOOL isLogin = [[NSUserDefaults standardUserDefaults]boolForKey:@"login"];
    if (isLogin)
        [[GRALocationManager sharedManager] setLocationMode:GRALocationForegroundMode];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
