//
//  HorizontalListDelegate.h
//  instatext
//
//  Created by Varun Jain on 12/03/13.
//  Copyright (c) 2013 Varun Jain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainCategoryItem.h"

@protocol HorizontalListDelegate <NSObject>
- (void) didSelectItem: (MainCategoryItem *)item;
@end
