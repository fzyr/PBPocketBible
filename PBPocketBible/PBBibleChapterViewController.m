//
//  PBBibleChapterViewController.m
//  PBPocketBible
//
//  Created by LAL on 15/11/30.
//  Copyright © 2015年 LAL. All rights reserved.
//

#import "PBBibleChapterViewController.h"
#import "PBBibleSectionCell.h"
#import "PBBibleSubChapterCell.h"

#define VOLUMEKEYNUMBER @"volumeKeyNumber"      //卷：第几卷
#define VOLUMEKEYCOLOR @"volumeKeyColor"        //卷：颜色
#define VOLUMEKEYNAME @"volumeKeyName"          //卷：名字
#define VOLUMEKEYSNAME @"volumeKeySName"        //卷：短名字
#define VOLUMEKEYTITLE @"volumeKeyTitle"        //卷：题目
#define VOLUMEKEYELEMENT @"volumeKeyElement"    //卷：xml中的对应元素


#define CHAPTERTAG @"chapter"                   //章:标签
#define CHAPTERKEYVALUE @"value"                //章：第几章
#define CHAPTERKEYTITLE @"title"                //章：题目
#define CHAPTERKEYELEMENT @"chapterKeyElement"  //章：xml中的对应元素

#define TYPE @"textType"                    //文本内容类型：子章or节

#define CHAPTERSUBTITLETAG @"t3"                //子章:标签
#define CHAPTERSUBTEXT @"chapterSubText"        //子章：内容

#define SECTIONTAG @"section"                   //节:标签
#define SECTIONNUMBER @"sectionNumber"          //节：第几节
#define SECTIONTEXT @"sectionText"              //节： 内容
#define SECTIONELEMENT @"sectionElement"        //节：xml中对应的元素




@interface PBBibleChapterViewController ()

@end

@implementation PBBibleChapterViewController

static NSString * const reusableIdentifier = @"SectionCell";
static NSString * const reusableIdentifier2 = @"SubChapterCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 90;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    

}

-(NSArray *)sections{
    if(!_sections){
        NSMutableArray *tempSections = [NSMutableArray array];
        ONOXMLElement *chapterElement = self.chapter[CHAPTERKEYELEMENT];
        for(ONOXMLElement *element in chapterElement.children ){
            if([element.tag isEqualToString:SECTIONTAG]){
                NSString *sectionText = element.stringValue;
                NSString *sectionNumber = element.attributes[@"value"];
                NSDictionary *section = @{
                                          TYPE: element.tag,
                                          SECTIONNUMBER: sectionNumber,
                                          SECTIONTEXT: sectionText,
                                          SECTIONELEMENT:element
                                          };
                [tempSections addObject:section];
            }else if ([element.tag isEqualToString:CHAPTERSUBTITLETAG]){
                NSString *chapterSubText = element.stringValue;
                NSDictionary *chapterSub = @{
                                             CHAPTERSUBTEXT: chapterSubText,
                                             };
                [tempSections addObject:chapterSub];
            }
            
        }
        _sections = [NSArray arrayWithArray:tempSections];
    }
    return _sections;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *section = self.sections[indexPath.row];
    NSString *type = section[TYPE];
    if([type isEqualToString:SECTIONTAG]){
        PBBibleSectionCell *cell = (PBBibleSectionCell *)[tableView dequeueReusableCellWithIdentifier:reusableIdentifier forIndexPath:indexPath];
        cell.sectionNumberLabel.font = [UIFont fontWithName:@"Avenir Next" size: 10];
        cell.sectionNumberLabel.textAlignment = UITextAlignmentCenter;
        cell.sectionNumberLabel.textColor = [UIColor blackColor];
        cell.sectionNumberLabel.text = section[SECTIONNUMBER];
        cell.SectionTextLabel.text = section[SECTIONTEXT];

    return cell;
    }else {
        PBBibleSubChapterCell *cell = (PBBibleSubChapterCell *)[tableView dequeueReusableCellWithIdentifier:reusableIdentifier2 forIndexPath:indexPath];

//        cell.sectionNumberLabel.textColor = [UIColor whiteColor];
        
        cell.titleLabel.text = section[CHAPTERSUBTEXT];

        return cell;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end