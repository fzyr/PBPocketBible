//
//  PBBibleChapterViewController.h
//  PBPocketBible
//
//  Created by LAL on 15/11/30.
//  Copyright © 2015年 LAL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Ono.h>
@interface PBBibleChapterViewController : UITableViewController
@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) ONOXMLDocument *bible;
@property (nonatomic, strong) NSDictionary *chapter;
@end
