//
//  VDViewSpecificationProtocols.h
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VDViewSpecification < NSObject >

// Copying + Configuring
-(void)copySpecificationFromView:(UIView *)sourceView;
-(void)configureViewToSpecification:(UIView *)targetView;

@end

@protocol VDRotatingViewSpecification < VDViewSpecification >

// Rotation Operations
-(void)performPreRotationMovementViewConfiguration:(UIView *)view;
-(void)performRotationMovementViewConfiguration:(UIView *)view;
-(void)performPostRotationMovementViewConfiguration:(UIView *)view;

@end

@protocol VDControlStateSpecification < NSObject >

-(void)copySpecificationFromControl:(UIControl *)control forControlState:(UIControlState)controlState;
-(void)configureControlToSpecification:(UIControl *)control forControlState:(UIControlState)controlState;

@end