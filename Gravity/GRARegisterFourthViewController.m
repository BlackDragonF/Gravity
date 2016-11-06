//
//  GRARegisterFourthViewController.m
//  Gravity
//
//  Created by 陈志浩 on 16/6/9.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRARegisterFourthViewController.h"
#import "ColorMacro.h"
#import "Masonry.h"
#import "SVProgressHUD.h"

#import "GRARegisterSectionHeaderView.h"
#import "GRARegisterRestCell.h"

#import "GRANetworkingManager.h"
#import "GRALocationManager.h"

#import "GRAMainPageViewController.h"

@interface GRARegisterFourthViewController()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    NSMutableDictionary * _signupParameters;
    NSArray * _items, * _lifeItems, * _stateItems;
    UIImage * _avatar;
}
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) UITextField * signatureText;
@property (nonatomic, strong) UILabel * stateLabel;
@property (nonatomic, strong) UILabel * preferLabel;

@property (nonatomic, strong) UIBarButtonItem * backButton;
@property (nonatomic, strong) UIBarButtonItem * finishButton;
@end

@implementation GRARegisterFourthViewController
static NSString * signupURL = @"/backend/api/user/signup";
static NSString * restIdentifier = @"rest";
#pragma mark 初始化
- (instancetype)initWithSignupParameters:(NSMutableDictionary *)signupParameters andAvatar:(UIImage *)avatar {
    if (self = [super init]){
        _signupParameters = signupParameters;
        _avatar = avatar;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", _signupParameters);
    _items = @[@"个性签名", @"校园生活", @"感情状况"];
    _lifeItems = @[@"我经常去的食堂", @"我经常自习的地点", @"我经常运动的地点"];
    _stateItems = @[@"感情状况", @"我在寻找"];
    [self basicConfiguration];
    [self tableView];
    [self addNavigationItems];
}

- (void)configureNavitionController:(UINavigationController *)navigation {
    [navigation.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [navigation.navigationBar setShadowImage:[[UIImage alloc]init]];
    CALayer * layer = navigation.navigationBar.layer;
    layer.masksToBounds = NO;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(0, 2.5);
    layer.shadowOpacity = 0.1;
    layer.shouldRasterize = YES;
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
    self.navigationItem.rightBarButtonItems = @[self.finishButton, negativeSpacer2];
}
#pragma mark UITableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 2;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 55.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    GRARegisterSectionHeaderView * sectionHeaderView = [[GRARegisterSectionHeaderView alloc]initWithSectionTitle:_items[section]];
    sectionHeaderView.isFourthViewController = YES;
    return sectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GRARegisterRestCell * cell = [tableView dequeueReusableCellWithIdentifier:restIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor transparentWhiteColor];
    if (indexPath.row != 0)
        cell.hasSeparator = YES;
    if (indexPath.section == 0) {
        [cell.contentView addSubview:self.signatureText];
        [self.signatureText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.height.mas_equalTo(@26);
            make.left.equalTo(cell.contentView.mas_left).with.offset(20);
            make.right.equalTo(cell.contentView.mas_right).with.offset(-20);
        }];
    }
    if (indexPath.section == 1) {
        cell.titleLabel.text = _lifeItems[indexPath.row];
        cell.arrowed = YES;
    }
    if (indexPath.section == 2) {
        cell.titleLabel.text = _stateItems[indexPath.row];
        if (indexPath.row == 0) {
            [cell.contentView addSubview:self.stateLabel];
            [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.titleLabel.mas_centerY);
                make.height.mas_equalTo(@26);
                make.left.equalTo(cell.titleLabel.mas_right).with.offset(81);
            }];
        }
        if (indexPath.row == 1) {
            [cell.contentView addSubview:self.preferLabel];
            [self.preferLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.titleLabel.mas_centerY);
                make.height.mas_equalTo(@26);
                make.left.equalTo(cell.titleLabel.mas_right).with.offset(81);
            }];
        }
    }
    return cell;
}
#pragma mark UITextField代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark 交互相关
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)signup {
    [_signupParameters setObject:self.signatureText.text forKey:@"introduction"];
    [_signupParameters setObject:@"single" forKey:@"love_status"];
    [_signupParameters setObject:@"both" forKey:@"prefer_gender"];
    [_signupParameters setObject:[NSNumber numberWithDouble: [NSDate date].timeIntervalSince1970] forKey:@"timestamp"];
    [[GRANetworkingManager sharedManager]requestWithApplendixURL:signupURL andParameters:_signupParameters completionHandler:^(NSDictionary * responseJSON) {
        if([responseJSON[@"error"] isEqualToString:@"ok"]){
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"login"];
            NSDictionary * user = responseJSON[@"data"][@"user"];
            [[NSUserDefaults standardUserDefaults] setInteger:[user[@"id"] integerValue] forKey:@"id"];
            [SVProgressHUD setMinimumDismissTimeInterval:0.5];
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            
            GRAMainPageViewController * main = [[GRAMainPageViewController alloc]init];
            UINavigationController * navigation = [[UINavigationController alloc]initWithRootViewController:main];
            [self configureNavitionController:navigation];
            [[GRALocationManager sharedManager]setLocationMode:GRALocationForegroundMode];
            dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, 0.55 * NSEC_PER_SEC);
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_after(delay, mainQueue, ^(void){
                [self presentViewController:navigation animated:YES completion:^{
                    
                }];
            });
        }
    }];
}

