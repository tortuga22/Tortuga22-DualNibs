//
//  VDRotatorProtocols.h
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VDViewRotator < NSObject >

-(void)copyParametersFromView:(UIView *)view forOrientation:(UIInterfaceOrientation)orientation;

-(void)view:(UIView *)view willRotateToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation duration:(NSTimeInterval)duration;
-(void)view:(UIView *)view willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation duration:(NSTimeInterval)duration;
-(void)view:(UIView *)view didRotateToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation;

@end

@protocol VDInterfaceRotationAwareObject < NSObject >

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation duration:(NSTimeInterval)duration;
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation duration:(NSTimeInterval)duration;
-(void)didRotateToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation;

@end

@protocol VDViewControllerRotationDelegate < NSObject >

-(void)viewController:(UIViewController *)viewController willRotateToInterfaceOrientation:(UIInterfaceOrientation)newOrientation fromInterfaceOrientation:(UIInterfaceOrientation)oldOrientation duration:(NSTimeInterval)duration;
-(void)viewController:(UIViewController *)viewController willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)newOrientation duration:(NSTimeInterval)duration;
-(void)viewController:(UIViewController *)viewController didRotateToInterfaceOrientation:(UIInterfaceOrientation)newOrientation;

@end