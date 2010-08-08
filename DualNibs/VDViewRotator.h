//
//  VDViewRotator.h
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VDDualNibsProtocols.h"

@interface VDViewRotator : NSObject < VDViewRotator > {
	id < VDRotatingViewSpecification > _portraitSpecification;
	id < VDRotatingViewSpecification > _landscapeSpecification;
}

// Synthesized Properties
@property(nonatomic, retain, readonly) id < VDRotatingViewSpecification > portraitSpecification;
@property(nonatomic, retain, readonly) id < VDRotatingViewSpecification > landscapeSpecification;

// Init + Dealloc
-(id)init;
-(id)initWithPortraitSpecification:(id < VDRotatingViewSpecification >)portraitSpecification landscapeSpecification:(id < VDRotatingViewSpecification >)landscapeSpecification;
+(id)viewRotatorUsingViewSpecificationClass:(Class)viewSpecificationClass;
-(void)dealloc;

// Lookup Utilities
-(id < VDRotatingViewSpecification >)viewSpecificationForOrientation:(UIInterfaceOrientation)orientation;

// VDViewRotator Methods
-(void)copyParametersFromView:(UIView *)view forOrientation:(UIInterfaceOrientation)orientation;

-(void)view:(UIView *)view willRotateToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation duration:(NSTimeInterval)duration;
-(void)view:(UIView *)view willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation duration:(NSTimeInterval)duration;
-(void)view:(UIView *)view didRotateToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation;

// Talking to VDInterfaceRotationAwareObject
-(void)informView:(UIView *)view willRotateToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation duration:(NSTimeInterval)duration;
-(void)informView:(UIView *)view willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation duration:(NSTimeInterval)duration;
-(void)informView:(UIView *)view didRotateToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation;

// Meta-Level Parameters
+(id < VDRotatingViewSpecification >)constructViewSpecification;
+(id < VDRotatingViewSpecification >)constructViewSpecificationUsingClass:(Class)class;

@end
