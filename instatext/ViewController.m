//
//  ViewController.m
//  instatext
//
//  Created by Varun Jain on 12/03/13.
//  Copyright (c) 2013 Varun Jain. All rights reserved.
//

#import "ViewController.h"
#import "HorizontalList.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Initialize the informtion to feed the control
    mainCategoryItems = [self putItemsFrom:@"mainCategoryItems"];
    
    //Initialize the informtion to feed the control
    textCategoryItems = [self putItemsFrom:@"textCategoryItems"];
    
    NSLog(@"main category item count %d", [mainCategoryItems count]);
    botttomBar = [[Stack alloc] init];
    [botttomBar pushObject:[[HorizontalList alloc] initWithFrame:CGRectMake(0.0, 310.0, 320.0, 75.0) items:mainCategoryItems]];
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
        NSLog(@"image %@", imageName);
        NSLog(@"textName %@", textName);
        
        MainCategoryItem *item = [[MainCategoryItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed: imageName] text:textName];
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

- (void) didSelectItem:(MainCategoryItem *)item {
    NSLog(@"Horizontal List Item %@ selected", item.imageTitle);
    
    [self moveTo:CGPointMake(0, 345) duration:1.0 option:UIViewAnimationOptionCurveEaseIn horizontalList:[botttomBar peekObject]];
    
    if ([item.imageTitle isEqualToString:@"Text"]) {
        
        [botttomBar pushObject:[[HorizontalList alloc] initWithFrame:CGRectMake(0.0, 420.0, 320.0, 75.0) items:textCategoryItems]];
        [[botttomBar peekObject] setDelegate:self];
        [self.view addSubview:[botttomBar peekObject]];
    } else if ([item.imageTitle isEqualToString:@"Image"]) {
        [botttomBar pushObject:[[HorizontalList alloc] initWithFrame:CGRectMake(0.0, 420.0, 320.0, 75.0) items:textCategoryItems]];
        [[botttomBar peekObject] setDelegate:self];
        [self.view addSubview:[botttomBar peekObject]];
    } else{
        
    }
                
    [self moveTo:CGPointMake(0, 245) duration:1.0 option:UIViewAnimationOptionCurveEaseIn horizontalList:[botttomBar peekObject]];
}
- (IBAction)didPressBackButton:(id)sender {
    
    [self moveTo:CGPointMake(0, 420) duration:1.0 option:UIViewAnimationOptionCurveEaseIn horizontalList:[botttomBar peekObject]];
    [botttomBar popObject];
    
    [self moveTo:CGPointMake(0, 245) duration:1.0 option:UIViewAnimationOptionCurveEaseIn horizontalList:[botttomBar peekObject]];
}
@end
