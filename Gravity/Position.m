//
//  Position.m
//  Gravity
//
//  Created by 陈志浩 on 2016/11/2.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "Position.h"

@implementation Position
- (NSDictionary *)convertedToDictionary {
    NSDictionary * dict = @{
                            @"user_id": [NSNumber numberWithInteger:self.ID],
                            @"longitude": [NSNumber numberWithDouble:self.longitude],
                            @"latitude": [NSNumber numberWithDouble:self.latitude],
                            @"timestamp": [NSNumber numberWithDouble:self.timestamp],
                            @"area_num": [NSNumber numberWithInteger:self.area_num],
                            @"location_name": self.place
                            };
    return dict;
}
@end
