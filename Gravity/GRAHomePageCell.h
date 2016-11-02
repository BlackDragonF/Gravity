//
//  HomepageCell.h
//  Gravity
//
//  Created by 陈志浩 on 16/4/12.
//  Copyright © 2016年 UniqueStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRAHomePageCell : UITableViewCell
@property (nonatomic, strong) UIImage * icon;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * subtitle;
@property (nonatomic) BOOL arrowed;
@property (nonatomic) BOOL highlightedSubtitle;
@property (nonatomic) BOOL separator;
@end
