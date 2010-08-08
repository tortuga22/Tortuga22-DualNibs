//
//  VDControlStateSpecification.m
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import "VDControlStateSpecification.h"

@implementation VDControlStateSpecification

#pragma mark VDControlStateSpecification Methods
-(void)copySpecificationFromControl:(UIControl *)control forControlState:(UIControlState)controlState {
	VDParameterAssert(control != nil);
	VDParameterAssert([control isKindOfClass:[UIControl class]]);
	if (control) {
		@try {
			[self actuallyCopySpecificationFromControl:control forControlState:controlState];
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
	}
}

-(void)configureControlToSpecification:(UIControl *)control forControlState:(UIControlState)controlState {
	VDParameterAssert(control != nil);
	VDParameterAssert([control isKindOfClass:[UIControl class]]);
	if (control) {
		@try {
			[self actuallyConfigureControlToSpecification:control forControlState:controlState];
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
	}
}

#pragma mark Utilities
-(void)actuallyCopySpecificationFromControl:(UIControl *)control forControlState:(UIControlState)controlState {
	;
}
-(void)actuallyConfigureControlToSpecification:(UIControl *)control forControlState:(UIControlState)controlState {
	;
}

@end