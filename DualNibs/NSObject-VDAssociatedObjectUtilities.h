//
//  NSObject-VDAssociatedObjectUtilities.h
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSObject (VDAssociatedObjectUtilities)

-(BOOL)storeAssociatedObject:(id)associatedObject forObject:(id)object;
-(id)retrieveAssociatedObjectForObject:(id)object;
-(void)destroyAssociatedObjectForObject:(id)object;

-(BOOL)storeAssociatedObject:(id)associatedObject forKeyString:(NSString *)keyString;
-(id)retrieveAssociatedObjectForKeyString:(NSString *)keyString;
-(void)destroyAssociatedObjectForKeyString:(NSString *)keyString;

@end
