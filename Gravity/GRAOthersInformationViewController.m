//
//  GRAOthersInformationViewController.m
//  Gravity
//
//  Created by 陈志浩 on 16/7/13.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAOthersInformationViewController.h"

#import "GRAOthersInterestsCell.h"
#import "GRAOthersWantToTalkCell.h"
#import "GRAOthersBasicInformationCell.h"
#import "GRAOthersInformationHeaderView.h"
#import "GRAOthersInformationSectionHeaderView.h"

#import "Masonry.h"
#import "ColorMacro.h"

@interface GRAOthersInformationViewController()<UITableViewDelegate, UITableViewDataSource>{
    NSArray * _headerItems;
    NSDictionary * _headerItem;
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) GRAOthersInformationHeaderView * headerView;


@property (nonatomic, strong) NSArray * presetInterestsList;//个人兴趣模板
@property (nonatomic, strong) NSArray * presetInterestsTable;//个人兴趣表(用来确定替换信息)
@property (nonatomic, strong) NSDictionary * userInterests;//从网络返回的用户兴趣

@property (nonatomic, strong) UIBarButtonItem * backButton;
@property (nonatomic, strong) UIBarButtonItem * moreButton;
@end

@implementation GRAOthersInformationViewController
static NSString * basicInformationIdentifier = @"basicInformation";
static NSString * wantToTalkIdentifier = @"wantToTalk";
static NSString * personalInterestsIdentifier = @"personalInterests";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicConfiguration];
    [self defaultConfiguration];
    [self addNavigationItems];
    [self tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.layer.shadowColor = [UIColor clearColor].CGColor;
}
#pragma mark 默认配置
- (void)defaultConfiguration {
    _headerItems = @[
                     @{@"icon": [UIImage imageNamed:@"more"], @"title": @"基本资料"},
                     @{@"icon": [UIImage imageNamed:@"more"], @"title": @"想对你说"},
                     @{@"icon": [UIImage imageNamed:@"more"], @"title": @"个人兴趣"}
                     ];
    _userInterests = @{
                       @"0": @"西一食堂",
                       @"1": @"大盘鸡",
                       @"2": @"东操",
                       @"3": @"微积分",
                       @"4": @"加缪",
                       @"5": @"《火锅英雄》",
                       @"6": @"张国荣"
                       };
}
#pragma mark 基本配置
- (void)basicConfiguration {
    [self.view setBackgroundColor:[UIColor textGreenColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor lightGreenColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor textWhiteColor2]];
    [self setTitle:@"Gravity"];
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
#pragma mark UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _headerItem = [_headerItems objectAtIndex:section];
    GRAOthersInformationSectionHeaderView * sectionHeaderView = [[GRAOthersInformationSectionHeaderView alloc]initWithIcon:_headerItem[@"icon"] andTitle:_headerItem[@"title"]];
    [sectionHeaderView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35)];
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return 35.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 11.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0)
    {
        GRAOthersBasicInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:basicInformationIdentifier];
        cell.userInteractionEnabled = NO;
        cell.age = @"19岁";
        cell.constellation = @"双子";
        cell.major = @"14传播";
        cell.prefer = @"寻找恋人";
        cell.hometown = @"广东釜山";
        cell.state = @"单身";
        return cell;
    } else if (indexPath.section == 1) {
        GRAOthersWantToTalkCell * cell = [tableView dequeueReusableCellWithIdentifier:wantToTalkIdentifier];
        cell.userInteractionEnabled = NO;
        cell.content = @"心中无事，意中有人，你若安好，便是晴天\n你若安好，便是晴天，心中无事，意中有人";
        return cell;
    } else {
        GRAOthersInterestsCell * cell = [tableView dequeueReusableCellWithIdentifier:personalInterestsIdentifier];
        cell.userInteractionEnabled = NO;
        //        [self presetInterestsList];
        //        [self presetInterestsTable];
        NSArray * tagArray = [_userInterests allKeys];
        NSMutableArray * interestsMutableArray = [[NSMutableArray alloc]initWithObjects:@"Hey~偶遇的陌生人！遇见你真幸运。\n", nil];
        for (NSString * key in tagArray){
            NSInteger index = [key integerValue];
            NSInteger line = [self.presetInterestsTable[index] integerValue];
            if (!([interestsMutableArray containsObject:self.presetInterestsList[line]])){
                [interestsMutableArray addObject:self.presetInterestsList[line]];
            }
        }//先得出所有要用的字符串
        NSMutableString * interestsMutableString = [[NSMutableString alloc]init];
        for (NSString * interest in interestsMutableArray){
            [interestsMutableString appendString:interest];
        }//再将其合成为一个总的字符串
        NSString * interestsString = [NSString stringWithString:interestsMutableString];
        __block NSMutableAttributedString * attributedContent = [[NSMutableAttributedString alloc]initWithString:interestsString];//创建可变属性字符串
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineSpacing = 12.0f;
        NSDictionary * contentNormalAttributes = @{NSForegroundColorAttributeName: [UIColor textWhiteColor2], NSFontAttributeName: [UIFont systemFontOfSize:13.0f],NSParagraphStyleAttributeName: paragraphStyle};//配置基本的间距和大小
        [attributedContent addAttributes:contentNormalAttributes range:NSMakeRange(0, attributedContent.mutableString.length)];
        [_userInterests enumerateKeysAndObjectsUsingBlock:^(NSString * tag, NSString * interest, BOOL * stop) {
            NSDictionary * contentHighlightedAttributes = @{NSForegroundColorAttributeName: [UIColor backgroundRedColor], NSFontAttributeName: [UIFont systemFontOfSize:13.0f],NSParagraphStyleAttributeName: paragraphStyle};//配置高亮样式
            NSRange tagRange = [attributedContent.mutableString rangeOfString:tag];
            NSAttributedString * interestAttributedString = [[NSAttributedString alloc]initWithString:interest attributes:contentHighlightedAttributes];
            [attributedContent replaceCharactersInRange:tagRange withAttributedString:interestAttributedString];
        }];
        cell.attributedContent = attributedContent;
        return cell;
    }
}
#pragma mark 交互相关
- (void)back {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)more {
    
}
#pragma mark 懒加载方法群
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor backGroundColor];
        _tableView.estimatedRowHeight = 60.0f;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[GRAOthersBasicInformationCell class] forCellReuseIdentifier:basicInformationIdentifier];
        [_tableView registerClass:[GRAOthersWantToTalkCell class] forCellReuseIdentifier:wantToTalkIdentifier];
        [_tableView registerClass:[GRAOthersInterestsCell class] forCellReuseIdentifier:personalInterestsIdentifier];
        _tableView.tableHeaderView = self.headerView;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (GRAOthersInformationHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[GRAOthersInformationHeaderView alloc]initWithAvatar:[UIImage imageNamed:@"man"] NickName:@"NICKNAME" Gender:Man Location:@"华中科技大学东校区" andContact:@"1464461278@qq.com"];
        [_headerView setBounds:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 230)];
    }
    return _headerView;
}

- (NSArray *)presetInterestsList{
    if (!_presetInterestsList){
        _presetInterestsList = @[
                                 @"我最喜欢在0吃1\n",
                                 @"闲暇的时候我会去2跑步\n",
                                 @"我擅长3，你擅长什么呢？我们可以互相帮助\n",
                                 @"如果可以一起看4的书，聊聊人生发发呆多好呀～\n",
                                 @"我最近看了5超好看，你有看过嘛？\n",
                                 @"我最喜欢的歌手是6，你呢？\n"
                                 ];
    }
    return _presetInterestsList;
}

- (NSArray *)presetInterestsTable{
    if (!_presetInterestsTable){
        _presetInterestsTable = @[@"0", @"0", @"1", @"2", @"3", @"4", @"5"];
    }
    return _presetInterestsTable;
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

- (UIBarButtonItem *)moreButton {
    if (!_moreButton) {
        _moreButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"more"] style:UIBarButtonItemStylePlain target:self action:@selector(more)];
    }
    return _moreButton;
}
@end
