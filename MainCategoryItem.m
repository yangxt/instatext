//
//  MainCategoryItem.m
//  instatext
//
//  Created by Varun Jain on 12/03/13.
//  Copyright (c) 2013 Varun Jain. All rights reserved.
//

#import "MainCategoryItem.h"

@implementation MainCategoryItem

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image text:(NSString *)imageTitle pList:(NSString *)pList
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUserInteractionEnabled:YES];
        self.image = image;
        self.imageTitle = imageTitle;
        self.pList = pList;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        /**
        UILabel *title = [[UILabel alloc] init];
        [title setBackgroundColor:[UIColor clearColor]];
        [title setFont:[UIFont boldSystemFontOfSize:12.0]];
        [title setOpaque: NO];
        [title setText:imageTitle];
         **/
        
        imageRect = CGRectMake(0, 0, 32, 32);
        //textRect = CGRectMake(0, imageRect.origin.y + imageRect.size.height + 10, 80, 20);
        
        //[title setFrame:textRect];
        [imageView setFrame:imageRect];
        
        //[self addSubview:title];
        [self addSubview:imageView];
    }
    return self;
}


@end
