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
#import <AssetsLibrary/AssetsLibrary.h>


@interface ViewController : UIViewController<HorizontalListDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    NSMutableArray *mainCategoryItems;
    
    NSMutableArray *textCategoryItems;
    NSMutableArray *imageCategoryItems;
    NSMutableArray *stickerCategoryItems;
    NSMutableArray *borderCategoryItems;
    
    NSMutableArray *textColorCategoryItems;
    NSMutableArray *imageThemesCategoryItems;
    NSMutableArray *textFontCategoryItems;
    
    NSMutableArray *viewsinInstaView;
    UITextView *textView;
    UIImageView *instaTextView;
    UIImageView *borderView;
    UIImageView *cancelView;
    
    double lastArea;
    double currentArea;
    double lastFontSize;
    
    //ImagePickerController
    UIImagePickerController *picker;
    
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
}
@property (nonatomic, assign) CGRect crop;
@property (nonatomic, strong) UIView *cropView;
@property (nonatomic, strong) UIView *cancelView;
@property (strong, atomic) ALAssetsLibrary *library;

@end
