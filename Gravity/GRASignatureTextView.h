//
//  GRASignatureTextView.h
//  Gravity
//
//  Created by 陈志浩 on 16/7/7.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GRASignatureTextView : UITextView
typedef void(^characterUpdateBlock)(NSInteger leftCount);
@property (nonatomic, copy) characterUpdateBlock characterUpdate;
@property (nonatomic, strong) NSString * placeholder;
@property (nonatomic) NSInteger maxLength;
@end
