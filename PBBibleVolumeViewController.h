//
//  PBBibleVolumeViewController.h
//  PBPocketBible
//
//  Created by LAL on 15/11/29.
//  Copyright © 2015年 LAL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Ono.h>
@interface PBBibleVolumeViewController : UICollectionViewController
@property (nonatomic, strong) NSArray *chapters;
@property (nonatomic, strong) NSDictionary *volume;
@property (nonatomic, strong) ONOXMLDocument *bible;
@end
