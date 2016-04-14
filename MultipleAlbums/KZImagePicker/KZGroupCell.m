//
//  KZGroupCell.m
//  MultipleAlbums
//
//  Created by 张坤 on 16/4/13.
//  Copyright © 2016年 KZ. All rights reserved.
//

#import "KZGroupCell.h"
#import "MacroDefinition.h"

@interface KZGroupCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewW;

@end

@implementation KZGroupCell

- (void)awakeFromNib {
    // Initialization code
    _imageViewW.constant = groupCellHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setContentView:(KZGroupInfo *)groupInfo{
    _imageV.image = groupInfo.image;
    [_title setText:groupInfo.title];
    [_count setText:groupInfo.count];

}
@end
