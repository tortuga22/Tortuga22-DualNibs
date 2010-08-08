//
//  VDViewSpecification.m
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import "VDViewSpecification.h"

@interface VDViewSpecification ()

// Synthesized Properties
@property(nonatomic, assign, readwrite) CGRect frame;
@property(nonatomic, assign, readwrite) BOOL isHidden;
@property(nonatomic, assign, readwrite) CGFloat alpha;
@property(nonatomic, retain, readwrite) UIColor *backgroundColor;

@end

@implementation VDViewSpecification

#pragma mark Synthesized Properties
@synthesize frame = _frame;
@synthesize isHidden = _isHidden;
@synthesize alpha = _alpha;
@synthesize backgroundColor = _backgroundColor;

#pragma mark Init + Dealloc
-(void)dealloc {
	self.backgroundColor = nil;
	[super dealloc];
}

#pragma mark VDViewSpecification Methods
-(void)copySpecificationFromView:(UIView *)sourceView {
	VDParameterAssert(sourceView != nil);
	VDParameterAssert([sourceView isKindOfClass:[UIView class]]);
	if (sourceView) {
		@try {
			[self actuallyCopySpecificationFromView:sourceView];
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
	}
}

-(void)configureViewToSpecification:(UIView *)targetView {
	VDParameterAssert(targetView != nil);
	VDParameterAssert([targetView isKindOfClass:[UIView class]]);
	if (targetView) {
		@try {
			[self actuallyConfigureViewToSpecification:targetView];
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
	}
}

#pragma mark Utilities - Copying
-(void)actuallyCopySpecificationFromView:(UIView *)sourceView {
	VDParameterAssert(sourceView != nil);
	VDParameterAssert([sourceView isKindOfClass:[UIView class]]);
	@try {
		[self copyViewLevelPropertiesFromView:sourceView];
	}
	@catch (NSException *e) {
		VDLogException(e);
	}
}

-(void)copyViewLevelPropertiesFromView:(UIView *)sourceView {
	VDParameterAssert(sourceView != nil);
	VDParameterAssert([sourceView isKindOfClass:[UIView class]]);
	[self setFrame:[sourceView frame]];
	[self setIsHidden:[sourceView isHidden]];
	[self setAlpha:[sourceView alpha]];
	[self setBackgroundColor:[sourceView backgroundColor]];
}

#pragma mark Utilities - Configuring
-(void)actuallyConfigureViewToSpecification:(UIView *)view {
	VDParameterAssert(view != nil);
	VDParameterAssert([view isKindOfClass:[UIView class]]);
	@try {
		[self configureViewLevelPropertiesToSpecification:view];
	}
	@catch (NSException *e) {
		VDLogException(e);
		// 
	}
}

-(void)configureViewLevelPropertiesToSpecification:(UIView *)view {
	VDParameterAssert(view != nil);
	VDParameterAssert([view isKindOfClass:[UIView class]]);
	[view setFrame:[self frame]];
	[view setHidden:[self isHidden]];
	[view setAlpha:[self alpha]];
	[view setBackgroundColor:[view backgroundColor]];
}

#pragma mark Rotation Utilities
-(void)performPreRotationMovementViewConfiguration:(UIView *)view {
	if (view) {
		@try {
			[self actuallyPerformPreRotationMovementViewConfiguration:view];
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
	}
}

-(void)performRotationMovementViewConfiguration:(UIView *)view {
	if (view) {
		@try {
			[self actuallyPerformRotationMovementViewConfiguration:view];
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
	}
}

-(void)performPostRotationMovementViewConfiguration:(UIView *)view {
	if (view) {
		@try {
			[self actuallyPerformPostRotationMovementViewConfiguration:view];
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
	}
}

#pragma mark -
-(void)actuallyPerformPreRotationMovementViewConfiguration:(UIView *)view {
	@try {
		[self performViewLevelPreRotationMovementViewConfiguration:view];
	}
	@catch (NSException *e) {
		VDLogException(e);
	}
}

-(void)actuallyPerformRotationMovementViewConfiguration:(UIView *)view {
	@try {
		[self performViewLevelRotationMovementViewConfiguration:view];
	}
	@catch (NSException *e) {
		VDLogException(e);
	}
}

-(void)actuallyPerformPostRotationMovementViewConfiguration:(UIView *)view {
	@try {
		[self performViewLevelPostRotationMovementViewConfiguration:view];
	}
	@catch (NSException *e) {
		VDLogException(e);
	}
}

#pragma mark -
-(void)performViewLevelPreRotationMovementViewConfiguration:(UIView *)view {
	if ([self isHidden]) {
		[view setHidden:YES];
	}
}

-(void)performViewLevelRotationMovementViewConfiguration:(UIView *)view {
	[view setFrame:[self frame]];
}

-(void)performViewLevelPostRotationMovementViewConfiguration:(UIView *)view {
	[view setBackgroundColor:[self backgroundColor]];
	[view setAlpha:[self alpha]];
	if (![self isHidden]) {
		[view setHidden:NO];
	}
}

@end
