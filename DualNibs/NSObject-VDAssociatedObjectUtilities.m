//
//  NSObject-VDAssociatedObjectUtilities.m
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import "NSObject-VDAssociatedObjectUtilities.h"
#import <Foundation/NSObject.h>
#import <objc/runtime.h>

@implementation NSObject (VDAssociatedObjectUtilities)

-(BOOL)storeAssociatedObject:(id)associatedObject forObject:(id)object {
	VDParameterAssert(associatedObject != nil);
	VDParameterAssert(object != nil);
	BOOL storedSuccessfully = NO;
	if (object && associatedObject) {
		@try {
			objc_setAssociatedObject(self, object, associatedObject, OBJC_ASSOCIATION_RETAIN);
			storedSuccessfully = YES;
		}
		@catch (NSException *e) {
			storedSuccessfully = NO;
		}
	}
	return storedSuccessfully;
}

-(id)retrieveAssociatedObjectForObject:(id)object {
	VDParameterAssert(object != nil);
	id associatedObject = nil;
	if (object) {
		@try {
			associatedObject = objc_getAssociatedObject(self, object);			
		}
		@catch (NSException *e) {
			VDLogException(e);
			associatedObject = nil;
		}
	}
	return associatedObject;	
}

-(void)destroyAssociatedObjectForObject:(id)object {
	VDParameterAssert(object != nil);
	if (object) {
		@try {
			objc_setAssociatedObject(self, object, nil, OBJC_ASSOCIATION_RETAIN);
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
	}	
}


-(BOOL)storeAssociatedObject:(id)associatedObject forKeyString:(NSString *)keyString {
	VDParameterAssert(associatedObject != nil);
	VDParameterAssert(keyString != nil);
	VDParameterAssert([keyString isKindOfClass:[NSString class]]);
	BOOL storedSuccessfully = NO;
	if (keyString && associatedObject) {
		@try {
			objc_setAssociatedObject(self, keyString, associatedObject, OBJC_ASSOCIATION_RETAIN);
			storedSuccessfully = YES;
		}
		@catch (NSException *e) {
			storedSuccessfully = NO;
		}
	}
	return storedSuccessfully;
}

-(id)retrieveAssociatedObjectForKeyString:(NSString *)keyString {
	VDParameterAssert(keyString != nil);
	VDParameterAssert([keyString isKindOfClass:[NSString class]]);
	id associatedObject = nil;
	if (keyString) {
		@try {
			associatedObject = objc_getAssociatedObject(self, keyString);			
		}
		@catch (NSException *e) {
			VDLogException(e);
			associatedObject = nil;
		}
	}
	return associatedObject;
}

-(void)destroyAssociatedObjectForKeyString:(NSString *)keyString {
	VDParameterAssert(keyString != nil);
	VDParameterAssert([keyString isKindOfClass:[NSString class]]);
	if (keyString) {
		@try {
			objc_setAssociatedObject(self, keyString, nil, OBJC_ASSOCIATION_RETAIN);
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
	}
}

@end
