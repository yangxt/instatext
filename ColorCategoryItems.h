//
//  ColorCategoryItems.h
//  instatext
//
//  Created by Varun Jain on 17/03/13.
//  Copyright (c) 2013 Varun Jain. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ColorCategoryItems : UIView

@property(nonatomic, retain) UIColor *color;
@property(nonatomic, retain) NSString *pList;
@property(nonatomic, retain) NSString *attribute;

- (id) initWithFrame:(CGRect)frame  color:(NSString *)colorHexValue attribute:(NSString *)attribute;

@end
