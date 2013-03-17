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

#define IMAGE_CROPPER_OUTSIDE_STILL_TOUCHABLE 40.0f
#define IMAGE_CROPPER_INSIDE_STILL_EDGE 20.0f

#ifndef CGWidth
#define CGWidth(rect)                   rect.size.width
#endif

#ifndef CGHeight
#define CGHeight(rect)                  rect.size.height
#endif

#ifndef CGOriginX
#define CGOriginX(rect)                 rect.origin.x
#endif

#ifndef CGOriginY
#define CGOriginY(rect)                 rect.origin.y
#endif

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Initialize the informtion to feed the control
    mainCategoryItems = [self putItemsFrom:PLIST_ITEM_MAIN];
    
    //Initialize the informtion to feed the control
    textCategoryItems = [self putItemsFrom:PLIST_ITEM_TEXT];
    
    //imageCategoryItem
    imageCategoryItems = [self putItemsFrom:PLIST_ITEM_IMAGE];
    
    //stickerCategoryItems = [self putItemsFrom:PLIST_ITEM_FONT];
    stickerCategoryItems = [self putItemsFrom:@"" range:30 extension:@".png" attribute:ATTR_IMAGE];
    
    //borderCategoryItems
    borderCategoryItems = [self putItemsFrom:@"fme0" range:42 extension:@".png" attribute:ATTR_BORDER];
    
    // themes Category items
    imageThemesCategoryItems = [self putItemsFrom:@"p_" range:20 extension:@".jpg" attribute:ATTR_BG];
    

    NSLog(@"main category item count %d", [mainCategoryItems count]);
    botttomBar = [[Stack alloc] init];
    [botttomBar pushObject:[[HorizontalList alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT - 72, 320.0, 72) items:mainCategoryItems numberOfRows:1]];
    [[botttomBar peekObject] setDelegate:self];
    
    instaTextView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 40, 280, 300)];
    [instaTextView setBackgroundColor:[UIColor redColor]];
    
    // Adding border view as the first view so that it remains to be at the back
    borderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 380)];
    [self.view addSubview:borderView];
    
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

