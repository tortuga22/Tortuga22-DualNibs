//
//  VDImageViewSpecification.m
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import "VDImageViewSpecification.h"

@interface VDImageViewSpecification ()

// Synthesized Properties
@property(nonatomic, retain, readwrite) UIImage *image;

@end

@implementation VDImageViewSpecification

#pragma mark Synthesized Properties
@synthesize image = _image;

#pragma mark  Init + Dealloc
-(void)dealloc {
	self.image = nil;
	[super dealloc];
}

#pragma mark Casting Utility
-(UIImageView *)castViewToImageView:(UIView *)view {
	UIImageView *castedView = nil;
	if (view) {
		if ([view isKindOfClass:[UIImageView class]]) {
			castedView = ((UIImageView *)view);
		}
	}
	return castedView;
}

#pragma mark Copying Overrides + Utilities
-(void)actuallyCopySpecificationFromView:(UIView *)view {
	[super actuallyCopySpecificationFromView:view];
	UIImageView *castedView = [self castViewToImageView:view];
	if (castedView) {
		@try {
			[self copyImageViewLevelPropertiesFromImageView:castedView];
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
	}
}

-(void)copyImageViewLevelPropertiesFromImageView:(UIImageView *)imageView {
	if (imageView) {
		[self setImage:[imageView image]];
	}
}

#pragma mark Configuration Overrides + Utilities
-(void)actuallyChangeViewContent:(UIView *)view {
	[super actuallyChangeViewContent:view];
	UIImageView *castedView = [self castViewToImageView:view];
	if (castedView) {
		@try {
			[self configureImageViewLevelPropertiesToSpecification:castedView];
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
	}
}

-(void)configureImageViewLevelPropertiesToSpecification:(UIImageView *)imageView {
	if (imageView) {
		[imageView setImage:[self image]];
	}
}

@end
