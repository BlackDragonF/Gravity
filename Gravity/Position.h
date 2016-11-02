//
//  Position.h
//  Gravity
//
//  Created by 陈志浩 on 2016/11/2.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "Realm.h"

@interface Position : RLMObject
@property NSInteger ID;
@property double longitude;
@property double latitude;
@property double timestamp;
@property NSInteger area_num;
@property NSString * place;

- (NSDictionary *)convertedToDictionary;
@end
