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
    stickerCategoryItems = [self putItemsFrom:@"" range:30 extension:@".png"];
    
    NSLog(@"main category item count %d", [mainCategoryItems count]);
    botttomBar = [[Stack alloc] init];
    [botttomBar pushObject:[[HorizontalList alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT - 72, 320.0, 72) items:mainCategoryItems numberOfRows:1]];
    [[botttomBar peekObject] setDelegate:self];
    
    instaTextView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    [instaTextView setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:instaTextView];
    
    UIView *bottomView = [botttomBar peekObject];
    [bottomView setBackgroundColor:[UIColor greenColor]];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton setTitle:@"Back" forState:UIControlStateSelected];
    
    
    
    [backButton addTarget:self
                       action:@selector(didPressBackButton:)
             forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bottomView];
    [self.view addSubview:backButton];
    [self.view bringSubviewToFront:bottomView];
    
}

- (NSMutableArray *)putItemsFrom:(NSString *)startName range:(NSUInteger)range extension:(NSString *) extension{
    NSUInteger index = 0;
    NSString *fileName = [[NSString alloc] init];
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    
    for (index = 0; index < range; index++) {
        fileName = [startName stringByAppendingString:[NSString stringWithFormat:@"%d",index]];
        fileName = [fileName stringByAppendingString:extension];
        MainCategoryItem *item = [[MainCategoryItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed: fileName] text:fileName pList:nil];
        [itemArray addObject:item];
        NSLog(@"file name %@", fileName);
    }
    return itemArray;
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
            
            // Main Category Items
            if ([item.pList isEqualToString: PLIST_ITEM_TEXT]) {
                
                [botttomBar pushObject:[[HorizontalList alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT , 320.0, 72.0) items:textCategoryItems numberOfRows:1]];
                
                
            } else if ([item.pList isEqualToString:PLIST_ITEM_IMAGE]) {
                
                [botttomBar pushObject:[[HorizontalList alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT , 320.0, 144.0) items:textCategoryItems numberOfRows:2]];
                
            } else if ([item.pList isEqualToString:PLIST_ITEM_STICKERS]){
                [botttomBar pushObject:[[HorizontalList alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT , 320.0, 144.0) items:stickerCategoryItems numberOfRows:2]];
                
            } else if ([item.pList isEqualToString:PLIST_ITEM_BORDERS]){
                  // TO DO:
                
            }
            
            // Text Category
            else if ([item.pList isEqualToString:PLIST_ITEM_FONT]) {
                
                [botttomBar pushObject:[[HorizontalList alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT , 320.0, 144.0) items:textFontCategoryItems numberOfRows:2]];
                
            } else if ([item.pList isEqualToString:PLIST_ITEM_COLOR]) {
                // TO DO:
            } else if ([item.pList isEqualToString:PLIST_ITEM_LAYOUT]) {
                // TO DO:
            } else if ([item.pList isEqualToString:PLIST_ITEM_STYLE]) {
                // TO DO:
            }
            
            // Image Category
            else if ([item.pList isEqualToString:PLIST_ITEM_LIBRARY]){
                
            } else if ([item.pList isEqualToString:PLIST_ITEM_CAMERA]){
                
            } else if ([item.pList isEqualToString:PLIST_ITEM_THEMES]){
                
            } else if ([item.pList isEqualToString:PLIST_ITEM_EFFECTS]){
                
            }
            else{
                
            }
            
            [[botttomBar peekObject] setDelegate:self];
            [[botttomBar peekObject] setBackgroundColor:[UIColor greenColor]];
            [self.view addSubview:[botttomBar peekObject]];
            
            if (((HorizontalList *)[botttomBar peekObject]).rows == 1) {
                [self moveTo:CGPointMake(0, SCREEN_HEIGHT - 144 ) duration:1.0 option:UIViewAnimationOptionCurveEaseIn horizontalList:[botttomBar peekObject]];
            } else if(((HorizontalList *)[botttomBar peekObject]).rows == 2) {
                [self moveTo:CGPointMake(0, SCREEN_HEIGHT - 288 ) duration:1.0 option:UIViewAnimationOptionCurveEaseIn horizontalList:[botttomBar peekObject]];
            } else{
                
            }
            
        } else {
            [self.view setUserInteractionEnabled:YES];
            NSLog(@"item plist is null Lets start the magic :) Booyeah !");
            UIImageView *itemInstance = [[UIImageView alloc] initWithImage:item.image];
            NSLog(@"frame dimension %f", itemInstance.frame.size.width);
            [itemInstance setFrame:CGRectMake(40, 40, 100, 100)];
            [itemInstance setUserInteractionEnabled:YES];
            [instaTextView addSubview:itemInstance];
            [self addGestureRecognizersToPiece:itemInstance];
        }


    }

    

    
}


