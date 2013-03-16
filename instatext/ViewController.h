//
//  ViewController.h
//  instatext
//
//  Created by Varun Jain on 12/03/13.
//  Copyright (c) 2013 Varun Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorizontalList.h"
#import "HorizontalListDelegate.h"
#import "Stack.h"


@interface ViewController : UIViewController<HorizontalListDelegate, UIGestureRecognizerDelegate>{
    NSMutableArray *mainCategoryItems;
    NSMutableArray *textCategoryItems;
    NSMutableArray *stickerCategoryItems;
    NSMutableArray *textFontCategoryItems;
    UIView *instaTextView;
    Stack *botttomBar;
    
    BOOL isPanning;
    NSInteger currentTouches;
    CGPoint panTouch;
    CGFloat scaleDistance;
    UIView *currentDragView;
    
    UIView *topView;
    UIView *bottomView;
    UIView *leftView;
    UIView *rightView;
    
    UIView *topLeftView;
    UIView *topRightView;
    UIView *bottomLeftView;
    UIView *bottomRightView;
    UIImageView *resizedImage;
    UIImage *imageSelected;
}
@property (nonatomic, assign) CGRect crop;
@property (nonatomic, strong) UIView *cropView;

@end
