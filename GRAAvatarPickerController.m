//
//  GRAAvatarPickerController.m
//  AvatarPicker
//
//  Created by 陈志浩 on 16/7/4.
//  Copyright © 2016年 陈志浩. All rights reserved.
//

#import "GRAAvatarPickerController.h"
#import <Photos/Photos.h>

#import "GRAPhotoCell.h"

#import "ColorMacro.h"
#import "Masonry.h"

@interface GRAAvatarPickerController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    CGFloat _photoWidth;
    UICollectionViewFlowLayout * _layout;
}
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) UILabel * countLabel;
@property (nonatomic, strong) UIBarButtonItem * cancelButton;

@property (nonatomic, strong) PHFetchResult * fetchResults;
@end

@implementation GRAAvatarPickerController
static NSString * cellIdentifier = @"photo";
-(instancetype)init {
    if (self = [super init]) {
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        _fetchResults = [PHAsset fetchAssetsWithOptions:options];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicConfiguration];
    [self addConstraints];
    [self addNavigationItems];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor backGroundColor]];
}
#pragma mark 基本配置
- (void)basicConfiguration {
    self.view.backgroundColor = [UIColor textWhiteColor2];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor textWhiteColor2]];
    [self setTitle:@"选择头像"];
    _photoWidth = ([UIScreen mainScreen].bounds.size.width - 3 * 4.0) / 4.0;
}
#pragma mark UI配置
- (void)addNavigationItems {
    UIBarButtonItem * negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = 4.0;
    self.navigationItem.rightBarButtonItems = @[self.cancelButton, negativeSpacer];
}

- (void)addConstraints {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.countLabel.mas_top).with.offset(-10.5);
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10.5);
        make.height.mas_equalTo(@15);
    }];
}
#pragma mark 懒加载方法群
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.minimumLineSpacing = 4.0;
        _layout.minimumInteritemSpacing = 4.0;
        _layout.itemSize = CGSizeMake(_photoWidth, _photoWidth);
        _layout.sectionInset = UIEdgeInsetsMake(4, 0, 0, 0);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:_layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[GRAPhotoCell class] forCellWithReuseIdentifier:cellIdentifier];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.text = [NSString stringWithFormat:@"共%ld张照片", _fetchResults.count];
        _countLabel.textColor = [UIColor grayColor];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = [UIFont systemFontOfSize:15.0];
        [self.view addSubview:_countLabel];
    }
    return _countLabel;
}

- (UIBarButtonItem *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    }
    return _cancelButton;
}
#pragma mark 交互相关
- (void)cancel {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark UICollectionView协议
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _fetchResults.count;
}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(_photoWidth, _photoWidth);
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 3.9;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *) collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 3.9;
//}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(4, 0, 0, 0);
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GRAPhotoCell * __block cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.length = _photoWidth;
    PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
    requestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
    [[PHImageManager defaultManager]requestImageForAsset:_fetchResults[indexPath.row] targetSize:CGSizeMake(_photoWidth * 2, _photoWidth * 2) contentMode:PHImageContentModeDefault options:requestOptions resultHandler:^(UIImage * result, NSDictionary * info) {
        cell.photo = result;
    }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PHImageRequestOptions *phImageRequestOptions = [[PHImageRequestOptions alloc] init];
    phImageRequestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
    [[PHImageManager defaultManager]requestImageForAsset:_fetchResults[indexPath.row] targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:phImageRequestOptions resultHandler:^(UIImage * result, NSDictionary * info) {
        self.getImage(result);
    }];
}
@end
