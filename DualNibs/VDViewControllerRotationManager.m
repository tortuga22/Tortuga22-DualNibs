//
//  VDViewControllerRotationManager.m
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import "VDViewControllerRotationManager.h"
#import "VDViewRotatorFactory.h"
#import "VDViewRotator.h"
#import "VDDualNibsCategories.h"

@interface VDViewControllerRotationManager ()

// Synthesized Properties
@property(nonatomic, assign, readwrite) BOOL rotationActive;
@property(nonatomic, assign, readwrite) UIInterfaceOrientation fromOrientation;
@property(nonatomic, assign, readwrite) UIInterfaceOrientation toOrientation;
@property(nonatomic, retain, readwrite) NSMutableSet *rotatingViews;
@property(nonatomic, retain, readwrite) id < VDViewRotatorFactory > viewRotatorFactory;

@end

@implementation VDViewControllerRotationManager 

#pragma mark Synthesized Properties
@synthesize rotationActive = _rotationActive;
@synthesize fromOrientation = _fromOrientation;
@synthesize toOrientation = _toOrientation;
@synthesize rotatingViews = _rotatingViews;
@synthesize viewRotatorFactory = _viewRotatorFactory;

#pragma mark Init + Dealloc
-(id)initWithViewRotatorFactory:(id < VDViewRotatorFactory >)viewRotatorFactory {
	VDParameterAssert(viewRotatorFactory != nil);
	VDParameterAssert([viewRotatorFactory conformsToProtocol:@protocol(VDViewRotatorFactory)]);
	if (self = [super init]) {
		self.viewRotatorFactory = viewRotatorFactory;
		self.rotatingViews = [NSMutableSet set];
	}
	return self;
}

#pragma mark -
-(void)dealloc {
	[self deregisterAllRotatingViews];
	self.rotatingViews = nil;
	self.viewRotatorFactory = nil;
	[super dealloc];
}

#pragma mark View Registration
-(void)registerRotatingViewWithAccessKey:(NSString *)accessKey fromPrimaryViewController:(UIViewController *)primaryViewController alternateViewController:(UIViewController *)alternateViewController alternateOrientation:(UIInterfaceOrientation)alternateOrientation {
	VDParameterAssert(accessKey != nil);
	VDParameterAssert([accessKey isKindOfClass:[NSString class]]);
	VDParameterAssert(primaryViewController != nil);
	VDParameterAssert([primaryViewController isKindOfClass:[UIViewController class]]);
	VDParameterAssert(alternateViewController != nil);
	VDParameterAssert([alternateViewController isKindOfClass:[UIViewController class]]);
	VDParameterAssert([primaryViewController isKindOfClass:[alternateViewController class]] || ([primaryViewController isKindOfClass:[alternateViewController class]]));
	if (accessKey && primaryViewController && alternateViewController) {
		id prePrimaryView = [primaryViewController valueForKey:accessKey];
		id preAlternateView = [alternateViewController valueForKey:accessKey];
		if (prePrimaryView && preAlternateView) {
			if ([prePrimaryView isKindOfClass:[UIView class]] && [preAlternateView isKindOfClass:[UIView class]]) {
				VDParameterAssert([prePrimaryView isKindOfClass:[preAlternateView class]] || ([preAlternateView isKindOfClass:[prePrimaryView class]]));
				[self registerRotatingView:((UIView *)prePrimaryView) 
						 withAlternateView:((UIView *)preAlternateView)
					  alternateOrientation:alternateOrientation
							 withAccessKey:accessKey];
			}
		}
	}
}

-(void)registerRotatingView:(UIView *)rotatingView withAlternateView:(UIView *)alternateView alternateOrientation:(UIInterfaceOrientation)alternateOrientation withAccessKey:(NSString *)accessKey {
	VDParameterAssert(rotatingView != nil);
	VDParameterAssert([rotatingView isKindOfClass:[UIView class]]);
	VDParameterAssert(alternateView != nil);
	VDParameterAssert([alternateView isKindOfClass:[UIView class]]);
	VDParameterAssert([rotatingView isKindOfClass:[alternateView class]] || ([rotatingView isKindOfClass:[alternateView class]]));
	if (rotatingView && alternateView) {
		id < VDViewRotator > viewRotator = [self viewRotatorForView:rotatingView 
													  withAccessKey:accessKey];
		if (viewRotator) {
			BOOL copiedParameters = NO;
			@try {
				if (UIInterfaceOrientationIsPortrait(alternateOrientation)) {
					[viewRotator copyParametersFromView:rotatingView 
										 forOrientation:UIInterfaceOrientationLandscapeLeft];
					[viewRotator copyParametersFromView:alternateView 
										 forOrientation:UIInterfaceOrientationPortrait];
					copiedParameters = YES;
				} else {
					[viewRotator copyParametersFromView:rotatingView 
										 forOrientation:UIInterfaceOrientationPortrait];
					[viewRotator copyParametersFromView:alternateView 
										 forOrientation:UIInterfaceOrientationLandscapeLeft];
					copiedParameters = YES;
				}
			}
			@catch (NSException *e) {
				VDLogException(e);
				copiedParameters = NO;
			}
			@finally {
				if (copiedParameters) {
					[self registerViewForRotation:rotatingView 
								  withViewRotator:viewRotator];
				}
			}
		}
	}
}


