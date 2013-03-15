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
}

@end
