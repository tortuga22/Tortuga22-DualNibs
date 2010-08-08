//
//  VDViewRotator.m
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import "VDViewRotator.h"
#import "VDViewSpecification.h"

@interface VDViewRotator ()

// Synthesized Properties
@property(nonatomic, retain, readwrite) id < VDRotatingViewSpecification > portraitSpecification;
@property(nonatomic, retain, readwrite) id < VDRotatingViewSpecification > landscapeSpecification;

@end

@implementation VDViewRotator

#pragma mark Synthesized Properties
@synthesize portraitSpecification = _portraitSpecification;
@synthesize landscapeSpecification = _landscapeSpecification;

#pragma mark Init + Dealloc
-(id)init {
	return [self initWithPortraitSpecification:[[self class] constructViewSpecification] 
						landscapeSpecification:[[self class] constructViewSpecification]];
}

-(id)initWithPortraitSpecification:(id < VDRotatingViewSpecification >)portraitSpecification landscapeSpecification:(id < VDRotatingViewSpecification >)landscapeSpecification {
	VDParameterAssert(portraitSpecification != nil);
	VDParameterAssert([portraitSpecification conformsToProtocol:@protocol(VDRotatingViewSpecification)]);
	VDParameterAssert(landscapeSpecification != nil);
	VDParameterAssert([landscapeSpecification conformsToProtocol:@protocol(VDRotatingViewSpecification)]);
	if (self = [super init]) {
		self.portraitSpecification = (portraitSpecification)?(portraitSpecification):([[self class] constructViewSpecification]);
		self.landscapeSpecification = (landscapeSpecification)?(landscapeSpecification):([[self class] constructViewSpecification]);
	}
	return self;
}

+(id)viewRotatorUsingViewSpecificationClass:(Class)viewSpecificationClass {
	VDParameterAssert(viewSpecificationClass != nil);
	id < VDRotatingViewSpecification > portraitSpecification = nil;
	id < VDRotatingViewSpecification > landscapeSpecification = nil;
	@try {
		if (viewSpecificationClass) {
			portraitSpecification = [self constructViewSpecificationUsingClass:viewSpecificationClass];
			landscapeSpecification = [self constructViewSpecificationUsingClass:viewSpecificationClass];
		}
	}
	@catch (NSException *e) {
		VDLogException(e);
		portraitSpecification = nil;
		landscapeSpecification = nil;
	}
	@finally {
		if (!portraitSpecification) {
			portraitSpecification = [self constructViewSpecification];
		} 
		if (!landscapeSpecification) {
			landscapeSpecification = [self constructViewSpecification];
		}
	}
	return [[[self alloc] initWithPortraitSpecification:portraitSpecification 
								 landscapeSpecification:landscapeSpecification] autorelease];
}

-(void)dealloc {
	self.portraitSpecification = nil;
	self.landscapeSpecification = nil;
	[super dealloc];
}

#pragma mark Lookup Utilities
-(id < VDRotatingViewSpecification >)viewSpecificationForOrientation:(UIInterfaceOrientation)orientation {
	return (UIInterfaceOrientationIsPortrait(orientation))?([self portraitSpecification]):([self landscapeSpecification]);
}

#pragma mark VDViewRotator Methods
-(void)copyParametersFromView:(UIView *)view forOrientation:(UIInterfaceOrientation)orientation {
	VDParameterAssert(view != nil);
	VDParameterAssert([view isKindOfClass:[UIView class]]);
	if (view) {
		id < VDRotatingViewSpecification > viewSpecification = [self viewSpecificationForOrientation:orientation];
		VDAssert(viewSpecification != nil, @"Shouldn't ever get nil viewSpecification here.");
		if (viewSpecification) {
			[viewSpecification copySpecificationFromView:view];
		}
	}
}

