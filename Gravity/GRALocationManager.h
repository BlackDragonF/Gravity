//
//  GRALocationManager.h
//  Gravity
//
//  Created by 陈志浩 on 16/5/19.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSInteger, GRALocationMode) {
    GRALocationDefaultMode,
    GRALocationForegroundMode,
    GRALocationBackgroundMode,
};

@interface GRALocationManager : CLLocationManager<CLLocationManagerDelegate>
@property (nonatomic) GRALocationMode locationMode;

@property (nonatomic) NSInteger area_num;
@property (nonatomic, strong) NSString * place;

+ (instancetype)sharedManager;

- (NSInteger)calculateAreaNumber:(CLLocation *)location;
- (void)placemarkWithLocation:(CLLocation *) location andAreaNumber:(NSInteger)area_num;
@end
