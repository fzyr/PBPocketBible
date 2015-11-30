//
//  PBBibleSectionCell.m
//  PBPocketBible
//
//  Created by LAL on 15/11/30.
//  Copyright © 2015年 LAL. All rights reserved.
//

#import "PBBibleSectionCell.h"

@implementation PBBibleSectionCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