- (void)resignAllControls {
    [self.signatureText resignFirstResponder];
}
#pragma mark 懒加载方法群
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor backGroundColor];
        _tableView.rowHeight = 44.0;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        [_tableView registerClass:[GRARegisterRestCell class] forCellReuseIdentifier:restIdentifier];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignAllControls)];
        tap.cancelsTouchesInView = NO;
        [_tableView addGestureRecognizer:tap];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UITextField *)signatureText {
    if (!_signatureText) {
        _signatureText = [[UITextField alloc]init];
        _signatureText.delegate = self;
        _signatureText.textColor = [UIColor textWhiteColor2];
        _signatureText.textAlignment = NSTextAlignmentLeft;
        _signatureText.font = [UIFont systemFontOfSize:13.0];
        _signatureText.tintColor = [UIColor textWhiteColor2];
        _signatureText.returnKeyType = UIReturnKeyDone;
        [_signatureText setAttributedPlaceholder:[[NSAttributedString alloc]initWithString:@"你在这想遇见什么？" attributes:@{NSForegroundColorAttributeName: [UIColor textWhiteColor], NSFontAttributeName: [UIFont systemFontOfSize: 13.0]}]];
    }
    return _signatureText;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.textColor = [UIColor textWhiteColor2];
        _stateLabel.textAlignment = NSTextAlignmentLeft;
        _stateLabel.font = [UIFont systemFontOfSize:13.0];
        [_stateLabel setAttributedText:[[NSAttributedString alloc]initWithString:@"点击输入" attributes:@{NSForegroundColorAttributeName: [UIColor textWhiteColor], NSFontAttributeName: [UIFont systemFontOfSize: 13.0]}]];
    }
    return _stateLabel;
}

- (UILabel *)preferLabel {
    if (!_preferLabel) {
        _preferLabel = [[UILabel alloc]init];
        _preferLabel.textColor = [UIColor textWhiteColor2];
        _preferLabel.textAlignment = NSTextAlignmentLeft;
        _preferLabel.font = [UIFont systemFontOfSize:13.0];
        [_preferLabel setAttributedText:[[NSAttributedString alloc]initWithString:@"点击输入" attributes:@{NSForegroundColorAttributeName: [UIColor textWhiteColor], NSFontAttributeName: [UIFont systemFontOfSize: 13.0]}]];
    }
    return _preferLabel;
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

- (UIBarButtonItem *)finishButton {
    if (!_finishButton) {
        _finishButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(signup)];
    }
    return _finishButton;
}
@end
