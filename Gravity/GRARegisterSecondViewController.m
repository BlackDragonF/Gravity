//
//  GRARegisterSecondViewController.m
//  Gravity
//
//  Created by 陈志浩 on 16/6/8.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRARegisterSecondViewController.h"
#import <MapKit/MapKit.h>
//#import <JZLocationConverter/JZLocationConverter.h>
#import "GRANetworkingManager.h"
#import "GRALocationManager.h"
#import "ColorMacro.h"
#import "Masonry.h"

typedef NS_ENUM(NSInteger, GRALocationVerificationResult) {
    GRALocationVerificationNone,
    GRALocationVerificationMain,
    GRALocationVerificationEast,
};

@interface GRARegisterSecondViewController()<MKMapViewDelegate> {
    NSMutableDictionary * _signupParameters;
    GRALocationVerificationResult _verificationResult;
    CGMutablePathRef _mainRegion, _eastRegion;
}
@property (nonatomic, strong) MKMapView * mapView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * resultLabel;
@property (nonatomic, strong) UIButton * changeButton;
@property (nonatomic, strong) UIBarButtonItem * nextButton;
@property (nonatomic, strong) UIBarButtonItem * backButton;
@end

@implementation GRARegisterSecondViewController
#pragma mark 初始化
- (instancetype)initWithSignupParameters:(NSMutableDictionary *)signupParameters {
    if (self = [super init]){
        _signupParameters = signupParameters;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", _signupParameters);
    [self basicConfiguration];
    [self createRegion];
    [self mapConfiguration];
    [self addConstraints];
    [self addNavigationItems];
}

- (void)dealloc {
    CGPathRelease(_mainRegion);
    CGPathRelease(_eastRegion);
}
#pragma mark UI配置
- (void)basicConfiguration{
    self.view.backgroundColor = [UIColor backGroundColor];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor backGroundColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor textWhiteColor2]];
    [self setTitle:@"注册"];
}

- (void)addNavigationItems {
    UIBarButtonItem * negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -4.0;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, self.backButton];
    UIBarButtonItem * negativeSpacer2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer2.width = 4.0;
    self.navigationItem.rightBarButtonItems = @[self.nextButton, negativeSpacer2];
}

- (void)addConstraints {
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(@490);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mapView.mas_bottom).with.offset(19);
        make.left.equalTo(self.view.mas_left).with.offset(95);
        make.height.mas_equalTo(@13);
    }];
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_top);
        make.right.equalTo(self.view.mas_right).with.offset(-95);
        make.height.equalTo(self.titleLabel.mas_height);
        make.left.equalTo(self.titleLabel.mas_right).with.offset(-1);
    }];
    [self.changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(18);
        make.height.mas_equalTo(@38);
        make.centerX.equalTo(self.view.mas_centerX);
        make.right.equalTo(self.view.mas_right).with.offset(-102);
    }];
}
#pragma mark MKMapView相关
- (void)createRegion {
    CGPoint mainNorthWest, mainSouthWest, mainNorthEast, mainSouthEast, eastNorthEast, eastSouthEast;
    mainNorthWest = CGPointMake(30.5212870000, 114.4023230000);
    mainSouthWest = CGPointMake(30.5067940000, 114.4025800000);
    mainNorthEast = CGPointMake(30.5186406322, 114.4243050519);
    mainSouthEast = CGPointMake(30.5069416377, 114.4243050519);
    eastNorthEast = CGPointMake(30.5178528130, 114.4380643376);
    eastSouthEast = CGPointMake(30.5057803563, 114.4380643376);
    _mainRegion = CGPathCreateMutable();
    CGPathMoveToPoint(_mainRegion, NULL, mainNorthWest.x, mainNorthWest.y);
    CGPathAddLineToPoint(_mainRegion, NULL, mainSouthWest.x, mainSouthWest.y);
    CGPathAddLineToPoint(_mainRegion, NULL, mainSouthEast.x, mainSouthEast.y);
    CGPathAddLineToPoint(_mainRegion, NULL, mainNorthEast.x, mainNorthEast.y);
    CGPathAddLineToPoint(_mainRegion, NULL, mainNorthWest.x, mainNorthWest.y);
    CGPathCloseSubpath(_mainRegion);
    _eastRegion = CGPathCreateMutable();
    CGPathMoveToPoint(_eastRegion, NULL, mainNorthEast.x, mainNorthEast.y);
    CGPathAddLineToPoint(_eastRegion, NULL, mainSouthEast.x, mainSouthEast.y);
    CGPathAddLineToPoint(_eastRegion, NULL, eastSouthEast.x, eastSouthEast.y);
    CGPathAddLineToPoint(_eastRegion, NULL, eastNorthEast.x, eastNorthEast.y);
    CGPathAddLineToPoint(_eastRegion, NULL, mainNorthEast.x, mainNorthEast.y);
    CGPathCloseSubpath(_eastRegion);
}

