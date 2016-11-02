//
//  GRANotificationPageCell.h
//  Gravity
//
//  Created by 陈志浩 on 16/7/9.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRANotificationPageCell : UITableViewCell
@property (nonatomic, strong) UIImage * icon;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * subtitle;
@property (nonatomic) BOOL separator;
@end