-(void)registerViewForRotation:(UIView *)rotatingView withViewRotator:(id <VDViewRotator >)viewRotator {
	VDParameterAssert(rotatingView != nil);
	VDParameterAssert([rotatingView isKindOfClass:[UIView class]]);
	VDParameterAssert(viewRotator != nil);
	VDParameterAssert([viewRotator conformsToProtocol:@protocol(VDViewRotator)]);
	VDAssert(self.rotatingViews != nil, @"Shouldn't ever have self.rotatingViews == nil here.");
	if (rotatingView && viewRotator && self.rotatingViews) {
		@synchronized(self) {
			[self associateViewRotator:viewRotator 
							  withView:rotatingView];
			[self.rotatingViews addObject:rotatingView];
		}
	}
}

-(void)deregisterViewForRotation:(UIView *)rotatingView {
	VDParameterAssert(rotatingView != nil);
	VDParameterAssert([rotatingView isKindOfClass:[UIView class]]);
	VDAssert(self.rotatingViews != nil, @"Shouldn't ever have self.rotatingViews == nil here.");
	if (rotatingView && self.rotatingViews) {
		@synchronized(self) {
			@try {
				[self.rotatingViews removeObject:rotatingView];
			}
			@catch (NSException *e) {
				VDLogException(e);
			}
			@try {
				[self removeAssociatedViewRotatorFromRotatingView:rotatingView];
			}
			@catch (NSException *e) {
				VDLogException(e);
			}
		}
	}
}

-(void)deregisterAllRotatingViews {
	VDAssert(self.rotatingViews != nil, @"Shouldn't ever have self.rotatingViews == nil here.");
	if ([self.rotatingViews count] > 0) {
		@synchronized(self) {
			for (UIView *view in [self.rotatingViews allObjects]) {
				VDAssert([view isKindOfClass:[UIView class]], @"Should only ever have gotten UIView instances into self.rotatingViews.");
				[self deregisterViewForRotation:view];
			}
		}
	}
	VDAssert(([self.rotatingViews count] == 0), @"Should always have empty self.rotatingViews by here.");
}

#pragma mark Managing Associated View Rotators
-(id < VDViewRotator >)viewRotatorForView:(UIView *)view withAccessKey:(NSString *)accessKey {
	id < VDViewRotator > viewRotator = nil;
	if (view && self.viewRotatorFactory) {
		viewRotator = [self.viewRotatorFactory viewRotatorForView:view 
													withAccessKey:accessKey];		
	}
	return viewRotator;
}

-(void)associateViewRotator:(id < VDViewRotator >)viewRotator withView:(UIView *)rotatingView {
	VDParameterAssert(rotatingView != nil);
	VDParameterAssert([rotatingView isKindOfClass:[UIView class]]);
	VDParameterAssert(viewRotator != nil);
	VDParameterAssert([viewRotator conformsToProtocol:@protocol(VDViewRotator)]);
	VDAssert(self.rotatingViews != nil, @"Shouldn't ever have self.rotatingViews == nil here.");
	if (viewRotator && rotatingView && self.rotatingViews) {
		@try {
			[rotatingView storeAssociatedObject:viewRotator 
									  forObject:self.rotatingViews];
		}
		@catch (NSException *e) {
			VDLogException(e);
			viewRotator = nil;
		}
	}
}

