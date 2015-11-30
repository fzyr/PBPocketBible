//
//  PBBibleSubChapterCell.m
//  PBPocketBible
//
//  Created by LAL on 15/11/30.
//  Copyright © 2015年 LAL. All rights reserved.
//

#import "PBBibleSubChapterCell.h"

@implementation PBBibleSubChapterCell

- (void)awakeFromNib {
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont fontWithName:@"Avenir Next" size:20];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
