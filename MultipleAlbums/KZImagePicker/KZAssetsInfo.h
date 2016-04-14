//
//  KZAssetsInfo.h
//  MultipleAlbums
//
//  Created by 张坤 on 16/4/14.
//  Copyright © 2016年 KZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface KZAssetsInfo : NSObject

@property (nonatomic, strong) UIImage *thumbNailImage;//缩略图

@property (nonatomic, strong) ALAsset *asset;

- (id)initWithAsset:(ALAsset *)asset;

@end