- (void)didPressBackButton:(id)sender {
    
    [self moveTo:CGPointMake(0, SCREEN_HEIGHT) duration:1.0 option:UIViewAnimationOptionCurveEaseIn horizontalList:[botttomBar peekObject]];
    [botttomBar popObject];
    NSLog(@"number of rows %d", ((HorizontalList *)[botttomBar peekObject]).rows);
    if (((HorizontalList *)[botttomBar peekObject]).rows == 1) {
        NSLog(@"yya");
        [self moveTo:CGPointMake(0, SCREEN_HEIGHT - 142 ) duration:1.0 option:UIViewAnimationOptionCurveEaseIn horizontalList:[botttomBar peekObject]];
    } else if(((HorizontalList *)[botttomBar peekObject]).rows == 2) {
        NSLog(@"bbba");
        [self moveTo:CGPointMake(0, SCREEN_HEIGHT - 304 ) duration:1.0 option:UIViewAnimationOptionCurveEaseIn horizontalList:[botttomBar peekObject]];
    } else{
        NSLog(@"shit happened");
    }
}


// adds a set of gesture recognizers to one of our piece subviews
- (void)addGestureRecognizersToPiece:(UIView *)piece
{
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotatePiece:)];
    [piece addGestureRecognizer:rotationGesture];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scalePiece:)];
    [pinchGesture setDelegate:self];
    [piece addGestureRecognizer:pinchGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPiece:)];
    [panGesture setMaximumNumberOfTouches:2];
    [panGesture setDelegate:self];
    [piece addGestureRecognizer:panGesture];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showControls:)];
    [piece addGestureRecognizer:longPressGesture];
}


#pragma mark -
#pragma mark === Utility methods  ===
#pragma mark

// scale and rotation transforms are applied relative to the layer's anchor point
// this method moves a gesture recognizer's view's anchor point between the user's fingers
- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}


// UIMenuController requires that we can become first responder or it won't display
- (BOOL)canBecomeFirstResponder
{
    return YES;
}


#pragma mark -
#pragma mark === Touch handling  ===
#pragma mark

// shift the piece's center by the pan amount
// reset the gesture recognizer's translation to {0, 0} after applying so the next callback is a delta from the current position
- (void)panPiece:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *piece = [gestureRecognizer view];
    
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
        NSLog(@"here are we");
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
        [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
    }
}

// rotate the piece by the current rotation
// reset the gesture recognizer's rotation to 0 after applying so the next callback is a delta from the current rotation
- (void)rotatePiece:(UIRotationGestureRecognizer *)gestureRecognizer
{
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformRotate([[gestureRecognizer view] transform], [gestureRecognizer rotation]);
        [gestureRecognizer setRotation:0];
    }
}

// scale the piece by the current scale
// reset the gesture recognizer's rotation to 0 after applying so the next callback is a delta from the current scale
- (void)scalePiece:(UIPinchGestureRecognizer *)gestureRecognizer
{
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], [gestureRecognizer scale], [gestureRecognizer scale]);
        [gestureRecognizer setScale:1];
    }
}

- (void)showControls:(UILongPressGestureRecognizer *)gestureRecognizer{
    NSLog(@"show controls called");
}
// ensure that the pinch, pan and rotate gesture recognizers on a particular view can all recognize simultaneously
// prevent other gesture recognizers from recognizing simultaneously
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // if the gesture recognizers's view isn't one of our pieces, don't allow simultaneous recognition
    NSLog(@"Gesture recognizer view class %@", [gestureRecognizer.view class]);
    
    
    
    
    // if the gesture recognizers are on different views, don't allow simultaneous recognition
    if (gestureRecognizer.view != otherGestureRecognizer.view)
        return NO;
    
    // if either of the gesture recognizers is the long press, don't allow simultaneous recognition
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] || [otherGestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]])
        return NO;
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint pointInView = [touch locationInView:gestureRecognizer.view];
    NSLog(@"tracking point");
    if ( [gestureRecognizer isMemberOfClass:[UIRotationGestureRecognizer class]]
        && CGRectContainsPoint(instaTextView.frame, pointInView) ) {
        return YES;
    }
    
    if ( [gestureRecognizer isMemberOfClass:[UIPinchGestureRecognizer class]]
        && CGRectContainsPoint(instaTextView.frame, pointInView) ) {
        return YES;
    }
    
    if ( [gestureRecognizer isMemberOfClass:[UIPanGestureRecognizer class]]
        && CGRectContainsPoint(instaTextView.frame, pointInView) ) {
        return YES;
    }
    
    if (CGRectContainsPoint(instaTextView.frame, pointInView) ) {
        return YES;
    }
    NSLog(@"point doesnt exist in instatextview");
    return NO;
}

@end
