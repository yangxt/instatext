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

- (id) initWithFrame:(CGRect)frame  image:(UIImage *)image text:(NSString *)imageTitle;
@end
