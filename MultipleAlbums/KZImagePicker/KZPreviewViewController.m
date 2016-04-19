//
//  KZPreviewViewController.m
//  MultipleAlbums
//
//  Created by 张坤 on 16/4/19.
//  Copyright © 2016年 KZ. All rights reserved.
//

#import "KZPreviewViewController.h"
#import "MacroDefinition.h"
@interface KZPreviewViewController ()<UIScrollViewDelegate>
{
    NSArray *_imagesArr;
    UIImageView *_imageView;
    UIScrollView *_scrollView;
    BOOL _onceTimeGesture;
}
@end

@implementation KZPreviewViewController
- (id)initWithImagesArray:(NSArray *)imagesArr{
    if (self) {
        _imagesArr = imagesArr;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    // Do any additional setup after loading the view.
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -64, screenWidth, screenHeight)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i<_imagesArr.count; i++) {
        UIImage *image = _imagesArr[i];
        CGFloat imageH = screenWidth * image.size.height / image.size.width;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(screenWidth * i, 0, screenWidth, imageH)];
        CGPoint point = self.view.center;
        point.x += screenWidth * i;
        imageView.center = point;
        [imageView setImage:image];
        [imageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClickedOneTime)];
        tapGesture.numberOfTouchesRequired = 1;//1个手指
        tapGesture.numberOfTapsRequired = 1;//点击一下
        [imageView addGestureRecognizer:tapGesture];
        [_scrollView addSubview:imageView];
    }
    _scrollView.contentSize = CGSizeMake(screenWidth * _imagesArr.count, screenHeight);
    _scrollView.contentOffset = CGPointMake(0, 0);
}
- (void)imageViewClickedOneTime{
    if (_onceTimeGesture) {
        [self.navigationController.navigationBar setHidden:NO];
    } else {
        [self.navigationController.navigationBar setHidden:YES];
    }
    _onceTimeGesture = !_onceTimeGesture;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
