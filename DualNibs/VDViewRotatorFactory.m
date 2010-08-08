//
//  VDViewRotatorFactory.m
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import "VDViewRotatorFactory.h"
#import "VDViewRotator.h"
#import "VDViewSpecification.h"
#import "VDImageViewSpecification.h"
#import "VDLabelSpecification.h"
#import "VDButtonSpecification.h"

@interface VDViewRotatorFactory ()

@property(nonatomic, assign, readwrite) id < VDViewRotatorFactoryDelegate > delegate;

@end

@implementation VDViewRotatorFactory 

#pragma mark Synthesized Properties
@synthesize delegate = _delegate;

#pragma mark Init + Dealloc
-(id)init {
	return [self initWithDelegate:nil];
}

-(id)initWithDelegate:(id <VDViewRotatorFactoryDelegate>)delegate {
	VDParameterAssert(((delegate == nil) || ((delegate != nil) && ([delegate conformsToProtocol:@protocol(VDViewRotatorFactoryDelegate)]))));
	if (self = [super init]) {
		self.delegate = delegate;
	}
	return self;
}

#pragma mark VDViewRotatorFactory Methods
-(VDViewRotator *)viewRotatorForView:(UIView *)view withAccessKey:(NSString *)accessKey {
	VDParameterAssert(view != nil);
	VDParameterAssert([view isKindOfClass:[UIView class]]);
	VDParameterAssert(accessKey != nil);
	VDParameterAssert([accessKey isKindOfClass:[NSString class]]);
	VDViewRotator *viewRotator = nil;
	if (view && accessKey) {
		Class viewSpecificationClass = [self viewSpecificationClassForView:view 
															 withAccessKey:accessKey];
		if (self.delegate) {
			VDAssert([self.delegate conformsToProtocol:@protocol(VDViewRotatorFactoryDelegate)], @"Shouldn't ever have non-nil self.delegate unless conforms to VDViewRotatorFactoryDelegate.");
			Class errorRecoveryViewSpecificationClass = viewSpecificationClass;
			@try {
				viewSpecificationClass = [self.delegate viewRotatorFactory:self 
										proposesToUseViewSpecificationClass:viewSpecificationClass 
										 whenConstructingViewRotatorForView:view 
															  withAccessKey:accessKey];
			}
			@catch (NSException *e) {
				VDLogException(e);
				viewSpecificationClass = errorRecoveryViewSpecificationClass;
			}
		}
		if (viewSpecificationClass) {
			viewRotator = [self viewRotatorWithViewSpecificationClass:viewSpecificationClass];
			if (viewRotator && self.delegate) {
				VDAssert([self.delegate conformsToProtocol:@protocol(VDViewRotatorFactoryDelegate)], @"Shouldn't ever have non-nil self.delegate unless conforms to VDViewRotatorFactoryDelegate.");
				@try {
					[self.delegate viewRotatorFactory:self 
							   constructedViewRotator:viewRotator 
											  forView:view 
										withAccessKey:accessKey];
				}
				@catch (NSException *e) {
					VDLogException(e);
				}
			}
		}
	}
	return viewRotator;
}

#pragma mark Sub-Steps
-(Class)viewSpecificationClassForView:(UIView *)view withAccessKey:(NSString *)accessKey {
	VDParameterAssert(view != nil);
	VDParameterAssert([view isKindOfClass:[UIView class]]);
	VDParameterAssert(accessKey != nil);
	VDParameterAssert([accessKey isKindOfClass:[NSString class]]);
	Class viewSpecificationClassForView = nil;
	if (view && accessKey) {
		@try {
			viewSpecificationClassForView = [self actuallyProposeViewSpecificationClassForView:view 
																				 withAccessKey:accessKey];
		}
		@catch (NSException *e) {
			viewSpecificationClassForView = nil;
		}
	}
	if (!viewSpecificationClassForView) {
		viewSpecificationClassForView = [[self class] defaultViewSpecificationClass];
	}
	return viewSpecificationClassForView;
}

-(Class)actuallyProposeViewSpecificationClassForView:(UIView *)view withAccessKey:(NSString *)accessKey {
	VDParameterAssert(view != nil);
	VDParameterAssert([view isKindOfClass:[UIView class]]);
	VDParameterAssert(accessKey != nil);
	VDParameterAssert([accessKey isKindOfClass:[NSString class]]);
	Class proposedClass = nil;
	if (view && accessKey) {
		if ([view isKindOfClass:[UIButton class]]) {
			proposedClass = [VDButtonSpecification class];			
		} else if ([view isKindOfClass:[UILabel class]]) {
			proposedClass = [VDLabelSpecification class];
		} else if ([view isKindOfClass:[UIImageView class]]) {
			proposedClass = [VDImageViewSpecification class];
		} else if ([view isKindOfClass:[UIView class]]) {
			// ought to catch everything here
			proposedClass = [VDViewSpecification class];
		}
	}
	return proposedClass;
}

-(VDViewRotator *)viewRotatorWithViewSpecificationClass:(Class)viewSpecificationClass {
	VDParameterAssert(viewSpecificationClass != nil);
	return [VDViewRotator viewRotatorUsingViewSpecificationClass:viewSpecificationClass];
}

#pragma mark Classlevel Defaults
+(Class)defaultViewSpecificationClass {
	return [VDViewSpecification class];
}

@end