- (NSMutableArray *)putItemsFrom:(NSString *)startName range:(NSUInteger)range extension:(NSString *) extension attribute:(NSString *)attribute{
    NSUInteger index = 0;
    NSString *fileName = [[NSString alloc] init];
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    
    for (index = 0; index < range; index++) {
        fileName = [startName stringByAppendingString:[NSString stringWithFormat:@"%d",index]];
        fileName = [fileName stringByAppendingString:extension];
        MainCategoryItem *item = [[MainCategoryItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed: fileName] text:fileName pList:nil attribute:attribute];
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
        
        MainCategoryItem *item = [[MainCategoryItem alloc] initWithFrame:CGRectZero image:[UIImage imageNamed: imageName] text:textName pList:pList attribute:nil];
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
        
        if (item.attribute == nil) {
            
            [self moveTo:CGPointMake(0, SCREEN_HEIGHT) duration:1.0 option:UIViewAnimationOptionCurveEaseIn horizontalList:[botttomBar peekObject]];
            
            // Main Category Items
            if ([item.pList isEqualToString: PLIST_ITEM_TEXT]) {
                
                [botttomBar pushObject:[[HorizontalList alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT , 320.0, 72.0) items:textCategoryItems numberOfRows:1]];
                
                
            } else if ([item.pList isEqualToString:PLIST_ITEM_IMAGE]) {
                
                [botttomBar pushObject:[[HorizontalList alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT , 320.0, 72.0) items:imageCategoryItems numberOfRows:1]];
                
            } else if ([item.pList isEqualToString:PLIST_ITEM_STICKERS]){
                [botttomBar pushObject:[[HorizontalList alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT , 320.0, 144.0) items:stickerCategoryItems numberOfRows:2]];
                
            } else if ([item.pList isEqualToString:PLIST_ITEM_BORDERS]){
                [botttomBar pushObject:[[HorizontalList alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT , 320.0, 144.0) items:borderCategoryItems numberOfRows:2]];
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
                NSLog(@"themes category clicked");
                [botttomBar pushObject:[[HorizontalList alloc] initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT , 320.0, 144.0) items:imageThemesCategoryItems numberOfRows:2]];
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
            
            if ([item.attribute isEqualToString:ATTR_BG]){
                instaTextView.image = item.image;
            } else if([item.attribute isEqualToString:ATTR_BORDER]){
                borderView.image = item.image;
            } else{
                
                [self.view setUserInteractionEnabled:YES];
                NSLog(@"item plist is null Lets start the magic :) Booyeah !");
                UIImageView *itemInstance = [[UIImageView alloc] initWithImage:item.image];
                NSLog(@"frame dimension %f", itemInstance.frame.size.width);
                [itemInstance setFrame:CGRectMake(40, 40, 140, 140)];
                [itemInstance setUserInteractionEnabled:YES];
                [itemInstance.layer setBorderColor: [[UIColor blueColor] CGColor]];
                [itemInstance.layer setBorderWidth: 2.0];
                
                [itemInstance setUserInteractionEnabled:YES];
                itemInstance.contentMode = UIViewContentModeScaleAspectFill;
                imageSelected = item.image;
                
                
                topView = [self newEdgeView];
                bottomView = [self newEdgeView];
                leftView = [self newEdgeView];
                rightView = [self newEdgeView];
                topLeftView = [self newCornerView];
                topRightView = [self newCornerView];
                bottomLeftView = [self newCornerView];
                bottomRightView = [self newCornerView];
                self.cropView = itemInstance;
                [instaTextView addSubview:itemInstance];
            }

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

- (UIView*)newEdgeView {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.60];
    return view;
}

- (UIView*)newCornerView {
    UIView *view = [self newEdgeView];
    view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.60];
    return view;
}



#pragma mark - motion

- (CGFloat)distanceBetweenTwoPoints:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
    float x = toPoint.x - fromPoint.x;
    float y = toPoint.y - fromPoint.y;
    
    return sqrt(x * x + y * y);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self willChangeValueForKey:@"crop"];
    NSSet *allTouches = [event allTouches];
    
    switch ([allTouches count]) {
        case 1: {
            currentTouches = 1;
            isPanning = NO;
            CGFloat insetAmount = IMAGE_CROPPER_INSIDE_STILL_EDGE;
            
            CGPoint touch = [[allTouches anyObject] locationInView:instaTextView];
            if (CGRectContainsPoint(CGRectInset(self.cropView.frame, insetAmount, insetAmount), touch)) {
                isPanning = YES;
                panTouch = touch;
                return;
            }
            
            CGRect frame = self.cropView.frame;
            CGFloat x = touch.x;
            CGFloat y = touch.y;
            
            currentDragView = nil;
            
            // We start dragging if we're within the rect + the inset amount
            // If we're definitively in the rect we actually start moving right to the point
            if (CGRectContainsPoint(CGRectInset(topLeftView.frame, -insetAmount, -insetAmount), touch)) {
                currentDragView = topLeftView;
                
                if (CGRectContainsPoint(topLeftView.frame, touch)) {
                    frame.size.width += CGOriginX(frame) - x;
                    frame.size.height += CGOriginY(frame) - y;
                    frame.origin = touch;
                }
            }
            else if (CGRectContainsPoint(CGRectInset(topRightView.frame, -insetAmount, -insetAmount), touch)) {
                currentDragView = topRightView;
                
                if (CGRectContainsPoint(topRightView.frame, touch)) {
                    frame.size.height += CGOriginY(frame) - y;
                    frame.origin.y = y;
                    frame.size.width = x - CGOriginX(frame);
                }
            }
            else if (CGRectContainsPoint(CGRectInset(bottomLeftView.frame, -insetAmount, -insetAmount), touch)) {
                currentDragView = bottomLeftView;
                
                if (CGRectContainsPoint(bottomLeftView.frame, touch)) {
                    frame.size.width += CGOriginX(frame) - x;
                    frame.size.height = y - CGOriginY(frame);
                    frame.origin.x =x;
                }
            }
            else if (CGRectContainsPoint(CGRectInset(bottomRightView.frame, -insetAmount, -insetAmount), touch)) {
                currentDragView = bottomRightView;
                
                if (CGRectContainsPoint(bottomRightView.frame, touch)) {
                    frame.size.width = x - CGOriginX(frame);
                    frame.size.height = y - CGOriginY(frame);
                }
            }
            else if (CGRectContainsPoint(CGRectInset(topView.frame, 0, -insetAmount), touch)) {
                currentDragView = topView;
                
                if (CGRectContainsPoint(topView.frame, touch)) {
                    frame.size.height += CGOriginY(frame) - y;
                    frame.origin.y = y;
                }
            }
            else if (CGRectContainsPoint(CGRectInset(bottomView.frame, 0, -insetAmount), touch)) {
                currentDragView = bottomView;
                
                if (CGRectContainsPoint(bottomView.frame, touch)) {
                    frame.size.height = y - CGOriginY(frame);
                }
            }
            else if (CGRectContainsPoint(CGRectInset(leftView.frame, -insetAmount, 0), touch)) {
                currentDragView = leftView;
                
                if (CGRectContainsPoint(leftView.frame, touch)) {
                    frame.size.width += CGOriginX(frame) - x;
                    frame.origin.x = x;
                }
            }
            else if (CGRectContainsPoint(CGRectInset(rightView.frame, -insetAmount, 0), touch)) {
                currentDragView = rightView;
                
                if (CGRectContainsPoint(rightView.frame, touch)) {
                    frame.size.width = x - CGOriginX(frame);
                }
            }
            
            self.cropView.frame = frame;
            
            [self updateBounds];
            
            break;
        }
        case 2: {
            CGPoint touch1 = [[[allTouches allObjects] objectAtIndex:0] locationInView:instaTextView];
            CGPoint touch2 = [[[allTouches allObjects] objectAtIndex:1] locationInView:instaTextView];
            
            if (currentTouches == 0 && CGRectContainsPoint(self.cropView.frame, touch1) && CGRectContainsPoint(self.cropView.frame, touch2)) {
                isPanning = YES;
            }
            
            currentTouches = [allTouches count];
            break;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self willChangeValueForKey:@"crop"];
    NSSet *allTouches = [event allTouches];
    
    switch ([allTouches count])
    {
        case 1: {
            CGPoint touch = [[allTouches anyObject] locationInView:instaTextView];
            
            if (isPanning) {
                CGPoint touchCurrent = [[allTouches anyObject] locationInView:instaTextView];
                CGFloat x = touchCurrent.x - panTouch.x;
                CGFloat y = touchCurrent.y - panTouch.y;
                
                self.cropView.center = CGPointMake(self.cropView.center.x + x, self.cropView.center.y + y);
                
                panTouch = touchCurrent;
            }
            else if ((CGRectContainsPoint(instaTextView.bounds, touch))) {
                CGRect frame = self.cropView.frame;
                CGFloat x = touch.x;
                CGFloat y = touch.y;
                
                if (x > instaTextView.frame.size.width)
                    x = instaTextView.frame.size.width;
                
                if (y > instaTextView.frame.size.height)
                    y = instaTextView.frame.size.height;
                
                if (currentDragView == topView) {
                    frame.size.height += CGOriginY(frame) - y;
                    frame.origin.y = y;
                }
                else if (currentDragView == bottomView) {
                    //currentDragView = bottomView;
                    frame.size.height = y - CGOriginY(frame);
                }
                else if (currentDragView == leftView) {
                    frame.size.width += CGOriginX(frame) - x;
                    frame.origin.x = x;
                }
                else if (currentDragView == rightView) {
                    //currentDragView = rightView;
                    frame.size.width = x - CGOriginX(frame);
                }
                else if (currentDragView == topLeftView) {
                    frame.size.width += CGOriginX(frame) - x;
                    frame.size.height += CGOriginY(frame) - y;
                    frame.origin = touch;
                }
                else if (currentDragView == topRightView) {
                    frame.size.height += CGOriginY(frame) - y;
                    frame.origin.y = y;
                    frame.size.width = x - CGOriginX(frame);
                }
                else if (currentDragView == bottomLeftView) {
                    frame.size.width += CGOriginX(frame) - x;
                    frame.size.height = y - CGOriginY(frame);
                    frame.origin.x =x;
                }
                else if ( currentDragView == bottomRightView) {
                    frame.size.width = x - CGOriginX(frame);
                    frame.size.height = y - CGOriginY(frame);
                }
                
                self.cropView.frame = frame;
            }
        } break;
        case 2: {
            CGPoint touch1 = [[[allTouches allObjects] objectAtIndex:0] locationInView:instaTextView];
            CGPoint touch2 = [[[allTouches allObjects] objectAtIndex:1] locationInView:instaTextView];
            
            if (isPanning) {
                CGFloat distance = [self distanceBetweenTwoPoints:touch1 toPoint:touch2];
                
                if (scaleDistance != 0) {
                    CGFloat scale = 1.0f + ((distance-scaleDistance)/scaleDistance);
                    
                    CGPoint originalCenter = self.cropView.center;
                    CGSize originalSize = self.cropView.frame.size;
                    
                    CGSize newSize = CGSizeMake(originalSize.width * scale, originalSize.height * scale);
                    
                    if (newSize.width >= 50 && newSize.height >= 50 && newSize.width <= CGWidth(self.cropView.superview.frame) && newSize.height <= CGHeight(self.cropView.superview.frame)) {
                        self.cropView.frame = CGRectMake(0, 0, newSize.width, newSize.height);
                        self.cropView.center = originalCenter;
                    }
                }
                
                scaleDistance = distance;
            }
            else if (
                     currentDragView == topLeftView ||
                     currentDragView == topRightView ||
                     currentDragView == bottomLeftView ||
                     currentDragView == bottomRightView
                     ) {
                CGFloat x = MIN(touch1.x, touch2.x);
                CGFloat y = MIN(touch1.y, touch2.y);
                
                CGFloat width = MAX(touch1.x, touch2.x) - x;
                CGFloat height = MAX(touch1.y, touch2.y) - y;
                
                self.cropView.frame = CGRectMake(x, y, width, height);
            }
            else if (
                     currentDragView == topView ||
                     currentDragView == bottomView
                     ) {
                CGFloat y = MIN(touch1.y, touch2.y);
                CGFloat height = MAX(touch1.y, touch2.y) - y;
                
                // sometimes the multi touch gets in the way and registers one finger as two quickly
                // this ensures the crop only shrinks a reasonable amount all at once
                if (height > 30 || self.cropView.frame.size.height < 45)
                {
                    self.cropView.frame = CGRectMake(CGOriginX(self.cropView.frame), y, CGWidth(self.cropView.frame), height);
                }
            }
            else if (
                     currentDragView == leftView ||
                     currentDragView == rightView
                     ) {
                CGFloat x = MIN(touch1.x, touch2.x);
                CGFloat width = MAX(touch1.x, touch2.x) - x;
                
                // sometimes the multi touch gets in the way and registers one finger as two quickly
                // this ensures the crop only shrinks a reasonable amount all at once
                if (width > 30 || self.cropView.frame.size.width < 45)
                {                self.cropView.frame = CGRectMake(x, CGOriginY(self.cropView.frame), width, CGHeight(self.cropView.frame));
                }
            }
        } break;
    }
    
    [self updateBounds];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    scaleDistance = 0;
    currentTouches = [[event allTouches] count];
}


