//
//  KZGroupCell.h
//  MultipleAlbums
//
//  Created by 张坤 on 16/4/13.
//  Copyright © 2016年 KZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KZGroupInfo.h"

@interface KZGroupCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *count;

- (void)setContentView:(KZGroupInfo *)groupInfo;

@end
