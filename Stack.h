//
//  Stack.h
//  instatext
//
//  Created by Varun Jain on 14/03/13.
//  Copyright (c) 2013 Varun Jain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject
@property (nonatomic, readonly, assign) NSUInteger count;
- (id) initWithArray: (NSArray *)array;
- (void) pushObject: (id) object;
- (id) popObject;

- (void) pushObjects:(NSArray *)objects;
- (id) peekObject;
@end
