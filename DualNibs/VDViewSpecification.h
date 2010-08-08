//
//  VDViewSpecification.h
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VDDualNibsProtocols.h"

@interface VDViewSpecification : NSObject < VDRotatingViewSpecification >{
	CGRect _frame;
	BOOL _isHidden;
	CGFloat _alpha;
	UIColor *_backgroundColor;
}

// Synthesized Properties
@property(nonatomic, assign, readonly) CGRect frame;
@property(nonatomic, assign, readonly) BOOL isHidden;
@property(nonatomic, assign, readonly) CGFloat alpha;
@property(nonatomic, retain, readonly) UIColor *backgroundColor;

// VDViewSpecification Methods
-(void)copySpecificationFromView:(UIView *)sourceView;
-(void)configureViewToSpecification:(UIView *)targetView;

// Utilities - Copying
-(void)actuallyCopySpecificationFromView:(UIView *)sourceView;
-(void)copyViewLevelPropertiesFromView:(UIView *)sourceView;

// Utilities - Configuring
-(void)actuallyConfigureViewToSpecification:(UIView *)view;
-(void)configureViewLevelPropertiesToSpecification:(UIView *)view;

// Rotation Utilities
-(void)performPreRotationMovementViewConfiguration:(UIView *)view;
-(void)performRotationMovementViewConfiguration:(UIView *)view;
-(void)performPostRotationMovementViewConfiguration:(UIView *)view;

// Rotation Utilities - Actuals
-(void)actuallyPerformPreRotationMovementViewConfiguration:(UIView *)view;
-(void)actuallyPerformRotationMovementViewConfiguration:(UIView *)view;
-(void)actuallyPerformPostRotationMovementViewConfiguration:(UIView *)view;

// View-Level Operations
-(void)performViewLevelPreRotationMovementViewConfiguration:(UIView *)view;
-(void)performViewLevelRotationMovementViewConfiguration:(UIView *)view;
-(void)performViewLevelPostRotationMovementViewConfiguration:(UIView *)view;

@end