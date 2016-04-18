//
//  KZImagePickerController.h
//  MultipleAlbums
//
//  Created by 张坤 on 16/4/13.
//  Copyright © 2016年 KZ. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^chooseImage)(NSArray *);

@protocol KZImagePickerControllerDelegate <NSObject>

- (void)KZImagePickerControllerDidFinishWithImageArr:(NSArray *)imageArr;

@end

@interface KZImagePickerController : UINavigationController

//@property (nonatomic, copy) chooseImage block;

@property (nonatomic, assign) id kDelegate;

+ (id)imagePicker;

@end