- (UIImage *)imageByCropping:(UIImage *)image toRect:(CGRect)rect
{
    if (UIGraphicsBeginImageContextWithOptions) {
        UIGraphicsBeginImageContextWithOptions(rect.size,
                                               /* opaque */ NO,
                                               /* scaling factor */ 0.0);
    } else {
        UIGraphicsBeginImageContext(rect.size);
    }
    
    // stick to methods on UIImage so that orientation etc. are automatically
    // dealt with for us
    [image drawAtPoint:CGPointMake(-rect.origin.x, -rect.origin.y)];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

-(CGRect)cropRectForFrame:(CGRect)frame
{
    
    CGFloat widthScale = instaTextView.bounds.size.width / instaTextView.frame.size.width;
    CGFloat heightScale = instaTextView.bounds.size.height / instaTextView.frame.size.height;
    
    float x, y, w, h, offset;
    if (widthScale<heightScale) {
        offset = (instaTextView.bounds.size.height - (instaTextView.frame.size.height*widthScale))/2;
        x = frame.origin.x / widthScale;
        y = (frame.origin.y-offset) / widthScale;
        w = frame.size.width / widthScale;
        h = frame.size.height / widthScale;
    } else {
        offset = (instaTextView.bounds.size.width - (instaTextView.frame.size.width*heightScale))/2;
        x = (frame.origin.x-offset) / heightScale;
        y = frame.origin.y / heightScale;
        w = frame.size.width / heightScale;
        h = frame.size.height / heightScale;
    }
    return CGRectMake(x, y, w, h);
}

- (void)updateBounds {
    
    [self constrainCropToImage];
    
    CGRect frame = self.cropView.frame;
    CGFloat x = CGOriginX(frame);
    CGFloat y = CGOriginY(frame);
    CGFloat width = CGWidth(frame);
    CGFloat height = CGHeight(frame);
    
    CGFloat selfWidth = CGWidth(instaTextView.frame);
    CGFloat selfHeight = CGHeight(instaTextView.frame);
    
    topView.frame = CGRectMake(x, 0, width , y);
    bottomView.frame = CGRectMake(x, y + height, width, selfHeight - y - height);
    leftView.frame = CGRectMake(0, y, x + 1, height);
    rightView.frame = CGRectMake(x + width, y, selfWidth - x - width, height);
    
    topLeftView.frame = CGRectMake(0, 0, x, y);
    topRightView.frame = CGRectMake(x + width, 0, selfWidth - x - width, y);
    bottomLeftView.frame = CGRectMake(0, y + height, x, selfHeight - y - height);
    bottomRightView.frame = CGRectMake(x + width, y + height, selfWidth - x - width, selfHeight - y - height);
    
    [self didChangeValueForKey:@"crop"];
}

- (void)constrainCropToImage {
    CGRect frame = self.cropView.frame;
    NSLog(@"constrain crop to image");
    
    if (CGRectEqualToRect(frame, CGRectZero)) return;
    
    BOOL change = NO;
    
    do {
        change = NO;
        
        if (CGOriginX(frame) < 0) {
            frame.origin.x = 0;
            change = YES;
        }
        
        if (CGWidth(frame) > CGWidth(self.cropView.superview.frame)) {
            frame.size.width = CGWidth(self.cropView.superview.frame);
            change = YES;
        }
        
        if (CGWidth(frame) < 20) {
            frame.size.width = 20;
            change = YES;
        }
        
        if (CGOriginX(frame) + CGWidth(frame) > CGWidth(self.cropView.superview.frame)) {
            frame.origin.x = CGWidth(self.cropView.superview.frame) - CGWidth(frame);
            change = YES;
        }
        
        if (CGOriginY(frame) < 0) {
            frame.origin.y = 0;
            change = YES;
        }
        
        if (CGHeight(frame) > CGHeight(self.cropView.superview.frame)) {
            frame.size.height = CGHeight(self.cropView.superview.frame);
            change = YES;
        }
        
        if (CGHeight(frame) < 20) {
            frame.size.height = 20;
            change = YES;
        }
        
        if (CGOriginY(frame) + CGHeight(frame) > CGHeight(self.cropView.superview.frame)) {
            frame.origin.y = CGHeight(self.cropView.superview.frame) - CGHeight(frame);
            change = YES;
        }
    } while (change);
    
    self.cropView.frame = frame;
}


@end
