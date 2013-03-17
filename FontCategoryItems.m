//
//  FontCategoryItems.m
//  instatext
//
//  Created by Varun Jain on 17/03/13.
//  Copyright (c) 2013 Varun Jain. All rights reserved.
//

#import "FontCategoryItems.h"

@implementation FontCategoryItems

- (id) initWithFrame:(CGRect)frame  fontName:(NSString *)fontName attribute:(NSString *)attribute;

{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUserInteractionEnabled:YES];
        self.pList = nil;
        self.attribute = attribute;
        self.fontName = fontName;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"font_bg.png"]];
        imageRect = CGRectMake(0, 0, 50, 32);
        
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, imageView.frame.size.width - 10, imageView.frame.size.height - 10)];
        textView.text = @"Awe";
        textView.font = [UIFont fontWithName:fontName size:12];
        
        [imageView addSubview:textView];
        
        //[title setFrame:textRect];
        [imageView setFrame:imageRect];
        
        //[self addSubview:title];
        [self addSubview:imageView];
    }
    return self;
}
@end
