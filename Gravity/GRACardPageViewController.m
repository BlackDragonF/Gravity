//
//  GRACardPageViewController.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/11.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRACardPageViewController.h"
#import "GRAOthersInformationViewController.h"

#import "GRACardPageHeaderView.h"
#import "GRACardPageSectionHeaderView.h"
#import "GRACardPageCell.h"
#import "GRACardPageTabbar.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRACardPageViewController()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate> {
    NSArray * _items;
    NSDictionary * _item;
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView * containerView;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIImageView * backView;
@property (nonatomic, strong) GRACardPageHeaderView * headerView;
@property (nonatomic, strong) GRACardPageSectionHeaderView * sectionHeaderView;
@property (nonatomic, strong) GRACardPageTabbar * tabbar;
@end

@implementation GRACardPageViewController
static NSString * cardPageIdentifier = @"cardpage";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self defaultConfiguration];
    [self basicConfiguration];
    [self addConstrains];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
#pragma mark 默认配置
- (void)defaultConfiguration {
    _items = @[
               @{@"time":@"17:30", @"title":@"你们相遇在西一食堂", @"subtitle":@"TA喜欢吃这里的牛肉拉面"},
               @{@"time":@"7:30", @"title":@"你们相遇在东九楼", @"subtitle":@"TA喜欢在二楼A214自习"},
               @{@"time":@"17:30", @"title":@"你们相遇在西一食堂", @"subtitle":@"TA喜欢吃这里的牛肉拉面"},
               @{@"time":@"17:30", @"title":@"你们相遇在东九楼", @"subtitle":@"TA喜欢在二楼A214自习"}
               ];
}
#pragma mark 基本配置
- (void)basicConfiguration {
    [self.view setBackgroundColor:[UIColor backGroundColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
#pragma mark UI配置
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)addConstrains {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(40, 0, 0, 0));
    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.scrollView.mas_bottom);
        make.top.equalTo(self.tableView.mas_bottom).with.offset(-127.5);
        make.height.mas_equalTo(@250);
        make.left.equalTo(self.scrollView.mas_left);
        make.width.mas_equalTo(@375);
    }];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_top);
        make.left.equalTo(self.backView.mas_left).with.offset(20);
        make.right.equalTo(self.backView.mas_right).with.offset(-20);
        make.height.mas_equalTo([NSNumber numberWithDouble:300+81*_items.count]);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView);
    }];
    [self.tabbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(@80);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}
#pragma mark UITableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.sectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GRACardPageCell * cell = [tableView dequeueReusableCellWithIdentifier:cardPageIdentifier];
    _item = _items[indexPath.row];
    cell.time = _item[@"time"];
    cell.title = [[NSAttributedString alloc]initWithString:_item[@"title"]];
    cell.subtitle = [[NSAttributedString alloc]initWithString:_item[@"subtitle"]];
    if (indexPath.row == 0) {
        cell.position = GRACardPageCellFirst;
    } else if (indexPath.row == _items.count - 1) {
        cell.position = GRACardPageCellLast;
    } else {
        cell.position = GRACardPageCellDefault;
    }
    return cell;
}
#pragma mark 交互相关
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)more {
    GRAOthersInformationViewController * othersInfo = [[GRAOthersInformationViewController alloc]init];
    [self.navigationController pushViewController:othersInfo animated:YES];
}
#pragma mark 懒加载方法群
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 335, 400) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.tableHeaderView = self.headerView;
        _tableView.rowHeight = 81.0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.allowsSelection = NO;
        _tableView.layer.cornerRadius = 3.0;
        _tableView.layer.masksToBounds = YES;
        [_tableView setBackgroundColor:[UIColor textWhiteColor2]];
        [_tableView registerClass:[GRACardPageCell class] forCellReuseIdentifier:cardPageIdentifier];
        [self.containerView addSubview:_tableView];
    }
    return _tableView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc]init];
        _containerView.layer.masksToBounds = NO;
        _containerView.layer.shadowColor = [UIColor blackColor].CGColor;
        _containerView.layer.shadowOffset = CGSizeMake(3, 3);
        _containerView.layer.shadowOpacity = 0.4;
        _containerView.layer.shadowRadius = 3.0;
        [self.scrollView addSubview:_containerView];
    }
    return _containerView;
}

- (GRACardPageHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[GRACardPageHeaderView alloc]initWithDate:@"May.1st" Avatar:[UIImage imageNamed:@"man"] Nickname:@"NICKNAME" Gender:Man andLocation:@"华中科技大学东校区"];
        _headerView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 220);
    }
    return _headerView;
}

- (GRACardPageSectionHeaderView *)sectionHeaderView {
    if (!_sectionHeaderView) {
        _sectionHeaderView = [[GRACardPageSectionHeaderView alloc]init];
        _sectionHeaderView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80.0);
        _sectionHeaderView.lucky = 65;
        _sectionHeaderView.meeting = 23;
        _sectionHeaderView.meters = 5;
    }
    return _sectionHeaderView;
}

- (UIImageView *)backView {
    if (!_backView) {
        _backView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cardpageBackground"]];
        [self.scrollView addSubview:_backView];
    }
    return _backView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
//        self.tableView.frame = CGRectMake(0, 0, _scrollView.bounds.size.width, self.tableView.contentSize.height);
    }
    return _scrollView;
}

- (GRACardPageTabbar *)tabbar {
    if (!_tabbar) {
        _tabbar = [[GRACardPageTabbar alloc]init];
        [_tabbar.backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [_tabbar.moreButton addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_tabbar];
    }
    return _tabbar;
}
@end
