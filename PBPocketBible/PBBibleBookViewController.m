//
//  PBBibleBookViewController.m
//  PBPocketBible
//
//  Created by LAL on 15/11/29.
//  Copyright © 2015年 LAL. All rights reserved.
//

#import "PBBibleBookViewController.h"
#import <Ono.h>
#import "AppDelegate.h"
#import "PBBibleVolumeCell.h"
#import "PBBibleVolumeViewController.h"

#define VOLUMEKEYNUMBER @"volumeKeyNumber"  //卷：第几卷
#define VOLUMEKEYCOLOR @"volumeKeyColor"    //卷：颜色
#define VOLUMEKEYNAME @"volumeKeyName"      //卷：名字
#define VOLUMEKEYSNAME @"volumeKeySName"    //卷：短名字
#define VOLUMEKEYTITLE @"volumeKeyTitle"    //卷：题目
#define VOLUMEKEYELEMENT @"volumeKeyElement"//卷：xml中的对应元素

@interface PBBibleBookViewController ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray *volumes;
@property (nonatomic, strong) ONOXMLDocument *bible;
@end

@implementation PBBibleBookViewController

static NSString * const reuseIdentifier = @"VolumeCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"圣经";
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - properties setter & getter

-(ONOXMLDocument *)bible{
    if(!_bible){
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _bible = appDelegate.bible;
    }
    return _bible;
}

-(NSArray *)volumes{
    
    if(!_volumes){
        NSMutableArray *tempVolumes = [NSMutableArray array];
        for(ONOXMLElement *element in self.bible.rootElement.children){
            NSString *name = element.attributes[@"name"];
            NSString *sName = element.attributes[@"sname"];
            NSString *number = element.attributes[@"value"];
            NSString *title = element.attributes[@"title"];
            NSDictionary *volume = @{VOLUMEKEYNUMBER:number,
                                     VOLUMEKEYNAME:name,
                                     VOLUMEKEYSNAME:sName,
                                     VOLUMEKEYTITLE:title,
                                     VOLUMEKEYELEMENT:element,
                                     };
            [tempVolumes addObject:volume];
        }
        _volumes = [NSArray arrayWithArray:tempVolumes];
    }
    return _volumes;
}



-(void)printVolumes{
    for(NSDictionary *volume in self.volumes){
        NSLog(@"volumeNo: %@; title: %@; name: %@; sname: %@",volume[VOLUMEKEYNUMBER],volume[VOLUMEKEYTITLE], volume[VOLUMEKEYNAME],volume[VOLUMEKEYSNAME]);
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"SegueToVolume"]){
        PBBibleVolumeViewController *vvc = (PBBibleVolumeViewController *)segue.destinationViewController;
        vvc.bible = self.bible;
        NSIndexPath *selectedIP = self.collectionView.indexPathsForSelectedItems[0];
        vvc.volume = self.volumes[selectedIP.row];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.volumes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PBBibleVolumeCell *cell = (PBBibleVolumeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSDictionary *volume = self.volumes[indexPath.row];
    cell.numberLabel.text = volume[VOLUMEKEYNUMBER];
    cell.nameLabel.text = volume[VOLUMEKEYNAME];
    cell.snameLabel.text = volume[VOLUMEKEYSNAME];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"SegueToVolume" sender:indexPath];
    
}

#pragma mark <>

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 30;
}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
