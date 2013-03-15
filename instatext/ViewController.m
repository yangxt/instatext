//
//  ViewController.m
//  instatext
//
//  Created by Varun Jain on 12/03/13.
//  Copyright (c) 2013 Varun Jain. All rights reserved.
//

#import "ViewController.h"
#import "HorizontalList.h"
#import "Constants.h"

#define SCREEN_WDITH 320.0
#define SCREEN_HEIGHT 460.0

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Initialize the informtion to feed the control
    mainCategoryItems = [self putItemsFrom:PLIST_ITEM_MAIN];
    
    //Initialize the informtion to feed the control
    textCategoryItems = [self putItemsFrom:PLIST_ITEM_TEXT];
    
    textFontCategoryItems = [self putItemsFrom:PLIST_ITEM_FONT];
    
    NSLog(@"main category item count %d", [mainCategoryItems count]);
    botttomBar = [[Stack alloc] init];
    [botttomBar pushObject:[[HorizontalList alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT - 80, 320.0, 72) items:mainCategoryItems numberOfRows:1]];
    [[botttomBar peekObject] setDelegate:self];
    
    [self.view addSubview:[botttomBar peekObject]];
    
}

- (NSMutableArray *) putItemsFrom: (NSString *)fromPathFile{
    NSString* plistPath = [[NSBundle mainBundle] pathForResource: fromPathFile
                                                          ofType: @"plist"];
    // Build the array from the plist
    NSMutableArray *items = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    NSMutableArray* containerArray = [[NSMutableArray alloc] init];
    for(int i = 0; i < items.count; ++i) {
        NSString *imageName = [items[i] objectForKey:@"image"];
        NSString *textName = [items[i] objectForKey:@"text"];
        NSString *pList = [items[i] objectForKey:@"plist"];
        
        NSLog(@"image %@", imageName);
        NSLog(@"textName %@", textName);
        
        MainCategoryItem *item = [[MainCategoryItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed: imageName] text:textName pList:pList];
        [containerArray addObject:item];
    }
    return containerArray;
}



- (void) moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option horizontalList:(HorizontalList *)list
{
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                         list.frame = CGRectMake(destination.x  ,  destination.y + list.frame.size.height  ,  list.frame.size.width , list.frame.size.height );
                     }
                     completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark HorizontalListDelegate

- (void) didSelectItem:(id)object {

    if ([object isKindOfClass:[MainCategoryItem class]]) {
        
        MainCategoryItem* item = (MainCategoryItem *)object;
        
        if (item.pList != nil) {
            
            [self moveTo:CGPointMake(0, SCREEN_HEIGHT) duration:1.0 option:UIViewAnimationOptionCurveEaseIn horizontalList:[botttomBar peekObject]];
            
            if ([item.pList isEqualToString: PLIST_ITEM_TEXT]) {
                
                [botttomBar pushObject:[[HorizontalList alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT , 320.0, 72.0) items:textCategoryItems numberOfRows:1]];
                
                
            } else if ([item.pList isEqualToString:PLIST_ITEM_IMAGE]) {
                
                [botttomBar pushObject:[[HorizontalList alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT , 320.0, 144.0) items:textCategoryItems numberOfRows:2]];
                
            } else if ([item.pList isEqualToString:PLIST_ITEM_FONT]) {
                
                [botttomBar pushObject:[[HorizontalList alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT , 320.0, 144.0) items:textFontCategoryItems numberOfRows:2]];
                
            }
            else{
                
            }
            
            [[botttomBar peekObject] setDelegate:self];
            [self.view addSubview:[botttomBar peekObject]];
            
            if (((HorizontalList *)[botttomBar peekObject]).rows == 1) {
                [self moveTo:CGPointMake(0, SCREEN_HEIGHT - 152 ) duration:1.0 option:UIViewAnimationOptionCurveEaseIn horizontalList:[botttomBar peekObject]];
            } else if(((HorizontalList *)[botttomBar peekObject]).rows == 2) {
                [self moveTo:CGPointMake(0, SCREEN_HEIGHT - 304 ) duration:1.0 option:UIViewAnimationOptionCurveEaseIn horizontalList:[botttomBar peekObject]];
            } else{
                
            }
            
        }


    }

    

    
}

- (IBAction)didPressBackButton:(id)sender {
    
    [self moveTo:CGPointMake(0, SCREEN_HEIGHT) duration:1.0 option:UIViewAnimationOptionCurveEaseIn horizontalList:[botttomBar peekObject]];
    [botttomBar popObject];
    NSLog(@"number of rows %d", ((HorizontalList *)[botttomBar peekObject]).rows);
    if (((HorizontalList *)[botttomBar peekObject]).rows == 1) {
        NSLog(@"yya");
        [self moveTo:CGPointMake(0, SCREEN_HEIGHT - 152 ) duration:1.0 option:UIViewAnimationOptionCurveEaseIn horizontalList:[botttomBar peekObject]];
    } else if(((HorizontalList *)[botttomBar peekObject]).rows == 2) {
        NSLog(@"bbba");
        [self moveTo:CGPointMake(0, SCREEN_HEIGHT - 304 ) duration:1.0 option:UIViewAnimationOptionCurveEaseIn horizontalList:[botttomBar peekObject]];
    } else{
        NSLog(@"shit happened");
    }
}
@end
