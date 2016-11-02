//
//  GRACardPageCell.h
//  Gravity
//
//  Created by 陈志浩 on 16/7/11.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GRACardPageCellPosition){
    GRACardPageCellFirst,
    GRACardPageCellDefault,
    GRACardPageCellLast,
};

@interface GRACardPageCell : UITableViewCell
@property (nonatomic, strong) NSString * time;
@property (nonatomic, strong) NSAttributedString * title;
@property (nonatomic, strong) NSAttributedString * subtitle;
@property (nonatomic) GRACardPageCellPosition position;
@end