-(id < VDViewRotator >)retrieveAssociatedViewRotatorForRotatingView:(UIView *)rotatingView {
	VDParameterAssert(rotatingView != nil);
	VDParameterAssert([rotatingView isKindOfClass:[UIView class]]);
	VDAssert(self.rotatingViews != nil, @"Shouldn't ever have self.rotatingViews == nil here.");
	id < VDViewRotator > viewRotator = nil;
	if (rotatingView) {
		@try {
			viewRotator = [rotatingView retrieveAssociatedObjectForObject:self.rotatingViews];
		}
		@catch (NSException *e) {
			VDLogException(e);
			viewRotator = nil;
		}
 	}
	VDAssert(((viewRotator == nil) || ((viewRotator != nil) && [viewRotator conformsToProtocol:@protocol(VDViewRotator)])), @"Should have nil or have object conforming to VDViewRotator.");
	return viewRotator;
}

-(void)removeAssociatedViewRotatorFromRotatingView:(UIView *)rotatingView {
	VDParameterAssert(rotatingView != nil);
	VDParameterAssert([rotatingView isKindOfClass:[UIView class]]);
	VDAssert(self.rotatingViews != nil, @"Shouldn't ever have self.rotatingViews == nil here.");
	if (rotatingView) {
		@try {
			[rotatingView destroyAssociatedObjectForObject:self.rotatingViews];
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
 	}
}

#pragma mark VDViewControllerRotationDelegate
-(void)viewController:(UIViewController *)viewController willRotateToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation duration:(NSTimeInterval)duration {
	VDParameterAssert(viewController != nil);
	VDParameterAssert([viewController isKindOfClass:[UIViewController class]]);
	if (viewController) {
		@synchronized(self) {
			self.rotationActive = YES;
			self.toOrientation = newOrientation;
			self.fromOrientation = oldOrientation;
			for (UIView *rotatingView in self.rotatingViews) {
				id < VDViewRotator > viewRotator = [self retrieveAssociatedViewRotatorForRotatingView:rotatingView];
				if (viewRotator) {
					VDAssert([viewRotator conformsToProtocol:@protocol(VDViewRotator)], @"Should never have viewRotator that doesn't conform to VDViewRotator protocol.");
					@try {
						[viewRotator view:rotatingView 
		 willRotateToInterfaceOrientation:self.toOrientation 
				 fromInterfaceOrientation:self.fromOrientation 
								 duration:duration];
					}
					@catch (NSException *e) {
						VDLogException(e);
					}
				}
			}
		}
	}
}

-(void)viewController:(UIViewController *)viewController willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)newOrientation duration:(NSTimeInterval)duration {
	VDParameterAssert(viewController != nil);
	VDParameterAssert([viewController isKindOfClass:[UIViewController class]]);
	if (viewController) {
		@synchronized(self) {
			for (UIView *rotatingView in self.rotatingViews) {
				id < VDViewRotator > viewRotator = [self retrieveAssociatedViewRotatorForRotatingView:rotatingView];
				if (viewRotator) {
					VDAssert([viewRotator conformsToProtocol:@protocol(VDViewRotator)], @"Should never have viewRotator that doesn't conform to VDViewRotator protocol.");
					@try {
						[viewRotator view:rotatingView 
willAnimateRotationToInterfaceOrientation:self.toOrientation 
				 fromInterfaceOrientation:self.
						 fromOrientation duration:duration];
					}
					@catch (NSException *e) {
						VDLogException(e);
					}
				}
			}
		}
	}
}

-(void)viewController:(UIViewController *)viewController didRotateToInterfaceOrientation:(UIInterfaceOrientation)newOrientation {
	VDParameterAssert(viewController != nil);
	VDParameterAssert([viewController isKindOfClass:[UIViewController class]]);
	if (viewController) {
		@synchronized(self) {
			for (UIView *rotatingView in self.rotatingViews) {
				id < VDViewRotator > viewRotator = [self retrieveAssociatedViewRotatorForRotatingView:rotatingView];
				if (viewRotator) {
					VDAssert([viewRotator conformsToProtocol:@protocol(VDViewRotator)], @"Should never have viewRotator that doesn't conform to VDViewRotator protocol.");
					@try {
						[viewRotator view:rotatingView 
		  didRotateToInterfaceOrientation:self.toOrientation 
				 fromInterfaceOrientation:self.fromOrientation];
					}
					@catch (NSException *e) {
						VDLogException(e);
					}
				}
			}
			self.rotationActive = NO;
		}
	}
}

#pragma mark Classlevel Defaults
+(id < VDViewRotatorFactory >)viewRotatorFactory {
	return [[[VDViewRotatorFactory alloc] init] autorelease];
}

@end
