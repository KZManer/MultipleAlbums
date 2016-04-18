//
//  KZPhotoViewController.h
//  MultipleAlbums
//
//  Created by 张坤 on 16/4/13.
//  Copyright © 2016年 KZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "KZGroupInfo.h"

//typedef void(^chooseImage)(NSArray *);

@protocol KZPhotoViewControllerDelegate <NSObject>

- (void)KZPhotoViewControllerSendBtnClicked:(NSArray *)imageArr;

@end

@interface KZPhotoViewController : UIViewController

//@property (nonatomic, copy) chooseImage block;

@property (nonatomic, assign) id delegate;

- (id)initWithGroupInfo:(KZGroupInfo *)groupInfo;

@end
