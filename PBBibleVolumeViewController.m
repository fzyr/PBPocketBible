//
//  PBBibleVolumeViewController.m
//  PBPocketBible
//
//  Created by LAL on 15/11/29.
//  Copyright © 2015年 LAL. All rights reserved.
//

#import "PBBibleVolumeViewController.h"
#import "PBBibleChapterCell.h"
#import "PBBibleChapterViewController.h"

#define VOLUMEKEYNUMBER @"volumeKeyNumber"  //卷：第几卷
#define VOLUMEKEYCOLOR @"volumeKeyColor"    //卷：颜色
#define VOLUMEKEYNAME @"volumeKeyName"      //卷：名字
#define VOLUMEKEYSNAME @"volumeKeySName"    //卷：短名字
#define VOLUMEKEYTITLE @"volumeKeyTitle"    //卷：题目
#define VOLUMEKEYELEMENT @"volumeKeyElement"//卷：xml中的对应元素


#define CHAPTERTAG @"chapter"       //章:标签
#define CHAPTERKEYVALUE @"value"    //章：第几章
#define CHAPTERKEYTITLE @"title"    //章：题目
#define CHAPTERKEYELEMENT @"chapterKeyElement"

@interface PBBibleVolumeViewController ()

@end

@implementation PBBibleVolumeViewController

static NSString * const reuseIdentifier = @"ChapterCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self printChapters];
    NSString *VolumeTitle = [NSString stringWithFormat:@"第%@章: %@",self.volume[VOLUMEKEYNUMBER],self.volume[VOLUMEKEYNAME]];
    self.title = VolumeTitle;
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - properties setter and getter

-(NSArray *)chapters{
    if(!_chapters){
        NSMutableArray *tempChapters = [NSMutableArray array];
        ONOXMLElement *volumeElement = self.volume[VOLUMEKEYELEMENT];
        for(ONOXMLElement *element in volumeElement.children){
            if([element.tag isEqualToString:CHAPTERTAG]){
                NSString *value = element.attributes[CHAPTERKEYVALUE];
                NSString *title = element.attributes[CHAPTERKEYTITLE];
                NSDictionary *chapter = @{   CHAPTERKEYVALUE: value,
                                             CHAPTERKEYTITLE: title,
                                             CHAPTERKEYELEMENT: element,
                                             };
                [tempChapters addObject:chapter];
            }
        }
        _chapters= [NSArray arrayWithArray:tempChapters];
    }
    return _chapters;
}

-(void)printChapters{
    for(NSDictionary *chapter in self.chapters){
        NSLog(@"chapter value: %@; title: %@",chapter[CHAPTERKEYVALUE],chapter[CHAPTERKEYTITLE]);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"SegueToChapter"]){
        PBBibleChapterViewController *cvc = (PBBibleChapterViewController *)segue.destinationViewController;
        NSIndexPath *selectedIP = self.collectionView.indexPathsForSelectedItems[0];
        cvc.chapter = self.chapters[selectedIP.row];
        cvc.bible = self.bible;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.chapters.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PBBibleChapterCell *cell = (PBBibleChapterCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSDictionary *chapter = self.chapters[indexPath.row];
    cell.numberLabel.text = chapter[CHAPTERKEYVALUE];
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"SegueToChapter" sender:indexPath];
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
