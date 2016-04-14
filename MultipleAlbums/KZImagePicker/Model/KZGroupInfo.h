//
//  KZGroupInfo.h
//  MultipleAlbums
//
//  Created by 张坤 on 16/4/13.
//  Copyright © 2016年 KZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface KZGroupInfo : NSObject

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *count;

@property (nonatomic, strong) ALAssetsGroup *group;


- (id)initWithGroup:(ALAssetsGroup *)group;

+ (id)groupInitWithGroup:(ALAssetsGroup *)group;

@end
