//
//  FontCategoryItems.h
//  instatext
//
//  Created by Varun Jain on 17/03/13.
//  Copyright (c) 2013 Varun Jain. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FontCategoryItems : UIView{
    CGRect textRect;
    CGRect imageRect;
}

@property(nonatomic, retain) NSString *fontName;
@property(nonatomic, retain) NSString *pList;
@property(nonatomic, retain) NSString *attribute;

- (id) initWithFrame:(CGRect)frame  fontName:(NSString *)fontName attribute:(NSString *)attribute;

@end
