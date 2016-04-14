//
//  KZGroupInfo.m
//  MultipleAlbums
//
//  Created by 张坤 on 16/4/13.
//  Copyright © 2016年 KZ. All rights reserved.
//

#import "KZGroupInfo.h"


@implementation KZGroupInfo

- (id)initWithGroup:(ALAssetsGroup *)group{
    if (self) {
        self.image = [UIImage imageWithCGImage:group.posterImage];
        self.title = [group valueForProperty:ALAssetsGroupPropertyName];
        self.count = [NSString stringWithFormat:@"%ld张照片",[group numberOfAssets]];
        self.group = group;
    }
    return self;
}

+ (id)groupInitWithGroup:(ALAssetsGroup *)group{
    return [[self alloc]initWithGroup:group];
}

@end
