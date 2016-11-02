//
//  GRAPhotoCell.m
//  AvatarPicker
//
//  Created by 陈志浩 on 16/7/4.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAPhotoCell.h"

@interface GRAPhotoCell()
@property (nonatomic, strong) UIImageView * photoView;
@end

@implementation GRAPhotoCell
//- (instancetype)init {
//    if (self = [super init]) {
//        _photoView = [[UIImageView alloc]init];
//        [self addSubview:_photoView];
//    }
//    return self;
//}

- (void)setPhoto:(UIImage *)photo {
    _photo = photo;
    [self.photoView setImage:photo];
}

- (void)setLength:(CGFloat)length {
    _length = length;
    self.photoView.frame = CGRectMake(0, 0, length, length);
}

- (UIImageView *)photoView {
    if (!_photoView) {
        _photoView = [[UIImageView alloc]init];
        [_photoView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        _photoView.contentMode =  UIViewContentModeScaleAspectFill;
        _photoView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _photoView.clipsToBounds  = YES;
        [self.contentView addSubview:_photoView];
    }
    return _photoView;
}
@end
