//
//  GRABasicInformationCell.h
//  Gravity
//
//  Created by 陈志浩 on 16/7/7.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GRAInteractionType){
    GRAInteractionTextType,
    GRAInteractionPickerType,
};

@interface GRABasicInformationCell : UITableViewCell
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * content;

@property (nonatomic, strong) UITextField * contentText;
@property (nonatomic, strong) UILabel * contentLabel;

@property (nonatomic) GRAInteractionType interactionType;
@property (nonatomic) BOOL separator;
@end