#pragma mark -
-(void)view:(UIView *)view willRotateToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation duration:(NSTimeInterval)duration {
	if (view) {
		id < VDRotatingViewSpecification > viewSpecification = [self viewSpecificationForOrientation:newOrientation];
		VDAssert(viewSpecification != nil, @"Shouldn't ever get nil viewSpecification here.");
		if (viewSpecification) {
			[self informView:view willRotateToInterfaceOrientation:newOrientation fromInterfaceOrientation:oldOrientation duration:duration];
			[viewSpecification performPreRotationMovementViewConfiguration:view];
		}
	}
}

-(void)view:(UIView *)view willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation duration:(NSTimeInterval)duration {
	if (view) {
		id < VDRotatingViewSpecification > viewSpecification = [self viewSpecificationForOrientation:newOrientation];
		VDAssert(viewSpecification != nil, @"Shouldn't ever get nil viewSpecification here.");
		if (viewSpecification) {
			[self informView:view willAnimateRotationToInterfaceOrientation:newOrientation fromInterfaceOrientation:oldOrientation duration:duration];
			[viewSpecification performRotationMovementViewConfiguration:view];
		}
	}
}

-(void)view:(UIView *)view didRotateToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation {
	if (view) {
		id < VDRotatingViewSpecification > viewSpecification = [self viewSpecificationForOrientation:newOrientation];
		VDAssert(viewSpecification != nil, @"Shouldn't ever get nil viewSpecification here.");
		if (viewSpecification) {
			[viewSpecification performPostRotationMovementViewConfiguration:view];
			[self informView:view didRotateToInterfaceOrientation:newOrientation fromInterfaceOrientation:oldOrientation];
		}
	}
}

#pragma mark Talking to VDInterfaceRotationAwareObject
-(void)informView:(UIView *)view willRotateToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation duration:(NSTimeInterval)duration {
	if (view) {
		if ([view conformsToProtocol:@protocol(VDInterfaceRotationAwareObject)]) {
			@try {
				[((UIView<VDInterfaceRotationAwareObject> *)view) willRotateToInterfaceOrientation:newOrientation 
																		  fromInterfaceOrientation:oldOrientation 
																						  duration:duration];
			}
			@catch (NSException *e) {
				VDLogException(e);
			}
		}
	}
}

-(void)informView:(UIView *)view willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation duration:(NSTimeInterval)duration {
	if (view) {
		if ([view conformsToProtocol:@protocol(VDInterfaceRotationAwareObject)]) {
			@try {
				[((UIView<VDInterfaceRotationAwareObject> *)view) willAnimateRotationToInterfaceOrientation:newOrientation 
																				   fromInterfaceOrientation:oldOrientation 
																								   duration:duration];
			}
			@catch (NSException *e) {
				VDLogException(e);
			}
		}
	}
}

-(void)informView:(UIView *)view didRotateToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation {
	if (view) {
		if ([view conformsToProtocol:@protocol(VDInterfaceRotationAwareObject)]) {
			@try {
				[((UIView<VDInterfaceRotationAwareObject> *)view) didRotateToInterfaceOrientation:newOrientation 
																		 fromInterfaceOrientation:oldOrientation];
			}
			@catch (NSException *e) {
				VDLogException(e);
			}
		}
	}
}

#pragma mark Meta-Level Parameters
+(id < VDRotatingViewSpecification >)constructViewSpecification {
	return [[[VDViewSpecification alloc] init] autorelease];
}

+(id < VDRotatingViewSpecification >)constructViewSpecificationUsingClass:(Class)class {
	id < VDRotatingViewSpecification > specification = nil;
	if (class) {
		id constructed = nil;
		@try {
			constructed = [[[class alloc] init] autorelease];
		}
		@catch (NSException *e) {
			VDLogException(e);
			constructed =  nil;
		}
		@finally {
			if (constructed) {
				@try {
					if ([constructed conformsToProtocol:@protocol(VDRotatingViewSpecification)]) {
						specification = constructed;
					}
				}
				@catch (NSException *e) {
					VDLogException(e);
					specification = nil;
				}
			}
		}
	}
	return specification;
}

@end
