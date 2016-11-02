//
//  GRARegisterThirdViewController.m
//  Gravity
//
//  Created by 陈志浩 on 16/6/8.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRARegisterThirdViewController.h"
#import "ColorMacro.h"
#import "Masonry.h"

#import "GRAAddAvatarHeaderView.h"
#import "GRAAvatarPickerController.h"
#import "GRAAvatarEditerController.h"
#import "GRARegisterSectionHeaderView.h"

#import "GRARegisterBasicInformationCell.h"

#import "MBSwitch.h"

typedef NS_ENUM(NSInteger, Gender) {
    Man,
    Woman,
};
@interface GRARegisterThirdViewController()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    NSMutableDictionary * _signupParameters;
    NSArray * _items;
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) GRAAddAvatarHeaderView * headerView;
@property (nonatomic, strong) UIBarButtonItem * nextButton;
@property (nonatomic, strong) UIBarButtonItem * backButton;

@property (nonatomic, strong) UITextField * nicknameText;
@property (nonatomic, strong) UIButton * manButton;
@property (nonatomic, strong) UIButton * womanButton;
@property (nonatomic, strong) UILabel * shieldingLabel;
@property (nonatomic, strong) MBSwitch * shieldingSwitch;
@property (nonatomic, strong) UILabel * ageLabel;
@property (nonatomic, strong) UILabel * classLabel;
@property (nonatomic, strong) UILabel * hometownLabel;
@property (nonatomic, strong) UITextField * contactText;

@property (nonatomic) Gender gender;

@property (nonatomic, strong) UIAlertController * alertController;
@property (nonatomic, strong) UINavigationController * avatarNavigationController;
@end

