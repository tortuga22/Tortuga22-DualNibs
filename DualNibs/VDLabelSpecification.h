//
//  VDLabelSpecification.h
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VDDualNibsProtocols.h"
#import "VDContentCarryingViewSpecification.h"

@interface VDLabelSpecification : VDContentCarryingViewSpecification {
	NSString *_text;
	UIFont *_font;
	UIColor *_textColor;
	UIColor *_shadowColor;
	UIColor *_highlightedTextColor;
	CGSize _shadowOffset;
	UITextAlignment _textAlignment;
	UILineBreakMode _lineBreakMode;
	UIBaselineAdjustment _baselineAdjustment;
	NSInteger _numberOfLines;
	BOOL _adjustsFontSizeToFitWidth;
	CGFloat _minimumFontSize;
}

// Synthesized Properties
@property(nonatomic, retain, readonly) NSString *text;
@property(nonatomic, retain, readonly) UIFont *font;
@property(nonatomic, retain, readonly) UIColor *textColor;
@property(nonatomic, retain, readonly) UIColor *shadowColor;
@property(nonatomic, retain, readonly) UIColor *highlightedTextColor;
@property(nonatomic, assign, readonly) CGSize shadowOffset;
@property(nonatomic, assign, readonly) UITextAlignment textAlignment;
@property(nonatomic, assign, readonly) UILineBreakMode lineBreakMode;
@property(nonatomic, assign, readonly) UIBaselineAdjustment baselineAdjustment;
@property(nonatomic, assign, readonly) NSInteger numberOfLines;
@property(nonatomic, assign, readonly) BOOL adjustsFontSizeToFitWidth;
@property(nonatomic, assign, readonly) CGFloat minimumFontSize;

// Init + Dealloc
-(void)dealloc;

// Casting Utility
-(UILabel *)castViewToLabel:(UIView *)view;

// Copying Overrides + Utilities
-(void)actuallyCopySpecificationFromView:(UIView *)view;
-(void)copyLabelLevelPropertiesFromLabel:(UILabel *)label;
-(void)actuallyChangeViewContent:(UIView *)view;

// Configuration Overrides + Utilities
-(void)configureLabelLevelPropertiesToSpecification:(UILabel *)label;

@end
