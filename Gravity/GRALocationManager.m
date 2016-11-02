//
//  GRALocationManager.m
//  Gravity
//
//  Created by 陈志浩 on 16/5/19.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRALocationManager.h"
#import "GRANetworkingManager.h"
#import "AFNetworking.h"

//#define kUpdateTimeInteval 60.0
#define kAreaNumberNone -1
#define kMainLatitudeMin 30.5067940000
#define kMainLongitudeMin 114.4023230000
#define kEastLatitudeMin 30.5057803563
#define kEastLongitudeMin 114.4243050519
#define kPrecision 0.001
#define kMainAreaRowNumber 22
#define kMainAreaLineNumber 15
#define kEastAreaRowNumber 14
#define kEastAreaLineNumber 13

typedef NS_ENUM(NSInteger, GRALocationRegion) {
    GRALocationRegionNone,
    GRALocationRegionMain,
    GRALocationRegionEast,
};

@interface GRALocationManager() {
    CGPoint mainNorthWest, mainSouthWest, mainNorthEast, mainSouthEast, eastNorthEast, eastSouthEast;
}

//@property (nonatomic, assign) CGFloat minSpeed;
//@property (nonatomic, assign) CGFloat minFilter;
//@property (nonatomic, assign) CGFloat minInteval;

@property (nonatomic) double timeInteval;


//@property (nonatomic, strong) CLLocation * lastLocation;
@end

@implementation GRALocationManager
static NSString * uploadURL = @"/backend/api/user/position";

//单例
+ (instancetype)sharedManager{
    static GRALocationManager * instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[GRALocationManager alloc]init];
    });
    return instance;
}
//初始化方法
- (instancetype)init{
    if (self = [super init])
    {
//        self.minSpeed = 3;
//        self.minFilter = 50;
//        self.minInteval = 10;
        self.area_num = kAreaNumberNone;
        [self configureAreaInformation];
        
        self.delegate = self;
        self.desiredAccuracy = kCLLocationAccuracyBest;
//        self.distanceFilter = self.minFilter;
        
        [self requestAlwaysAuthorization];
        self.locationMode = GRALocationDefaultMode;
        
        self.place = [NSString string];
        _timeInteval = 0;
    }
    return self;
}

- (void)configureAreaInformation {
    mainNorthWest = CGPointMake(30.5212870000, 114.4023230000);
    mainSouthWest = CGPointMake(30.5067940000, 114.4025800000);
    mainNorthEast = CGPointMake(30.5186406322, 114.4243050519);
    mainSouthEast = CGPointMake(30.5069416377, 114.4243050519);
    eastNorthEast = CGPointMake(30.5178528130, 114.4380643376);
    eastSouthEast = CGPointMake(30.5057803563, 114.4380643376);
}
//委托方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
//    _lastLocation = locations[0];
    NSInteger area_num = [self calculateAreaNumber:locations[0]];
    if (area_num != _area_num) {
        NSLog(@"%ld", (long)area_num);
        _area_num = area_num;
        [self placemarkWithLocation:locations[0]];
//        [self updateLocation:locations[0]];
    }
//    if (_lastLocation.timestamp.timeIntervalSince1970 - _timeInteval >= kUpdateTimeInteval) {
//        NSLog(@"update location");
//    [self adjustDistanceFilter];
    
//        _timeInteval = _lastLocation.timestamp.timeIntervalSince1970;
//    }
//    switch (_locationMode) {
//        case GRALocationDefaultMode:
//            break;
//        case GRALocationForegroundMode:
//            break;
//        case GRALocationBackgroundMode:
//            break;
//    }
    
}

//- (void)adjustDistanceFilter {
//    //    NSLog(@"adjust:%f",location.speed);
//    CLLocation * location = _lastLocation;
//    if (location.speed < self.minSpeed)
//    {
//        if (fabs(self.distanceFilter-self.minFilter) > 0.1f)
//        {
//            self.distanceFilter = self.minFilter;
//        }
//    }
//    else
//    {
//        CGFloat lastSpeed = self.distanceFilter/self.minInteval;
//        
//        if ((fabs(lastSpeed-location.speed)/lastSpeed > 0.1f) || (lastSpeed < 0))
//        {
//            CGFloat newSpeed  = (int)(location.speed+0.5f);
//            CGFloat newFilter = newSpeed*self.minInteval;
//            
//            self.distanceFilter = newFilter;
//        }
//    }
//}

- (void)updateLocation:(CLLocation *)location {
    NSDictionary * object = @{
                              @"user_id": [NSNumber numberWithInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"id"]],
                              @"longitude": [NSNumber numberWithDouble: location.coordinate.longitude],
                              @"latitude": [NSNumber numberWithDouble:location.coordinate.latitude],
                              @"timestamp": [NSNumber numberWithDouble: location.timestamp.timeIntervalSince1970],
                              @"area_num": [NSNumber numberWithInteger:_area_num],
                              @"location_name": self.place
                              };
    NSDictionary * paramaters = @{
                                  @"datas":@[object]
                                  };
    [[GRANetworkingManager sharedManager]requestWithApplendixURL:uploadURL andParameters:paramaters completionHandler:^(NSDictionary * responseJSON) {
        if ([responseJSON[@"error"] isEqualToString:@"ok"])
            NSLog(@"location update success");
    }];
}

- (NSInteger)calculateAreaNumber:(CLLocation *)location {
    CGFloat lat = location.coordinate.latitude;
    CGFloat lon = location.coordinate.longitude;
    GRALocationRegion region = [self regionWithLocation:location];
    switch (region) {
        case GRALocationRegionMain:
            return ((lat-kMainLatitudeMin)/kPrecision)*kMainAreaRowNumber + ((lon-kMainLongitudeMin)/kPrecision);
            break;
        case GRALocationRegionEast:
            return ((lat-kEastLatitudeMin)/kPrecision)*kEastAreaRowNumber + ((lon-kEastLongitudeMin)/kPrecision)+kMainAreaRowNumber*kMainAreaLineNumber;
            break;
        default:
            return kAreaNumberNone;
            break;
    }
}

- (GRALocationRegion)regionWithLocation:(CLLocation *)location {
    CGFloat lat = location.coordinate.latitude;
    CGFloat lon = location.coordinate.longitude;
    if (((lat - mainNorthWest.x) * (lat - mainSouthWest.x) <= 0) && ((lon - mainNorthWest.y) * (lon - mainNorthEast.y) <= 0))
        return GRALocationRegionMain;
    else if (((lat - mainNorthEast.x) * (lat - eastSouthEast.x) <= 0) && ((lon - mainNorthEast.y) * (lon - eastSouthEast.y) <= 0))
        return GRALocationRegionEast;
    else
        return GRALocationRegionNone;
}

- (void)placemarkWithLocation:(CLLocation *) location {
    CLGeocoder * geoCoder = [[CLGeocoder alloc]init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * placemarks, NSError * error) {
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
        } else {
            self.place = [NSString stringWithString:[placemarks lastObject].name];
            [self updateLocation:location];
        }
    }];
}

- (void)setLocationMode:(GRALocationMode)locationMode {
    _locationMode = locationMode;
    switch (locationMode) {
        case GRALocationDefaultMode:
            break;
        case GRALocationForegroundMode:
            [self startUpdatingLocation];
            break;
        case GRALocationBackgroundMode:
            [self startMonitoringSignificantLocationChanges];
            break;
    }
}

@end