@implementation GRARegisterThirdViewController
static NSString * basicInformationIdentifier = @"basic";
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
    [self tableView];
    [self addNavigationItems];
    [self defaultConfiguration];
    _items = @[@"昵称", @"性别", @"年龄", @"班级", @"屏蔽同班同学", @"家乡", @"联系方式"];
}
#pragma maek 默认配置
- (void)defaultConfiguration {
    self.gender = Woman;
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
#pragma mark UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    GRARegisterSectionHeaderView * sectionHeaderView = [[GRARegisterSectionHeaderView alloc]initWithSectionTitle:@"基本资料"];
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GRARegisterBasicInformationCell * cell = [tableView dequeueReusableCellWithIdentifier:basicInformationIdentifier];
    if (indexPath.row != 0) cell.hasSeparator = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor transparentWhiteColor];
    cell.titleLabel.text = _items[indexPath.row];
    CGFloat bottom = -15;
    switch (indexPath.row) {
        case 0:
        {
            [cell.contentView addSubview:self.nicknameText];
            [self.nicknameText mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).with.offset(151);
                make.right.equalTo(cell.contentView.mas_right).with.offset(-22);
                make.centerY.equalTo(cell.titleLabel.mas_centerY);
                make.height.mas_equalTo(@26);
            }];
        }
            break;
        case 1:
        {
            [cell.contentView addSubview:self.womanButton];
            [cell.contentView addSubview:self.manButton];
            [self.womanButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.contentView.mas_top).with.offset(11);
                make.left.equalTo(cell.contentView.mas_left).with.offset(151);
                make.height.mas_equalTo(@22);
                make.width.mas_equalTo(@38);
            }];
            [self.manButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.womanButton.mas_top);
                make.left.equalTo(self.womanButton.mas_right).with.offset(5);
                make.height.equalTo(self.womanButton.mas_height);
                make.width.equalTo(self.womanButton.mas_width);
            }];
        }
            break;
        case 2:
        {
            [cell.contentView addSubview:self.ageLabel];
            [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.titleLabel.mas_centerY);
                make.height.mas_equalTo(@26);
                make.left.equalTo(cell.contentView.mas_left).with.offset(151);
            }];
        }
            break;
        case 3:
        {
            [cell.contentView addSubview:self.classLabel];
            [self.classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.titleLabel.mas_centerY);
                make.height.mas_equalTo(@26);
                make.left.equalTo(cell.contentView.mas_left).with.offset(151);
            }];
        }
            break;
        case 4:
        {
            [cell.contentView addSubview:self.shieldingSwitch];
            [cell.contentView addSubview:self.shieldingLabel];
            [self.shieldingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.shieldingSwitch.mas_bottom).with.offset(15);
                make.right.equalTo(cell.contentView.mas_right).with.offset(-22);
                make.bottom.equalTo(cell.contentView.mas_bottom).with.offset(-7);
            }];
            bottom = -37;
        }
            break;
        case 5:
        {
            [cell.contentView addSubview:self.hometownLabel];
            [self.hometownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.titleLabel.mas_centerY);
                make.height.mas_equalTo(@26);
                make.left.equalTo(cell.contentView.mas_left).with.offset(151);
            }];
        }
            break;
        case 6:
        {
            [cell.contentView addSubview:self.contactText];
            [self.contactText mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).with.offset(151);
                make.right.equalTo(cell.contentView.mas_right).with.offset(-22);
                make.centerY.equalTo(cell.titleLabel.mas_centerY);
                make.height.mas_equalTo(@26);
            }];
        }
            break;
    }
    [cell.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cell.contentView).with.offset(bottom);
    }];
    return cell;
}
#pragma mark UITextField代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
#pragma mark 交互相关
- (void)resignAllControls {
    [self.nicknameText resignFirstResponder];
    [self.contactText resignFirstResponder];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextStep {
    [_signupParameters setObject:self.nicknameText.text forKey:@"nickname"];
    [_signupParameters setObject:self.contactText.text forKey:@"contact"];
    if (self.shieldingSwitch.on) {
        [_signupParameters setObject:@"true" forKey:@"block_same_class"];
    } else {
        [_signupParameters setObject:@"false" forKey:@"block_same_class"];
    }
    if (self.gender == Man)
        [_signupParameters setObject:@"male" forKey:@"gender"];
    else
        [_signupParameters setObject:@"female" forKey:@"gender"];
#warning Functions haven't completed
    [_signupParameters setObject:@"csee 1501" forKey:@"clazz"];
    [_signupParameters setObject:@"859910400" forKey:@"birthday"];
    [_signupParameters setObject:@"wuhan" forKey:@"hometown"];
    GRARegisterFourthViewController * register4 = [[GRARegisterFourthViewController alloc]initWithSignupParameters:_signupParameters andAvatar:self.headerView.avatar];
    [self.navigationController showViewController:register4 sender:self];
}
#pragma mark 性别按钮相关
- (void)setMan {
    self.gender = Man;
}

- (void)setWoman {
    self.gender = Woman;
}

- (void)setGender:(Gender)gender {
    _gender = gender;
    if (_gender == Man) {
        _womanButton.backgroundColor = [UIColor defaultButtonColor];
        _manButton.backgroundColor = [UIColor textGreenColor];
    } else {
        _manButton.backgroundColor = [UIColor defaultButtonColor];
        _womanButton.backgroundColor = [UIColor backgroundRedColor];
    }
    NSLog(@"%ld", (long)_gender);
}
#pragma mark 懒加载方法群

//@property (nonatomic, strong) UIImagePickerController * avatarPickerController;
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor backGroundColor];
        _tableView.estimatedRowHeight = 40.0;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[GRARegisterBasicInformationCell class] forCellReuseIdentifier:basicInformationIdentifier];
        _tableView.tableHeaderView = self.headerView;
        [self.view addSubview:_tableView];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignAllControls)];
        tap.cancelsTouchesInView = NO;
        [_tableView addGestureRecognizer:tap];
    }
    return _tableView;
}

