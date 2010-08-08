//
//  VDViewControllerRotationManager.h
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VDDualNibsProtocols.h"

@interface VDViewControllerRotationManager : NSObject < VDViewControllerRotationDelegate > {
	BOOL _rotationActive;
	UIInterfaceOrientation _fromOrientation;
	UIInterfaceOrientation _toOrientation;
	NSMutableSet *_rotatingViews;
	id < VDViewRotatorFactory > _viewRotatorFactory;
}

// Synthesized Properties
@property(nonatomic, assign, readonly) BOOL rotationActive;
@property(nonatomic, assign, readonly) UIInterfaceOrientation fromOrientation;
@property(nonatomic, assign, readonly) UIInterfaceOrientation toOrientation;
@property(nonatomic, retain, readonly) NSMutableSet *rotatingViews;
@property(nonatomic, retain, readonly) id < VDViewRotatorFactory > viewRotatorFactory;

// Init + Dealloc
-(id)initWithViewRotatorFactory:(id < VDViewRotatorFactory >)viewRotatorFactory;
-(void)dealloc;

// View Registration
-(void)registerRotatingViewWithAccessKey:(NSString *)accessKey fromPrimaryViewController:(UIViewController *)primaryViewController alternateViewController:(UIViewController *)alternateViewController alternateOrientation:(UIInterfaceOrientation)alternateOrientation;
-(void)registerRotatingView:(UIView *)rotatingView withAlternateView:(UIView *)alternateView alternateOrientation:(UIInterfaceOrientation)alternateOrientation withAccessKey:(NSString *)accessKey;

// View De-registration
-(void)registerViewForRotation:(UIView *)rotatingView withViewRotator:(id <VDViewRotator >)viewRotator;
-(void)deregisterViewForRotation:(UIView *)rotatingView;
-(void)deregisterAllRotatingViews;

// Managing Associated View Rotators
-(id < VDViewRotator >)viewRotatorForView:(UIView *)view withAccessKey:(NSString *)accessKey;
-(void)associateViewRotator:(id < VDViewRotator >)viewRotator withView:(UIView *)rotatingView;
-(id < VDViewRotator >)retrieveAssociatedViewRotatorForRotatingView:(UIView *)rotatingView;
-(void)removeAssociatedViewRotatorFromRotatingView:(UIView *)rotatingView;

// VDViewControllerRotationDelegate
-(void)viewController:(UIViewController *)viewController willRotateToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation duration:(NSTimeInterval)duration;
-(void)viewController:(UIViewController *)viewController willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)newOrientation duration:(NSTimeInterval)duration;
-(void)viewController:(UIViewController *)viewController didRotateToInterfaceOrientation:(UIInterfaceOrientation)newOrientation;

@end