- (void)mapConfiguration {
    self.mapView.rotateEnabled = NO;
    self.mapView.delegate = self;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    _verificationResult = GRALocationVerificationNone;
    self.mapView.userLocation.title = @"认证中";
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
//    CLLocationCoordinate2D convertedCoordinate = [JZLocationConverter gcj02ToWgs84:userLocation.location.coordinate];
    CLLocationCoordinate2D convertedCoordinate = userLocation.location.coordinate;
    CLLocation * location = [[CLLocation alloc]initWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
    [[GRALocationManager sharedManager] calculateAreaNumber:location];
    [[GRALocationManager sharedManager] placemarkWithLocation:location andAreaNumber:[GRALocationManager sharedManager].area_num];
    [_signupParameters setObject:[NSNumber numberWithInteger: [GRALocationManager sharedManager].area_num] forKey:@"area_num"];
    [_signupParameters setObject:[GRALocationManager sharedManager].place forKey:@"location_name"];
    _verificationResult = [self verifyRegionWithCoordinate:convertedCoordinate];
    switch (_verificationResult) {
        case GRALocationVerificationNone:
            _mapView.userLocation.title = @"认证中";
            _resultLabel.text = @"认证中";
            break;
        case GRALocationVerificationEast:
            
            _mapView.userLocation.title = @"华中科技大学 东校区";
            _resultLabel.text = @"华中科技大学 东校区";
            break;
        case GRALocationVerificationMain:
            _mapView.userLocation.title = @"华中科技大学 主校区";
            _resultLabel.text = @"华中科技大学 主校区";
            break;
    }
}

- (GRALocationVerificationResult)verifyRegionWithCoordinate:(CLLocationCoordinate2D)coordinate {
    CGPoint currentCoordinate = CGPointMake(coordinate.latitude, coordinate.longitude);
    if (CGPathContainsPoint(_mainRegion, NULL, currentCoordinate, false))
        return GRALocationVerificationMain;
    else if (CGPathContainsPoint(_eastRegion, NULL, currentCoordinate, false))
        return GRALocationVerificationEast;
    else
        return GRALocationVerificationNone;
}
#pragma mark 交互相关
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextStep {
    if (_verificationResult == GRALocationVerificationNone) {
        NSLog(@"地理位置错误：不在主校区或者东校区！");
    } else {
        if (_verificationResult == GRALocationVerificationMain)
            [_signupParameters setObject:@"middle" forKey:@"region"];
        else if (_verificationResult == GRALocationVerificationEast)
            [_signupParameters setObject:@"east" forKey:@"region"];
        GRARegisterThirdViewController * register3 = [[GRARegisterThirdViewController alloc]initWithSignupParameters:_signupParameters];
        [self.navigationController showViewController:register3 sender:self];
    }
}
#pragma mark 懒加载方法群
- (MKMapView *) mapView {
    if (!_mapView) {
        _mapView = [[MKMapView alloc]init];
        [self.view addSubview:_mapView];
    }
    return _mapView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"认证结果：";
        _titleLabel.textColor = [UIColor textWhiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:13.0];
        [self.view addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)resultLabel {
    if (!_resultLabel) {
        _resultLabel = [[UILabel alloc]init];
        _resultLabel.text = @"认证中";
        _resultLabel.textColor = [UIColor textWhiteColor2];
        _resultLabel.textAlignment = NSTextAlignmentLeft;
        _resultLabel.font = [UIFont systemFontOfSize:13.0];
        [self.view addSubview:_resultLabel];
    }
    return _resultLabel;
}

- (UIButton *)changeButton {
    if (!_changeButton) {
        _changeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_changeButton setAttributedTitle:[[NSAttributedString alloc]initWithString:@"更改校区" attributes:@{NSForegroundColorAttributeName: [UIColor textWhiteColor2], NSFontAttributeName: [UIFont systemFontOfSize: 13.0]}] forState:UIControlStateNormal];
        _changeButton.layer.cornerRadius = 5.0;
        _changeButton.layer.masksToBounds = YES;
        _changeButton.backgroundColor = [UIColor backgroundRedColor];
        [self.view addSubview:_changeButton];
    }
    return _changeButton;
}

- (UIBarButtonItem *)nextButton {
    if (!_nextButton) {
        _nextButton = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(nextStep)];
    }
    return _nextButton;
}

- (UIBarButtonItem *)backButton {
    if (!_backButton) {
        UIButton * backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [backButton setTitle:@"上一步" forState:UIControlStateNormal];
        backButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0);
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        _backButton = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    }
    return _backButton;
}
@end
