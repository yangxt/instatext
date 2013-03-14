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

- (id)initWithFrame:(CGRect)frame items:(NSMutableArray *)items numberOfRows:(NSUInteger)rows
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"number of items %d", [items count]);
        CGSize pageSize = CGSizeMake(ITEM_WIDTH, self.scrollView.frame.size.height);
        NSLog(@"page size %f ", pageSize.width);
        NSUInteger numberOfColumns = [items count] / rows;
        NSUInteger colIndex = 0;
        NSUInteger rowIndex = 0;
        
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, TITLE_HEIGHT, ITEM_WIDTH * (numberOfColumns + 1), ITEM_HEIGHT * rows)];
        

        for (colIndex = 0; colIndex < numberOfColumns; colIndex++) {
            
            for (rowIndex = 0; rowIndex < rows; rowIndex++) {
                MainCategoryItem *item = [items objectAtIndex: colIndex * rows + rowIndex];
                [item setFrame:CGRectMake(LEFT_PADDING + (ITEM_WIDTH + DISTANCE_BETWEEN_ITEMS) * colIndex, ITEM_HEIGHT * rowIndex, ITEM_WIDTH, ITEM_HEIGHT)];
                UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTapped:)];
                [item addGestureRecognizer:singleFingerTap];
                [self.scrollView addSubview:item];
            }
        }
        /**
        for (MainCategoryItem *item in items) {
            [item setFrame:CGRectMake(LEFT_PADDING + (pageSize.width + DISTANCE_BETWEEN_ITEMS) * page++, 0, pageSize.width, pageSize.height)];
            UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTapped:)];
            [item addGestureRecognizer:singleFingerTap];
            
            [self.scrollView addSubview:item];
        }
         **/
        
        self.scrollView.contentSize = CGSizeMake( LEFT_PADDING + [items count] * (ITEM_WIDTH + DISTANCE_BETWEEN_ITEMS), pageSize.height);
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