- (GRAAddAvatarHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[GRAAddAvatarHeaderView alloc]init];
        [_headerView setBounds:CGRectMake(0, 0, _tableView.bounds.size.width, 130)];
        _headerView.userInteractionEnabled = YES;
        [_headerView addTarget:self action:@selector(showAlertController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerView;
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

- (UITextField *)nicknameText {
    if (!_nicknameText) {
        _nicknameText = [[UITextField alloc]init];
        _nicknameText.delegate = self;
        _nicknameText.textColor = [UIColor textWhiteColor2];
        _nicknameText.textAlignment = NSTextAlignmentLeft;
        _nicknameText.tintColor = [UIColor textWhiteColor2];
        _nicknameText.font = [UIFont systemFontOfSize:13.0];
        _nicknameText.returnKeyType = UIReturnKeyDone;
        [_nicknameText setAttributedPlaceholder:[[NSAttributedString alloc]initWithString:@"不少于10个字符" attributes:@{NSForegroundColorAttributeName: [UIColor textWhiteColor], NSFontAttributeName: [UIFont systemFontOfSize: 13.0]}]];
    }
    return _nicknameText;
}

- (UIButton *)manButton {
    if (!_manButton) {
        _manButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _manButton.backgroundColor = [UIColor defaultButtonColor];
        _manButton.layer.cornerRadius = 2.5;
        _manButton.layer.masksToBounds = YES;
        _manButton.tintColor = [UIColor textWhiteColor2];
        [_manButton setAttributedTitle:[[NSAttributedString alloc]initWithString:@"男" attributes:@{NSForegroundColorAttributeName: [UIColor textWhiteColor2], NSFontAttributeName: [UIFont systemFontOfSize:13.0]}] forState:UIControlStateNormal];
        [_manButton addTarget:self action:@selector(setMan) forControlEvents:UIControlEventTouchUpInside];
    }
    return _manButton;
}

- (UIButton *)womanButton {
    if (!_womanButton) {
        _womanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _womanButton.backgroundColor = [UIColor backgroundRedColor];
        _womanButton.layer.cornerRadius = 2.5;
        _womanButton.layer.masksToBounds = YES;
        _womanButton.tintColor = [UIColor textWhiteColor2];
        [_womanButton setAttributedTitle:[[NSAttributedString alloc]initWithString:@"女" attributes:@{NSForegroundColorAttributeName: [UIColor textWhiteColor2], NSFontAttributeName: [UIFont systemFontOfSize:13.0]}] forState:UIControlStateNormal];
        [_womanButton addTarget:self action:@selector(setWoman) forControlEvents:UIControlEventTouchUpInside];
    }
    return _womanButton;
}

- (UILabel *)shieldingLabel {
    if (!_shieldingLabel) {
        _shieldingLabel = [[UILabel alloc]init];
        _shieldingLabel.text = @"点击开启屏蔽，你不会看到跟同班同学的相遇记录";
        _shieldingLabel.textColor = [UIColor cellGrayColor];
        _shieldingLabel.font = [UIFont systemFontOfSize:10.0];
    }
    return _shieldingLabel;
}

- (MBSwitch *)shieldingSwitch {
    if (!_shieldingSwitch) {
        _shieldingSwitch = [[MBSwitch alloc]initWithFrame:CGRectMake(_tableView.bounds.size.width-62.5, 15, 42.5, 20)];
        _shieldingSwitch.offTintColor = [UIColor backGroundColor];
        _shieldingSwitch.onTintColor = [UIColor textGreenColor];
        _shieldingSwitch.thumbTintColor = [UIColor textWhiteColor2];
    }
    return _shieldingSwitch;
}

- (UILabel *)ageLabel {
    if (!_ageLabel) {
        _ageLabel = [[UILabel alloc]init];
        _ageLabel.textColor = [UIColor textWhiteColor2];
        _ageLabel.textAlignment = NSTextAlignmentLeft;
        _ageLabel.font = [UIFont systemFontOfSize:13.0];
        [_ageLabel setAttributedText:[[NSAttributedString alloc]initWithString:@"点击输入" attributes:@{NSForegroundColorAttributeName: [UIColor textWhiteColor], NSFontAttributeName: [UIFont systemFontOfSize: 13.0]}]];
    }
    return _ageLabel;
}

- (UILabel *)classLabel {
    if (!_classLabel) {
        _classLabel = [[UILabel alloc]init];
        _classLabel.textColor = [UIColor textWhiteColor2];
        _classLabel.textAlignment = NSTextAlignmentLeft;
        _classLabel.font = [UIFont systemFontOfSize:13.0];
        [_classLabel setAttributedText:[[NSAttributedString alloc]initWithString:@"点击输入" attributes:@{NSForegroundColorAttributeName: [UIColor textWhiteColor], NSFontAttributeName: [UIFont systemFontOfSize: 13.0]}]];
    }
    return _classLabel;
}

- (UILabel *)hometownLabel {
    if (!_hometownLabel) {
        _hometownLabel = [[UILabel alloc]init];
        _hometownLabel.textColor = [UIColor textWhiteColor2];
        _hometownLabel.textAlignment = NSTextAlignmentLeft;
        _hometownLabel.font = [UIFont systemFontOfSize:13.0];
        [_hometownLabel setAttributedText:[[NSAttributedString alloc]initWithString:@"点击输入" attributes:@{NSForegroundColorAttributeName: [UIColor textWhiteColor], NSFontAttributeName: [UIFont systemFontOfSize: 13.0]}]];
    }
    return _hometownLabel;
}

- (UITextField *)contactText {
    if  (!_contactText) {
        _contactText = [[UITextField alloc]init];
        _contactText.delegate = self;
        _contactText.textColor = [UIColor textWhiteColor2];
        _contactText.textAlignment = NSTextAlignmentLeft;
        _contactText.tintColor = [UIColor textWhiteColor2];
        _contactText.font = [UIFont systemFontOfSize:13.0];
        _contactText.returnKeyType = UIReturnKeyDone;
        [_contactText setAttributedPlaceholder:[[NSAttributedString alloc]initWithString:@"点击输入" attributes:@{NSForegroundColorAttributeName: [UIColor textWhiteColor], NSFontAttributeName: [UIFont systemFontOfSize: 13.0]}]];
    }
    return _contactText;
}

- (UIAlertController *)alertController {
    if (!_alertController) {
        _alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction * photo = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = NO;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.cameraDevice = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }];
        UIAlertAction * album = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            GRAAvatarPickerController * avatarPicker = [[GRAAvatarPickerController alloc]init];
            self.avatarNavigationController = [[UINavigationController alloc]initWithRootViewController:avatarPicker];
            [self.avatarNavigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
            [self.avatarNavigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
            avatarPicker.getImage = ^(UIImage * image) {
                GRAAvatarEditerController * editer = [[GRAAvatarEditerController alloc]initWithImage:image];
                editer.getAvatar = ^(UIImage * avatar) {
                    self.headerView.avatar = avatar;
                };
                [self.avatarNavigationController pushViewController:editer animated:YES];
            };
            [self presentViewController:self.avatarNavigationController animated:YES completion:nil];
        }];
        [_alertController addAction:cancel];
        [_alertController addAction:photo];
        [_alertController addAction:album];
    }
    return _alertController;
}
#pragma mark 头像相关
- (void)showAlertController {
    [self presentViewController:self.alertController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    GRAAvatarEditerController * editer = [[GRAAvatarEditerController alloc]initWithImage:info[UIImagePickerControllerOriginalImage]];
    editer.getAvatar = ^(UIImage * avatar) {
        self.headerView.avatar = avatar;
    };
//    self.avatarNavigationController = [[UINavigationController alloc]initWithRootViewController:editer];
//    [self.avatarNavigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [self.avatarNavigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    [picker pushViewController:editer animated:YES];
//    [self presentViewController:self.avatarNavigationController animated:YES completion:nil];
}
@end
