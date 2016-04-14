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
#define kCountBtnLength 26

static NSString *cellIdentifier = @"cellIdentifier";

@interface KZPhotoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
    KZGroupInfo *_groupInfo;
    NSMutableArray *_assetInfoArr;//存储所有读取的照片
    dispatch_queue_t _queue;
    NSMutableDictionary *_imageDic;
    UIButton *_sendBtn;
    UIButton *_countBtn;//选中照片的总数
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
        if (result) {
            KZAssetsInfo *assetsInfo = [[KZAssetsInfo alloc]initWithAsset:result];
            [_assetInfoArr addObject:assetsInfo];
        } else {
            //遍历完成，滚动到最底部
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_assetInfoArr.count - 1 inSection:0];
            [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
        }
        
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
    _sendBtn = sendBtn;
    [sendBtn setUserInteractionEnabled:NO];
    [sendBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [sendBtn setFrame:CGRectMake(screenWidth - 45, (bottomViewHeight - 25)/2, 40, 25)];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn.titleLabel setFont:kFont(15)];
    [sendBtn addTarget:self action:@selector(sendBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sendBtn];
    
    UIButton *countBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _countBtn = countBtn;
    [countBtn setFrame:CGRectMake(screenWidth - 70, (bottomViewHeight - kCountBtnLength)/2, kCountBtnLength, kCountBtnLength)];
    [countBtn.layer setCornerRadius:kCountBtnLength/2];
    countBtn.hidden = YES;
    [countBtn.titleLabel setFont:kFont(15)];
    [countBtn setImage:[UIImage imageNamed:@"kz_badge"] forState:UIControlStateNormal];
    countBtn.alpha = .8;
    [countBtn setUserInteractionEnabled:NO];
    [countBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -kCountBtnLength, 0, 0)];
    [bottomView addSubview:countBtn];
}
- (void)setCountBtnStatus:(int)count{
    if (count>0) {
        _countBtn.hidden = NO;
        [_countBtn setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
        [_sendBtn setUserInteractionEnabled:YES];
        [_sendBtn setTitleColor:kColor(26, 178, 10) forState:UIControlStateNormal];
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
        NSValue *value1 = [NSValue valueWithCGRect:CGRectMake(0, 0, kCountBtnLength * 0.2, kCountBtnLength * 0.2)];
        NSValue *value2 = [NSValue valueWithCGRect:CGRectMake(0, 0, kCountBtnLength * 1.1, kCountBtnLength * 1.1)];
        NSValue *value3 = [NSValue valueWithCGRect:CGRectMake(0, 0, kCountBtnLength, kCountBtnLength)];
        animation.values = @[value1,value2,value3];
        [_countBtn.imageView.layer addAnimation:animation forKey:nil];
    } else {
        _countBtn.hidden = YES;
        [_sendBtn setUserInteractionEnabled:NO];
        [_sendBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}
- (void)leftItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancelBtnClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendBtnClicked{
    NSLog(@"ff");
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
    if (!_imageDic) {
        _imageDic = [NSMutableDictionary dictionary];
    }
    if (!_queue) {
        _queue = dispatch_queue_create("test", NULL);
    }
    dispatch_async(_queue, ^{
        KZAssetsInfo *assetsInfo = _assetInfoArr[indexPath.item];
        UIImage *image = [UIImage imageWithCGImage:[assetsInfo.asset defaultRepresentation].fullScreenImage];
        [_imageDic setObject:image forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.item]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setCountBtnStatus:(int)_imageDic.count];
        });
    });
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    dispatch_async(_queue, ^{
        [_imageDic removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.item]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setCountBtnStatus:(int)_imageDic.count];
        });
    });
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
