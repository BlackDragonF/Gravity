//
//  GRANotificationPageViewController.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/9.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRANotificationPageViewController.h"
#import "GRASystemWingmanViewController.h"

#import "GRANotificationPageCell.h"

#import "ColorMacro.h"

@interface GRANotificationPageViewController()<UITableViewDelegate, UITableViewDataSource> {
    NSArray * _items;
    NSDictionary * _item;
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIBarButtonItem * backButton;
@end

@implementation GRANotificationPageViewController
static NSString * notificationPageIdentifier = @"notificationPage";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicConfiguration];
    [self addNavigationItems];
    [self defaultConfiguration];
    [self tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
}
#pragma mark 默认配置
#warning Image to be replaced
- (void)defaultConfiguration {
    _items = @[
               @{@"icon": [UIImage imageNamed:@"more"],@"title": @"对我心动",@"subtitle": @"查看最近对我心动的人"},
               @{@"icon": [UIImage imageNamed:@"more"],@"title": @"豪掷千金",@"subtitle": @"查看最近查看我联系方式的人"},
               @{@"icon": [UIImage imageNamed:@"more"],@"title": @"系统僚机",@"subtitle": @"恭喜您进行兴趣点填写，完整度达80%"},
               ];
}
#pragma mark 基本配置
- (void)basicConfiguration {
    [self.view setBackgroundColor:[UIColor backGroundColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor backGroundColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor textWhiteColor2]];
    [self setTitle:@"通知"];
}
#pragma mark UI配置
- (void)addNavigationItems {
    UIBarButtonItem * negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -4.0;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, self.backButton];
}
#pragma mark 交互相关
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark UITableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GRANotificationPageCell * cell = [tableView dequeueReusableCellWithIdentifier:notificationPageIdentifier];
    _item = _items[indexPath.row];
    cell.icon = _item[@"icon"];
    cell.title = _item[@"title"];
    cell.subtitle = _item[@"subtitle"];
//    if (indexPath.row < (_items.count - 1)){
    cell.separator = YES;
//    } else {
//        cell.separator = NO;
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        GRASystemWingmanViewController * systemWingman = [[GRASystemWingmanViewController alloc]init];
        [self.navigationController pushViewController:systemWingman animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark 懒加载方法群
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setBackgroundColor:[UIColor backGroundColor]];
        [_tableView registerClass:[GRANotificationPageCell class]forCellReuseIdentifier:notificationPageIdentifier];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UIBarButtonItem *)backButton {
    if (!_backButton) {
        UIButton * backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [backButton setTitle:@"首页" forState:UIControlStateNormal];
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
