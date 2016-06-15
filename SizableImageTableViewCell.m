//
//  SizableImageTableViewCell.m
//  CoinBaseTest
//
//  Created by Fu Juo Wen on 2016/6/15.
//  Copyright © 2016年 test. All rights reserved.
//

#import "SizableImageTableViewCell.h"

@implementation SizableImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, 100, 100);
}

@end
