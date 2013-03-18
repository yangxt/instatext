//
//  ColorCategoryItems.m
//  instatext
//
//  Created by Varun Jain on 17/03/13.
//  Copyright (c) 2013 Varun Jain. All rights reserved.
//

#import "ColorCategoryItems.h"

@implementation ColorCategoryItems

- (id) initWithFrame:(CGRect)frame  color:(NSString *)colorHexValue attribute:(NSString *)attribute;
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.pList = nil;
        self.attribute = attribute;
        self.color = [self colorFromHexString:colorHexValue];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 32)];
        [view setBackgroundColor:self.color];
        [self addSubview:view];
    }
    return self;
}

- (UIColor *)colorFromHexString:(NSString *)colorhexValue{
    unsigned rgbvalue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:colorhexValue];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&rgbvalue];
    return [UIColor colorWithRed:((rgbvalue & 0xFF0000) >> 16)/255.0 green:((rgbvalue & 0xFF00) >> 8)/255.0 blue:(rgbvalue & 0xFF)/255.0 alpha:1.0];
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
