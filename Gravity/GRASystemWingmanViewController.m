//
//  GRASystemWingmanViewController.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/9.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRASystemWingmanViewController.h"

#import "GRASystemWingmanSectionHeaderView.h"
#import "GRASystemWingmanCell.h"

#import "ColorMacro.h"

@interface GRASystemWingmanViewController()<UITableViewDelegate, UITableViewDataSource> {
    NSArray * _items;
    NSDictionary * _item;
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIBarButtonItem * backButton;
@end

@implementation GRASystemWingmanViewController
static NSString * systemWingmanIdentifier = @"systemWingman";
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
- (void)defaultConfiguration {
    _items = @[
               @{@"date": @"今天", @"time": @"23:55", @"content": @"连续登录7天成就Get～获得15块能量石奖励！"},
               @{@"date": @"5月19日", @"time": @"21:28", @"content": @"Hey～欢迎来到Gravity！\n每个人就像轨道上运转的一颗小星球\v总存在那么一个不经意的瞬间\v那颗星擦过你的轨道后，才有了最初的缘分定义\n咳咳，现在我们已经探测到你的星球信号啦～\v完善兴趣信息，撞见爱情的几率会更高噢！\v每晚10点为你推送今天与你最有缘分的TA，\v记得要来噢～"},
               @{@"date": @"今天", @"time": @"20:00", @"content": @"连续登录7天成就Get～获得15块能量石奖励！"},
               ];
}
#pragma mark 基本配置
- (void)basicConfiguration {
    [self.view setBackgroundColor:[UIColor backGroundColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor backGroundColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor textWhiteColor2]];
    [self setTitle:@"系统僚机"];
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 57.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    _item = _items[section];
    GRASystemWingmanSectionHeaderView * sectionHeaderView = [[GRASystemWingmanSectionHeaderView alloc]initWithDate:_item[@"date"] andTime:_item[@"time"]];
    sectionHeaderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 57.0);
    return sectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GRASystemWingmanCell * cell = [tableView dequeueReusableCellWithIdentifier:systemWingmanIdentifier];
    _item = _items[indexPath.section];
    cell.text = _item[@"content"];
    return cell;
}
#pragma mark 懒加载方法群
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionFooterHeight = CGFLOAT_MIN;
        _tableView.estimatedRowHeight = 80.0;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[GRASystemWingmanCell class] forCellReuseIdentifier:systemWingmanIdentifier];
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
