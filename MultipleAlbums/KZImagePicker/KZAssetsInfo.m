//
//  KZAssetsInfo.m
//  MultipleAlbums
//
//  Created by 张坤 on 16/4/14.
//  Copyright © 2016年 KZ. All rights reserved.
//

#import "KZAssetsInfo.h"

@implementation KZAssetsInfo

- (id)initWithAsset:(ALAsset *)asset{
    if (self) {
        _thumbNailImage = [UIImage imageWithCGImage:asset.thumbnail];
        _asset = asset;
    }
    return self;
}

@end
