//
//  VDContentCarryingViewSpecification.m
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import "VDContentCarryingViewSpecification.h"

@implementation VDContentCarryingViewSpecification

#pragma mark Synthesized Properties
@synthesize changesContentAfterMovement = _changesContentAfterMovement;

#pragma mark Init + Dealloc
-(id)init {
	return [self initToChangeContentAfterMovmement:[[self class] changesContentAfterMovement]];
}

-(id)initToChangeContentAfterMovmement:(BOOL)changesContentAfterMovement {
	if (self = [super init]) {
		self.changesContentAfterMovement = changesContentAfterMovement;
	}
	return self;
}

#pragma mark Content Changing
-(void)changeViewContent:(UIView *)view {
	if (view) {
		@try {
			[self actuallyChangeViewContent:view];
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
	}
}

-(void)actuallyChangeViewContent:(UIView *)view {
	// lol do nothing here, override in subs
}

#pragma mark VDViewSpecification Overrides
-(void)actuallyConfigureViewToSpecification:(UIView *)view {
	[super actuallyConfigureViewToSpecification:view];
	[self changeViewContent:view];
}

-(void)actuallyPerformPreRotationMovementViewConfiguration:(UIView *)view {
	[super actuallyPerformPreRotationMovementViewConfiguration:view];
	if (view && ![self changesContentAfterMovement]) {
		[self changeViewContent:view];
	}
}

-(void)actuallyPerformPostRotationMovementViewConfiguration:(UIView *)view {
	[super actuallyPerformPostRotationMovementViewConfiguration:view];
	if (view && [self changesContentAfterMovement]) {
		[self changeViewContent:view];
	}
}

#pragma mark Class Defaults
+(BOOL)changesContentAfterMovement {
	return YES;
} 

@end
