//
//  PBBibleQuoteViewController.m
//  PBPocketBible
//
//  Created by LAL on 15/11/30.
//  Copyright © 2015年 LAL. All rights reserved.
//

#import "PBBibleQuoteViewController.h"
#import <Ono.h>
#import "AppDelegate.h"
@interface PBBibleQuoteViewController ()


@property (weak, nonatomic) IBOutlet UIView *quoteBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *chapterLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *gotoButton;
@property (weak, nonatomic) IBOutlet UIButton *randomButton;

@property (assign, nonatomic) int totalSection;
@property (strong, nonatomic) ONOXMLDocument *bible;
@property (strong, nonatomic) ONOXMLElement *volumeElement;
@property (strong, nonatomic) ONOXMLElement *chapterElement;
@property (strong, nonatomic) ONOXMLElement *sectionElement;
@end

@implementation PBBibleQuoteViewController{



}

-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    self.quoteBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"creampaper"]];
    self.quoteBackgroundView.layer.shadowOpacity = 0.6f;//shadow的透明度
    self.quoteBackgroundView.layer.shadowOffset = CGSizeMake(-4.0f,4.0f);//shadow相对于主题的位置偏移
    self.quoteBackgroundView.layer.shadowRadius = 4.0f;//构成shadow的点的虚化半径
    self.quoteBackgroundView.layer.masksToBounds = NO;//用此属性来防止子元素大小溢出父元素，如若防止溢出，请设为 true
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.volumeLabel.text = @"";
    self.chapterLabel.text = @"";
    self.textView.text = @"";
    
    [self randomNextSection];
    
    // Do any additional setup after loading the view.
}


-(ONOXMLDocument *)bible{
    if(!_bible){
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        _bible = appDelegate.bible;
    }
    return _bible;
}

-(int )totalSection{
    if(!_totalSection){
        int volumeNumber = 0;
        int chapterNubmer = 0;
        int sectionNumber = 0;
        
        for(ONOXMLElement *volumeElement in self.bible.rootElement.children){
            if([volumeElement.tag isEqualToString:@"template"]){
                volumeNumber ++;
                for(ONOXMLElement *chapterElement in volumeElement.children){
                    if([chapterElement.tag isEqualToString:@"chapter"]){
                        chapterNubmer++;
                        for(ONOXMLElement *sectionElement in chapterElement.children){
                            if([sectionElement.tag isEqualToString:@"section"]){
                                sectionNumber ++;
                            }
                        }
                    }
                }
            }
        }
        _totalSection = sectionNumber;
    }
    return _totalSection;
}

-(void)randomNextSection{
    int randomSection = arc4random()%self.totalSection;
    int tempTotalSection = 0;
    

    
    for(ONOXMLElement *volumeElement in self.bible.rootElement.children){
        if([volumeElement.tag isEqualToString:@"template"]){

            for(ONOXMLElement *chapterElement in volumeElement.children){

                if([chapterElement.tag isEqualToString:@"chapter"]){
                    
                    for(ONOXMLElement *sectionElement in chapterElement.children){

                        tempTotalSection ++;
                        if([sectionElement.tag isEqualToString:@"section"]){
                            if(tempTotalSection == randomSection){
                                self.sectionElement = sectionElement;
                                self.chapterElement = chapterElement;
                                self.volumeElement = volumeElement;
                                goto OUT;
                            }
                        }
                    }
                }
            }
        }
    }
    
 OUT:
    NSLog(@"");
    NSString *volumeString = [NSString stringWithFormat:@"第%@卷 %@",self.volumeElement[@"value"], self.volumeElement[@"name"]];
    NSString *chapterString = [NSString stringWithFormat:@"%@",self.chapterElement[@"title"]];
    NSString *sectionText = [NSString stringWithFormat:@"%@",self.sectionElement.stringValue];
    
    self.volumeLabel.text = volumeString;
    self.chapterLabel.text = chapterString;
    self.textView.text = sectionText;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gotoButtonPressed:(id)sender {
    self.tabBarController.selectedViewController = self.tabBarController.viewControllers[0];
    UINavigationController *nav =(UINavigationController *)self.tabBarController.selectedViewController;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"toBibleSection" object:nil userInfo:@{@"volumeElement":self.volumeElement,
                                                                                                      @"chapterElement":self.chapterElement,
                                                                                                      @"sectionElement": self.sectionElement,
                                                                                                      }];
    
}


- (IBAction)randomButtonPressed:(id)sender {
    [self randomNextSection];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
