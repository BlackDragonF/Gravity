//
//  HomepageViewController.m
//  Gravity
//
//  Created by 陈志浩 on 16/4/12.
//  Copyright © 2016年 UniqueStudio. All rights reserved.
//

#import "GRAHomepageViewController.h"
#import "GRABasicInformationViewController.h"
#import "GRASignatureViewController.h"
#import "GRAGeneralSettingsViewController.h"
#import "GRAInviteFriendsViewController.h"

#import "GRAHomePageCell.h"
#import "GRAHomePageHeaderView.h"

#import "ColorMacro.h"

#define WIDTH   ([UIScreen mainScreen].bounds.size.width)
#define HEIGHT  ([UIScreen mainScreen].bounds.size.height)
#define mainColor colorWithRed:54.0f/255.0f green:58.0f/255.0f blue:101.0f/255.0f alpha:1

@interface GRAHomePageViewController () <UITableViewDataSource, UITableViewDelegate>{
    NSArray * _items;
    NSDictionary * _item;//数据源
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) GRAHomePageHeaderView * headerView;

@property (nonatomic, strong) UIBarButtonItem * backButton;
@property (nonatomic, strong) UIBarButtonItem * moreButton;
@end

@implementation GRAHomePageViewController
static NSString * homepageIdentifier = @"homepage";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicConfiguration];
    [self tableView];
    [self addNavigationItems];
    [self defaultConfiguration];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor lightGreenColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor textWhiteColor2]];
    self.navigationController.navigationBar.layer.shadowColor = [UIColor clearColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark 基本配置
- (void)basicConfiguration {
    [self.view setBackgroundColor:[UIColor backGroundColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self setTitle:@"我的主页"];
}
#pragma mark 默认配置
- (void)defaultConfiguration {
    _items = @[
               @[@{@"icon": [UIImage imageNamed:@"signature"],@"title": @"个人签名",@"subtitle": @"心中无事，意中有人...",@"arrowed": @YES,@"highlightedSubtitle": @YES},
                 @{@"icon": [UIImage imageNamed:@"interest"],@"title": @"我的兴趣",@"subtitle": @"完成度：80％",@"arrowed": @YES,@"highlightedSubtitle": @NO},
                 @{@"icon": [UIImage imageNamed:@"invisible"],@"title": @"隐身术",@"subtitle": @"",@"arrowed": @YES,@"highlightedSubtitle": @NO},
                 @{@"icon": [UIImage imageNamed:@"energystone"],@"title": @"能量石",@"subtitle": @"100块",@"arrowed": @YES,@"highlightedSubtitle": @YES}],
               @[@{@"icon": [UIImage imageNamed:@"verification"],@"title": @"校区认证",@"subtitle": @"已认证",@"arrowed": @YES,@"highlightedSubtitle": @NO},
                 @{@"icon": [UIImage imageNamed:@"generalsetting"],@"title": @"通用设置",@"subtitle": @"",@"arrowed": @YES,@"highlightedSubtitle": @NO},
                 @{@"icon": [UIImage imageNamed:@"invitingfriends"],@"title": @"邀请好友",@"subtitle": @"获得能量石奖励",@"arrowed": @NO,@"highlightedSubtitle": @NO}],
               //               @[@{@"icon": [UIImage imageNamed:@"logout"],@"title": @"登出", @"subtitle": @"",@"arrow": @NO,@"highlightedSubtitle": @NO}]
               ];
}
#pragma mark UI配置
- (void)addNavigationItems {
    UIBarButtonItem * negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -4.0;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, self.backButton];
    UIBarButtonItem * negativeSpacer2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer2.width = 4.0;
    self.navigationItem.rightBarButtonItems = @[self.moreButton, negativeSpacer2];
}
#pragma mark UITableView协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray *)(_items[section])).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GRAHomePageCell * cell = [tableView dequeueReusableCellWithIdentifier:homepageIdentifier forIndexPath:indexPath];
    _item = _items[indexPath.section][indexPath.row];
    cell.icon = _item[@"icon"];
    cell.title = _item[@"title"];
    cell.subtitle = _item[@"subtitle"];
    cell.arrowed = [_item[@"arrowed"] boolValue];
    cell.highlightedSubtitle = [_item[@"highlightedSubtitle"] boolValue];
    if (indexPath.row < ([(NSArray *)_items[indexPath.section] count] - 1)){
        cell.separator = YES;
    } else {
        cell.separator = NO;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return 0;
    } else {
        return 20.0f;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                {
                    GRASignatureViewController * signature = [[GRASignatureViewController alloc]init];
                    [self.navigationController pushViewController:signature animated:YES];
                }
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 1:
                {
                    GRAGeneralSettingsViewController * generalSettings = [[GRAGeneralSettingsViewController alloc]init];
                    [self.navigationController pushViewController:generalSettings animated:YES];
                }
                    break;
                case 2:
                {
                    GRAInviteFriendsViewController * inviteFriends = [[GRAInviteFriendsViewController alloc]init];
                    [self.navigationController pushViewController:inviteFriends animated:YES];
                }
                    break;
            }
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark 交互相关
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)more {
    
}

- (void)basicInformation {
    GRABasicInformationViewController * basicInformation = [[GRABasicInformationViewController alloc]init];
    [self.navigationController pushViewController:basicInformation animated:YES];
}
#pragma mark 懒加载方法群
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

- (UIBarButtonItem *)moreButton {
    if (!_moreButton) {
        _moreButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"more"] style:UIBarButtonItemStylePlain target:self action:@selector(more)];
    }
    return _moreButton;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        [_tableView setBackgroundColor:[UIColor backGroundColor]];
        [_tableView registerClass:[GRAHomePageCell class] forCellReuseIdentifier:homepageIdentifier];
        _tableView.tableHeaderView = self.headerView;
        _tableView.sectionHeaderHeight = 0.0f;
        _tableView.sectionFooterHeight = 0.0f;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (GRAHomePageHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[GRAHomePageHeaderView alloc]init];
        [_headerView setBounds:CGRectMake(0, 0, WIDTH, 237.5f)];
        [_headerView addTargetToButton:self action:@selector(basicInformation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerView;
}
@end
