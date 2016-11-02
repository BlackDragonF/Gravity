//
//  GRAGeneralSettingsViewController.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/9.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAGeneralSettingsViewController.h"

#import "GRAHomePageSectionHeaderView.h"
#import "GRAGeneralSettingsCell.h"

#import "ColorMacro.h"

@interface GRAGeneralSettingsViewController()<UITableViewDelegate, UITableViewDataSource>{
    NSArray * _items;
    NSDictionary * _item;
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIBarButtonItem * backButton;
@end


@implementation GRAGeneralSettingsViewController
static NSString * generalSettingsIdentifier = @"generalSettings";

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
               @{
                   @"name":@"Gravity 1.0",
                   @"content":@[@{@"title":@"新手指引", @"image":[UIImage imageNamed:@"more"]}, @{@"title":@"给我们评价", @"image":[UIImage imageNamed:@"more"]}, @{@"title":@"意见反馈", @"image":[UIImage imageNamed:@"more"]}]
                   },
               @{
                   @"name":@"关于我们",
                   @"content":@[@{@"title":@"用户协议", @"image":[UIImage imageNamed:@"more"]}, @{@"title":@"关于我们", @"image":[UIImage imageNamed:@"more"]}],
                   },
               ];
}
#pragma mark 基本配置
- (void)basicConfiguration {
    [self.view setBackgroundColor:[UIColor backGroundColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor backGroundColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor textWhiteColor2]];
    [self setTitle:@"通用设置"];
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
    return _items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_items[section][@"content"]count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 42.0;
            break;
        case 1:
            return 37.0;
            break;
        default:
            return 0;
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    GRAHomePageSectionHeaderView * sectionHeaderView;
    if (section == 0) {
        sectionHeaderView = [[GRAHomePageSectionHeaderView alloc]initWithTitle:_items[section][@"name"] Frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 42) andPadding:UIEdgeInsetsMake(20, 12, 10, 0)];
    } else {
        sectionHeaderView = [[GRAHomePageSectionHeaderView alloc]initWithTitle:_items[section][@"name"] Frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 37) andPadding:UIEdgeInsetsMake(15, 12, 10, 0)];
    }
    return sectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GRAGeneralSettingsCell * cell = [tableView dequeueReusableCellWithIdentifier:generalSettingsIdentifier];
    cell.title = _items[indexPath.section][@"content"][indexPath.row][@"title"];
    cell.icon = _items[indexPath.section][@"content"][indexPath.row][@"image"];
    if (indexPath.row < ([(NSArray *)_items[indexPath.section][@"content"]count] - 1)){
        cell.separator = YES;
    } else {
        cell.separator = NO;
    }
    return cell;
}
#pragma mark 懒加载方法群
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.sectionFooterHeight = 0;
        [_tableView registerClass:[GRAGeneralSettingsCell class] forCellReuseIdentifier:generalSettingsIdentifier];
        [_tableView setBackgroundColor:[UIColor backGroundColor]];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UIBarButtonItem *)backButton {
    if (!_backButton) {
        UIButton * backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
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
