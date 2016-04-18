//
//  ViewController.m
//  MultipleAlbums
//
//  Created by 张坤 on 16/4/13.
//  Copyright © 2016年 KZ. All rights reserved.
//

#import "ViewController.h"
#import "KZImagePickerController.h"
@interface ViewController ()<KZImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *choosePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [choosePhotoBtn setFrame:CGRectMake(0, 0, 100, 30)];
    choosePhotoBtn.center = self.view.center;
    [choosePhotoBtn setBackgroundColor:[UIColor lightGrayColor]];
    [choosePhotoBtn setTitle:@"选取照片" forState:UIControlStateNormal];
    [choosePhotoBtn addTarget:self action:@selector(choosePhotoBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choosePhotoBtn];
}
- (void)choosePhotoBtnClicked{
    KZImagePickerController *imagePicker = [KZImagePickerController imagePicker];
    imagePicker.kDelegate = self;
//    [imagePicker setBlock:^(NSArray *imageArr){
//        NSLog(@"%@",imageArr);
//    }];
    [self presentViewController:imagePicker animated:YES completion:nil];
}
#pragma mark-KZImagePickerControllerDelegate
- (void)KZImagePickerControllerDidFinishWithImageArr:(NSArray *)imageArr{
    NSLog(@"%@",imageArr);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
