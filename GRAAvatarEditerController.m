//
//  GRAAvatarEditerController.m
//  AvatarPicker
//
//  Created by 陈志浩 on 16/7/4.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAAvatarEditerController.h"

#import "Masonry.h"
#import "ColorMacro.h"


#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define LENGTH 295.0
#define MAX_ZOOMSCALE 1.2

@interface GRAAvatarEditerController()<UIScrollViewDelegate> {
    CGSize _imageSize;
    UIImage * _image;
}
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIBarButtonItem * backButton;
@property (nonatomic, strong) UIView * bottomView;
@property (nonatomic, strong) UIButton * finishButton;

@property (nonatomic, strong) CAShapeLayer * maskLayer;
@property (nonatomic, strong) CAShapeLayer * borderLayer;
@end

@implementation GRAAvatarEditerController
- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        _image = image;
        _imageSize = CGSizeMake(image.size.width, image.size.height);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = _image;
    [self basicConfiguration];
    [self addConstraints];
    [self imageConfiguration];

}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setTranslucent:YES];
//}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    CGRect navRect = self.navigationController.navigationBar.frame;
    self.navigationController.navigationBar.frame = CGRectMake(navRect.origin.x, navRect.origin.y, navRect.size.width, 44);
    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:0.0 forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setTranslucent:NO];
}
#pragma mark 基本配置
- (void)basicConfiguration {
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem * negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -4.0;
    [self.backButton setBackgroundVerticalPositionAdjustment:-10.0 forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, self.backButton];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    self.navigationController.navigationBarHidden = NO;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor backGroundColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor textWhiteColor2]];
    [self setTitle:@"移动和缩放"];
    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:-10.0 forBarMetrics:UIBarMetricsDefault];
    CGRect navRect = self.navigationController.navigationBar.frame;
    self.navigationController.navigationBar.frame = CGRectMake(navRect.origin.x, navRect.origin.y, navRect.size.width, 64);

    self.contentView.layer.mask = self.maskLayer;
    [self.contentView.layer insertSublayer:self.borderLayer above:self.imageView.layer];

}
#pragma mark UI配置
- (void)addConstraints {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(20, 0, 0, 0));
    }];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(@44);
    }];
    [self.finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView.mas_centerY);
        make.right.equalTo(self.bottomView.mas_right).with.offset(-10);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@72);
    }];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
#pragma mark 交互相关
- (void)back {
    if ([self.navigationController isKindOfClass:[UIImagePickerController class]]) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];    
    }
}

- (void)finish {
    self.getAvatar([self imageWithZoomScale:self.scrollView.zoomScale]);
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 懒加载方法群
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        [self.scrollView addSubview:_imageView];
    }
    return _imageView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.delegate = self;
//        _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
        _scrollView.scrollEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
//        _scrollView.contentOffset = CGPointMake(_imageSize.width/2, _imageSize.height/2);
        [self.contentView addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _contentView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:self.contentView];
    }
    return _contentView;
}

- (UIBarButtonItem *)backButton {
    if (!_backButton) {
        _backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
    return _backButton;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.75];
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}

- (UIButton *)finishButton {
    if (!_finishButton) {
        _finishButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_finishButton setTitle:@"确定" forState:UIControlStateNormal];
        [_finishButton setBackgroundColor:[UIColor backGroundColor]];
        [_finishButton setTintColor:[UIColor textWhiteColor2]];
        [_finishButton addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
        [_finishButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        _finishButton.layer.cornerRadius = 2.0;
        _finishButton.layer.masksToBounds = YES;
        [self.bottomView addSubview:_finishButton];
    }
    return _finishButton;
}

- (CAShapeLayer *)borderLayer {
    if (!_borderLayer) {
        _borderLayer = [CAShapeLayer layer];
        CGMutablePathRef borderPath = CGPathCreateMutable();
        [_borderLayer setFillColor:[UIColor clearColor].CGColor];
        [_borderLayer setStrokeColor:[UIColor whiteColor].CGColor];
        _borderLayer.lineWidth = 1.0;
        CGPathAddRoundedRect(borderPath, NULL, CGRectMake(WIDTH/2-LENGTH/2, HEIGHT/2-LENGTH/2-32, LENGTH, LENGTH), LENGTH/2, LENGTH/2);
        [_borderLayer setPath:borderPath];
        CGPathRelease(borderPath);
    }
    return _borderLayer;
}

- (CAShapeLayer *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
        [_maskLayer setFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        [_maskLayer setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5].CGColor];
        CGMutablePathRef maskPath = CGPathCreateMutable();
        CGPathAddRoundedRect(maskPath, NULL, CGRectMake(WIDTH/2-148, HEIGHT/2-148-32, 296, 296), 148, 148);
        [_maskLayer setPath:maskPath];
        CGPathRelease(maskPath);
    }
    return _maskLayer;
}
#pragma mark UIScrollView协议
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    self.scrollView.contentSize = CGSizeMake(_imageSize.width*self.scrollView.zoomScale+WIDTH-LENGTH, _imageSize.height*self.scrollView.zoomScale+HEIGHT-LENGTH-64);
}
#pragma mark 图片缩放拖动相关
- (void)imageConfiguration {
    self.imageView.frame = CGRectMake(WIDTH/2-LENGTH/2, HEIGHT/2-LENGTH/2-32, _imageSize.width, _imageSize.height);
    CGFloat zoomScale =[self zoomScaleWithSize:_imageSize];
    CGFloat minimumZoomScale = [self minimumZoomScaleWithSize:_imageSize];
    CGFloat maximumZoomScale = (minimumZoomScale <= MAX_ZOOMSCALE) ? MAX_ZOOMSCALE : minimumZoomScale;
    self.scrollView.minimumZoomScale = minimumZoomScale;
    self.scrollView.maximumZoomScale = maximumZoomScale;
    self.scrollView.zoomScale = zoomScale;
    self.scrollView.contentSize = CGSizeMake(_imageSize.width*zoomScale+WIDTH-LENGTH, _imageSize.height*zoomScale+HEIGHT-LENGTH-64);
    self.scrollView.contentOffset = CGPointMake(WIDTH/2-LENGTH/2, HEIGHT/2-LENGTH/2-32);
}

- (CGFloat)zoomScaleWithSize:(CGSize)size {
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGFloat scale = (CGFloat)width/height;
    CGFloat screenScale = (CGFloat)WIDTH/HEIGHT;
    if (scale > screenScale) {
        if ((CGFloat)WIDTH/width*height>LENGTH) {
            return ((CGFloat)WIDTH / width);
        } else {
            return (LENGTH/height);
        }
    } else {
        if ((CGFloat)HEIGHT/height*width>LENGTH) {
            return ((CGFloat)HEIGHT/height);
        } else {
            return (LENGTH/width);
        }
    }
}

- (CGFloat)minimumZoomScaleWithSize:(CGSize)size {
    CGFloat width = size.width;
    CGFloat height = size.height;
    if ((LENGTH / height)>(LENGTH / width)) {
        return (LENGTH / height);
    } else {
        return (LENGTH / width);
    }
}
#pragma mark 图片截取
- (UIImage *)imageWithZoomScale:(CGFloat)zoomScale {
    UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, zoomScale);
    [self.imageView drawViewHierarchyInRect:self.imageView.bounds afterScreenUpdates:YES];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGRect imageRect = CGRectMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y, LENGTH, LENGTH);
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef targetImageRef = CGImageCreateWithImageInRect(sourceImageRef, imageRect);
    return [UIImage imageWithCGImage:targetImageRef];
}
@end
