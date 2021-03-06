//
//  MainCategoryItem.h
//  instatext
//
//  Created by Varun Jain on 12/03/13.
//  Copyright (c) 2013 Varun Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MainCategoryItem : UIView {
    CGRect textRect;
    CGRect imageRect;
}

@property(nonatomic, retain) NSString *imageTitle;
@property(nonatomic, retain) UIImage *image;
@property(nonatomic, retain) NSString *pList;
@property(nonatomic, retain) NSString *attribute;

- (id) initWithFrame:(CGRect)frame  image:(UIImage *)image text:(NSString *)imageTitle pList:(NSString *)pList attribute:(NSString *)attribute;
@end
