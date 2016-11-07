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

#import "Realm.h"
#import "Position.h"


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
@end

@implementation GRALocationManager

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
        self.area_num = kAreaNumberNone;
        self.place = [NSString string];
        [self configureAreaInformation];
        
        self.delegate = self;
        self.desiredAccuracy = kCLLocationAccuracyBest;
        
        [self requestAlwaysAuthorization];
        self.locationMode = GRALocationDefaultMode;
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
    NSInteger area_num = [self calculateAreaNumber:locations[0]];
    if ((area_num != _area_num) && (area_num != kAreaNumberNone)) {
        _area_num = area_num;
        [self placemarkWithLocation:locations[0] andAreaNumber:area_num];
    }
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

- (void)placemarkWithLocation:(CLLocation *) location andAreaNumber:(NSInteger)area_num; {
    CLGeocoder * geoCoder = [[CLGeocoder alloc]init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * placemarks, NSError * error) {
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
        } else {
            self.place = [NSString stringWithString:[placemarks lastObject].name];
            [self prepareProcessingWithLocation:location andAreaNumber:area_num];
        }
    }];
}

- (void)prepareProcessingWithLocation:(CLLocation *)location andAreaNumber:(NSInteger)area_num {
    switch (_locationMode) {
        case GRALocationForegroundMode:
            [self updateLocation:@[[self dictionaryWithLocation:location andAreaNumber:area_num]] withCompletionHandler:^(BOOL is_success) {
                
            }];
            break;
        case GRALocationBackgroundMode:
            [self saveLocation:location andAreaNumber:area_num];
            break;
        default:
            NSLog(@"Fetal Error in locationMode!");
            break;
    }
}

- (void)saveLocation:(CLLocation *)location andAreaNumber:(NSInteger)area_num {
    Position * position = [[Position alloc]init];
    position.ID = [[NSUserDefaults standardUserDefaults] integerForKey:@"id"];
    position.longitude = location.coordinate.longitude;
    position.latitude = location.coordinate.latitude;
    position.timestamp = location.timestamp.timeIntervalSince1970;
    position.area_num = area_num;
    position.place = self.place;
    RLMRealm * realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:position];
    [realm commitWriteTransaction];
}

- (void)updateLocation:(NSArray *)locations withCompletionHandler:(void(^)(BOOL is_success))handler {
    if ([locations isKindOfClass:[NSArray class]] && locations.count > 0) {
        NSDictionary * paramaters = @{@"datas":locations};
       
        [[GRANetworkingManager sharedManager]uploadLocation:paramaters withCompletionHandler:^(NSDictionary * responseJSON) {
            if ([responseJSON[@"error"] isEqualToString:@"ok"]) {
                NSLog(@"location update success");
                handler(YES);
            }
            handler(NO);
        }];
    }
}

- (NSDictionary *)dictionaryWithLocation:(CLLocation *)location andAreaNumber:(NSInteger)area_num {
    NSDictionary * dict = @{
                              @"user_id": [NSNumber numberWithInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"id"]],
                              @"longitude": [NSNumber numberWithDouble: location.coordinate.longitude],
                              @"latitude": [NSNumber numberWithDouble:location.coordinate.latitude],
                              @"timestamp": [NSNumber numberWithDouble: location.timestamp.timeIntervalSince1970],
                              @"area_num": [NSNumber numberWithInteger:area_num],
                              @"location_name": self.place
                              };
    return dict;
}

- (void)retrieveAndUpdateAllPositions {
    NSString * assert = [NSString stringWithFormat:@"ID = %ld", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"id"]];
    RLMResults * results = [Position objectsWhere:assert];
    NSMutableArray * locations = [NSMutableArray array];
    
    for (Position * positon in results) {
        [locations addObject:[positon convertedToDictionary]];
    }
    
    [self updateLocation:[NSArray arrayWithArray:locations]withCompletionHandler:^(BOOL is_success) {
        if (is_success) {
            RLMRealm * realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            
            for (Position * positon in results) {
                [locations addObject:[positon convertedToDictionary]];
                [realm deleteObject:positon];
            }
            
            [realm commitWriteTransaction];
        }
    }];
}

- (void)setLocationMode:(GRALocationMode)locationMode {
    switch (locationMode) {
        case GRALocationDefaultMode:
            [self stopUpdatingLocation];
            break;
        case GRALocationForegroundMode:
            if (_locationMode != GRALocationForegroundMode) {
                [self retrieveAndUpdateAllPositions];
            }
            [self startUpdatingLocation];
            break;
        case GRALocationBackgroundMode:
            break;
    }
    _locationMode = locationMode;
}

@end
