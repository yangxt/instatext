//
//  HorizontalList.h
//  instatext
//
//  Created by Varun Jain on 12/03/13.
//  Copyright (c) 2013 Varun Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "HorizontalListDelegate.h"

#define DISTANCE_BETWEEN_ITEMS  15.0
#define LEFT_PADDING            15.0
#define ITEM_WIDTH              72.0
#define ITEM_HEIGHT             72.0
#define TITLE_HEIGHT            40.0


@interface HorizontalList : UIView<UIScrollViewDelegate>{
    CGFloat scale;
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, assign) id<HorizontalListDelegate> delegate;
@property (nonatomic, assign) NSUInteger rows;

- (id)initWithFrame:(CGRect)frame items:(NSMutableArray *)items numberOfRows:(NSUInteger)rows;
@end
