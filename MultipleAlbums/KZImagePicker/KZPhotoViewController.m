//
//  KZPhotoViewController.m
//  MultipleAlbums
//
//  Created by 张坤 on 16/4/13.
//  Copyright © 2016年 KZ. All rights reserved.
//

#import "KZPhotoViewController.h"
#import "MacroDefinition.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "KZGroupInfo.h"
#import "KZAssetsInfo.h"

#define bottomViewHeight 40

static NSString *cellIdentifier = @"cellIdentifier";

@interface KZPhotoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    KZGroupInfo *_groupInfo;
    NSMutableArray *_assetInfoArr;//存储所有读取的照片
}
@end

@implementation KZPhotoViewController

- (id)initWithGroupInfo:(KZGroupInfo *)groupInfo{
    if (self) {
        _groupInfo = groupInfo;
        self.title = groupInfo.title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self addCollectionView];
    [self loadAssetsGroup];
    [self addBottomView];
}

- (void)setNavigationBar{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnClicked)];
    [rightItem setTitleTextAttributes:@{NSFontAttributeName:kFont(15),NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)addCollectionView{
    CGRect frame = self.view.bounds;
    frame.size.height -= (64+bottomViewHeight);
    _collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:[UICollectionViewFlowLayout new]];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    [_collectionView setAllowsMultipleSelection:YES];
    [self.view addSubview:_collectionView];
    _assetInfoArr = [NSMutableArray arrayWithCapacity:20];
}

- (void)loadAssetsGroup{
    ALAssetsGroup *group = _groupInfo.group;
    [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        KZAssetsInfo *assetsInfo = [[KZAssetsInfo alloc]initWithAsset:result];
        [_assetInfoArr addObject:assetsInfo];
    }];
}
- (void)addBottomView{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, screenHeight - bottomViewHeight - 64, screenWidth, bottomViewHeight)];
    [bottomView setBackgroundColor:kColor(242, 242, 242)];
    [self.view addSubview:bottomView];
    
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, .4)];
    [topLine setBackgroundColor:[UIColor lightGrayColor]];
    [bottomView addSubview:topLine];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn setFrame:CGRectMake(screenWidth - 45, (bottomViewHeight - 25)/2, 40, 25)];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:kColor(26, 178, 10) forState:UIControlStateNormal];
    [sendBtn.titleLabel setFont:kFont(15)];
    [bottomView addSubview:sendBtn];
    
    UIButton *chooseNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseNumBtn setFrame:CGRectMake(screenWidth - 70, (bottomViewHeight - 20)/2, 20, 20)];
    [chooseNumBtn setBackgroundImage:[UIImage imageNamed:@"kz_badge"] forState:UIControlStateNormal];
    chooseNumBtn.alpha = .8;
    [chooseNumBtn setUserInteractionEnabled:NO];
    [bottomView addSubview:chooseNumBtn];
}
- (void)leftItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelBtnClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _assetInfoArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    KZAssetsInfo *assetsInfo = _assetInfoArr[indexPath.item];
    cell.backgroundView = [[UIImageView alloc]initWithImage:assetsInfo.thumbNailImage];
    cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kz_overlay"]];
    return cell;
}
#pragma mark-UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
}
#pragma mark-UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellLength = (screenWidth - 5 * kMargin)/4;
    return CGSizeMake(cellLength, cellLength);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin);
}
//列与列之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return kMargin;
}
//行与行之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return kMargin;
}

@end
