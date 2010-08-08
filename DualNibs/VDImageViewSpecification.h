//
//  VDImageViewSpecification.h
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VDDualNibsProtocols.h"
#import "VDContentCarryingViewSpecification.h"

@interface VDImageViewSpecification : VDContentCarryingViewSpecification {
	UIImage *_image;
}

// Synthesized Properties
@property(nonatomic, retain, readonly) UIImage *image;

// Init + Dealloc
-(void)dealloc;

// Casting Utility
-(UIImageView *)castViewToImageView:(UIView *)view;

// Overrides Etc
-(void)actuallyCopySpecificationFromView:(UIView *)view;
-(void)copyImageViewLevelPropertiesFromImageView:(UIImageView *)imageView;
-(void)actuallyChangeViewContent:(UIView *)view;
-(void)configureImageViewLevelPropertiesToSpecification:(UIImageView *)imageView;

@end
