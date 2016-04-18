//
//  KZImagePickerController.m
//  MultipleAlbums
//
//  Created by 张坤 on 16/4/13.
//  Copyright © 2016年 KZ. All rights reserved.
//

#import "KZImagePickerController.h"
#import "KZAlbumViewController.h"
#import "KZPhotoViewController.h"
@interface KZImagePickerController ()<KZPhotoViewControllerDelegate>

@end

@implementation KZImagePickerController

+ (id)imagePicker{
    KZAlbumViewController *albumVC = [[KZAlbumViewController alloc]init];
    return [[self alloc]initWithRootViewController:albumVC];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-KZPhotoViewControllerDelegate
- (void)KZPhotoViewControllerSendBtnClicked:(NSArray *)imageArr{
    if (self.kDelegate && [self.kDelegate respondsToSelector:@selector(KZImagePickerControllerDidFinishWithImageArr:)]) {
        [self.kDelegate KZImagePickerControllerDidFinishWithImageArr:imageArr];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
