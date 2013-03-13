//
//  HorizontalList.m
//  instatext
//
//  Created by Varun Jain on 12/03/13.
//  Copyright (c) 2013 Varun Jain. All rights reserved.
//

#import "HorizontalList.h"
#import "MainCategoryItem.h"

@implementation HorizontalList

- (id)initWithFrame:(CGRect)frame items:(NSMutableArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"number of items %d", [items count]);

        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, TITLE_HEIGHT, self.frame.size.width, self.frame.size.height)];
        
        CGSize pageSize = CGSizeMake(ITEM_WIDTH, self.scrollView.frame.size.height);
        NSUInteger page = 0;
        NSLog(@"page size %f ", pageSize.width);
        for (MainCategoryItem *item in items) {
            [item setFrame:CGRectMake(LEFT_PADDING + (pageSize.width + DISTANCE_BETWEEN_ITEMS) * page++, 0, pageSize.width, pageSize.height)];
            UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTapped:)];
            [item addGestureRecognizer:singleFingerTap];
            
            [self.scrollView addSubview:item];
        }
        
        self.scrollView.contentSize = CGSizeMake( LEFT_PADDING + [items count] * (pageSize.width + DISTANCE_BETWEEN_ITEMS), pageSize.height);
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
        
        [self addSubview:self.scrollView];
        
        
    }
    return self;
}

- (void) itemTapped: (UITapGestureRecognizer *)recognizer{
    MainCategoryItem *item = (MainCategoryItem *)recognizer.view;
    
    if (item != nil) {
        [self.delegate didSelectItem: item];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
