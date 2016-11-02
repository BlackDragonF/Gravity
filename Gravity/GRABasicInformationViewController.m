//
//  GRABasicInformationViewController.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/7.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRABasicInformationViewController.h"

#import "GRAHomePageSectionHeaderView.h"
#import "GRABasicInformationCell.h"

#import "ColorMacro.h"

@interface GRABasicInformationViewController ()<UITableViewDelegate, UITableViewDataSource> {
    NSArray * _items;
    NSDictionary * _item;
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIBarButtonItem * backButton;
@property (nonatomic, strong) UIBarButtonItem * saveButton;
@end

@implementation GRABasicInformationViewController
static NSString * basicInformationIdentifier = @"basicInformaion";
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
               @{
                   @"name":@"基本资料",
                   @"content":@[@{@"title":@"昵称", @"type":@"text"}, @{@"title":@"年龄", @"type":@"picker"}, @{@"title":@"年级", @"type":@"picker"}, @{@"title":@"专业", @"type":@"picker"}, @{@"title":@"家乡", @"type":@"picker"}, @{@"title":@"邮箱", @"type":@"text"}],
                   },
               @{
                   @"name":@"感情状况",
                   @"content":@[@{@"title":@"当前状态", @"type":@"picker"}, @{@"title":@"我在寻找", @"type":@"picker"}],
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
    [self setTitle:@"基本资料"];
}
#pragma mark UI配置
- (void)addNavigationItems {
    UIBarButtonItem * negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -4.0;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, self.backButton];
    UIBarButtonItem * negativeSpacer2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer2.width = 4.0;
    self.navigationItem.rightBarButtonItems = @[self.saveButton, negativeSpacer2];
}
#pragma mark 交互相关
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)save {
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 5.0;
            break;
        case 1:
            return 0;
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 39.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    GRAHomePageSectionHeaderView * sectionHeaderView = [[GRAHomePageSectionHeaderView alloc]initWithTitle:_items[section][@"name"] Frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 39) andPadding:UIEdgeInsetsMake(15, 15, 12, 0)];
    return sectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GRABasicInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:basicInformationIdentifier];
    if (indexPath.row < ([(NSArray *)_items[indexPath.section][@"content"]count] - 1)){
        cell.separator = YES;
    } else {
        cell.separator = NO;
    }
    cell.title = _items[indexPath.section][@"content"][indexPath.row][@"title"];
    if ([_items[indexPath.section][@"content"][indexPath.row][@"type"] isEqualToString:@"text"]) {
        cell.interactionType = GRAInteractionTextType;
    } else {
        cell.interactionType = GRAInteractionPickerType;
    }
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    cell.content = @"柳柳";
                    break;
                case 1:
                    cell.content = @"19岁 双子";
                    break;
                case 2:
                    cell.content = @"2014级";
                    break;
                case 3:
                    cell.content = @"传播学";
                    break;
                case 4:
                    cell.content = @"广东 佛山";
                    break;
                case 5:
                    cell.content = @"2225483093@qq.com";
                break;
            }
            break;
        }
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                    cell.content = @"单身";
                    break;
                case 1:
                    cell.content = @"恋人";
                    break;
            }
            break;
        }
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
        [_tableView registerClass:[GRABasicInformationCell class] forCellReuseIdentifier:basicInformationIdentifier];
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

- (UIBarButtonItem *)saveButton {
    if (!_saveButton) {
        _saveButton = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    }
    return _saveButton;
}
@end
