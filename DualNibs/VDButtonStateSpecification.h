//
//  VDButtonStateSpecification.h
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VDDualNibsProtocols.h"
#import "VDControlStateSpecification.h"

@interface VDButtonStateSpecification : VDControlStateSpecification {
	NSString *_title;
	UIImage *_image;
	UIColor *_titleColor;
	UIColor *_titleShadowColor;
	UIImage *_backgroundImage;
	BOOL _prefersTitlesToImages;
}

// Synthesized Properties
@property(nonatomic, retain, readonly) NSString *title;
@property(nonatomic, retain, readonly) UIImage *image;
@property(nonatomic, retain, readonly) UIColor *titleColor;
@property(nonatomic, retain, readonly) UIColor *titleShadowColor;
@property(nonatomic, retain, readonly) UIImage *backgroundImage;
@property(nonatomic, assign, readonly) BOOL prefersTitlesToImages;

// Init + Dealloc
-(id)init;
-(id)initToPreferTitlesToImages:(BOOL)prefersTitlesToImages;
-(void)dealloc;

// Casting
-(UIButton *)castControlToButton:(UIControl *)control;

// VDControlStateSpecification Overrides
-(void)actuallyCopySpecificationFromControl:(UIControl *)control forControlState:(UIControlState)controlState;
-(void)actuallyConfigureControlToSpecification:(UIControl *)control forControlState:(UIControlState)controlState;

// Button Configuration
-(void)copySpecificationFromButton:(UIButton *)button forControlState:(UIControlState)controlState;
-(void)configureButtonToSpecification:(UIButton *)button forControlState:(UIControlState)controlState;

// Classlevel Defaults
+(BOOL)prefersTitlesToImages;

@end
