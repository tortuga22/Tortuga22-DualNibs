//
//  VDButtonSpecification.h
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VDDualNibsProtocols.h"
#import "VDContentCarryingViewSpecification.h"

@interface VDButtonSpecification : VDContentCarryingViewSpecification {
	BOOL _reversesTitleShadowWhenHighlighted;
	BOOL _adjustsImageWhenHighlighted;
	BOOL _adjustsImageWhenDisabled;
	BOOL _showsTouchWhenHighlighted;
	UIEdgeInsets _contentEdgeInsets;
	UIEdgeInsets _titleEdgeInsets;
	UIEdgeInsets _imageEdgeInsets;
	id < VDControlStateSpecification > _normalStateSpecification;
	id < VDControlStateSpecification > _highlightedStateSpecification;
	id < VDControlStateSpecification > _selectedStateSpecification;
	id < VDControlStateSpecification > _disabledStateSpecification;
	
	BOOL _prefersTitlesToImages;
}

// Synthesized Properties
@property(nonatomic, assign, readonly) BOOL reversesTitleShadowWhenHighlighted;
@property(nonatomic, assign, readonly) BOOL adjustsImageWhenHighlighted;
@property(nonatomic, assign, readonly) BOOL adjustsImageWhenDisabled;
@property(nonatomic, assign, readonly) BOOL showsTouchWhenHighlighted;
@property(nonatomic, assign, readonly) UIEdgeInsets contentEdgeInsets;
@property(nonatomic, assign, readonly) UIEdgeInsets titleEdgeInsets;
@property(nonatomic, assign, readonly) UIEdgeInsets imageEdgeInsets;
@property(nonatomic, retain, readonly) id < VDControlStateSpecification > normalStateSpecification;
@property(nonatomic, retain, readonly) id < VDControlStateSpecification > highlightedStateSpecification;
@property(nonatomic, retain, readonly) id < VDControlStateSpecification > selectedStateSpecification;
@property(nonatomic, retain, readonly) id < VDControlStateSpecification > disabledStateSpecification;

@property(nonatomic, assign) BOOL prefersTitlesToImages;

// Init + Dealloc
-(id)init;
-(id)initToPreferTitlesToImages:(BOOL)prefersTitlesToImages;
-(void)dealloc;

// Casting Utility
-(UIButton *)castViewToButton:(UIView *)view;

// Copying Overrides + Utilities
-(void)actuallyCopySpecificationFromView:(UIView *)view;
-(void)copyButtonLevelPropertiesFromButton:(UIButton *)button;
-(void)actuallyCopyButtonLevelPropertiesFromButton:(UIButton *)button;
-(void)copyControlStateLevelPropertiesFromButton:(UIButton *)button;
-(void)actuallyCopyControlStateLevelPropertiesFromButton:(UIButton *)button;

// Configuring Overrides + Utilities
-(void)actuallyChangeViewContent:(UIView *)view;
-(void)actuallyConfigureViewToSpecification:(UIView *)view;
-(void)configureButtonLevelPropertiesToSpecification:(UIButton *)button;
-(void)actuallyConfigureButtonLevelPropertiesToSpecification:(UIButton *)button;
-(void)configureControlStateLevelPropertiesToSpecification:(UIButton *)button;
-(void)actuallyConfigureControlStateLevelPropertiesToSpecification:(UIButton *)button;

// Classlevel Stuff
+(BOOL)prefersTitlesToImages;
+(id < VDControlStateSpecification >)constructControlStateSpecification;

@end