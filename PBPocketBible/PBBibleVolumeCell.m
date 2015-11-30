//
//  PBBibleVolumeCell.m
//  PBPocketBible
//
//  Created by LAL on 15/11/29.
//  Copyright © 2015年 LAL. All rights reserved.
//

#import "PBBibleVolumeCell.h"

@implementation PBBibleVolumeCell

-(void)awakeFromNib{
    self.numberLabel.font = [UIFont fontWithName:@"Avenir Next" size:12];
    self.numberLabel.textColor = [UIColor whiteColor];
    self.snameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
    self.snameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    self.nameLabel.textColor = [UIColor whiteColor];
}

@end
