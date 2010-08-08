//
//  VDLabelSpecification.m
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import "VDLabelSpecification.h"

@interface VDLabelSpecification ()

// Synthesized Properties
@property(nonatomic, retain, readwrite) NSString *text;
@property(nonatomic, retain, readwrite) UIFont *font;
@property(nonatomic, retain, readwrite) UIColor *textColor;
@property(nonatomic, retain, readwrite) UIColor *shadowColor;
@property(nonatomic, retain, readwrite) UIColor *highlightedTextColor;
@property(nonatomic, assign, readwrite) CGSize shadowOffset;
@property(nonatomic, assign, readwrite) UITextAlignment textAlignment;
@property(nonatomic, assign, readwrite) UILineBreakMode lineBreakMode;
@property(nonatomic, assign, readwrite) UIBaselineAdjustment baselineAdjustment;
@property(nonatomic, assign, readwrite) NSInteger numberOfLines;
@property(nonatomic, assign, readwrite) BOOL adjustsFontSizeToFitWidth;
@property(nonatomic, assign, readwrite) CGFloat minimumFontSize;

@end


@implementation VDLabelSpecification

#pragma mark Synthesized Properties
@synthesize text = _text;
@synthesize font = _font;
@synthesize textColor = _textColor;
@synthesize shadowColor = _shadowColor;
@synthesize highlightedTextColor = _highlightedTextColor;
@synthesize shadowOffset = _shadowOffset;
@synthesize textAlignment = _textAlignment;
@synthesize lineBreakMode = _lineBreakMode;
@synthesize baselineAdjustment = _baselineAdjustment;
@synthesize numberOfLines = _numberOfLines;
@synthesize adjustsFontSizeToFitWidth = _adjustsFontSizeToFitWidth;
@synthesize minimumFontSize = _minimumFontSize;

#pragma mark Init + Dealloc
-(void)dealloc {
	self.text = nil;
	self.font = nil;
	self.textColor = nil;
	self.shadowColor = nil;
	self.highlightedTextColor = nil;
	[super dealloc];
}

#pragma mark Casting Utility
-(UILabel *)castViewToLabel:(UIView *)view {
	VDParameterAssert(view != nil);
	VDParameterAssert([view isKindOfClass:[UIView class]]);
	UILabel *label = nil;
	if (view) {
		if ([view isKindOfClass:[UILabel class]]) {
			label = ((UILabel *)view);
		}
	}
	return label;
}

#pragma mark Copying Overrides + Utilities
-(void)actuallyCopySpecificationFromView:(UIView *)view {
	VDParameterAssert(view != nil);
	VDParameterAssert([view isKindOfClass:[UIView class]]);
	[super actuallyCopySpecificationFromView:view];
	UILabel *casted = [self castViewToLabel:view];
	if (casted) {
		@try {
			[self copyLabelLevelPropertiesFromLabel:casted];
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
	}
}

-(void)copyLabelLevelPropertiesFromLabel:(UILabel *)label {
	VDParameterAssert(label != nil);
	VDParameterAssert([label isKindOfClass:[UILabel class]]);
	if (label) {
		[self setText:[label text]];
		[self setFont:[label font]];
		[self setTextColor:[label textColor]];
		[self setShadowColor:[label shadowColor]];
		[self setHighlightedTextColor:[label highlightedTextColor]];
		[self setShadowOffset:[label shadowOffset]];
		[self setAdjustsFontSizeToFitWidth:[label adjustsFontSizeToFitWidth]];
		[self setMinimumFontSize:[label minimumFontSize]];
		[self setNumberOfLines:[label numberOfLines]];
		[self setLineBreakMode:[label lineBreakMode]];
		[self setTextAlignment:[label textAlignment]];
		[self setBaselineAdjustment:[label baselineAdjustment]];
	}
}

#pragma mark Configuration Overrides + Utilities
-(void)actuallyChangeViewContent:(UIView *)view {
	VDParameterAssert(view != nil);
	VDParameterAssert([view isKindOfClass:[UIView class]]);
	[super actuallyCopySpecificationFromView:view];
	UILabel *casted = [self castViewToLabel:view];
	if (casted) {
		@try {
			[self configureLabelLevelPropertiesToSpecification:casted];
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
	}
}

-(void)configureLabelLevelPropertiesToSpecification:(UILabel *)label {
	VDParameterAssert(label != nil);
	VDParameterAssert([label isKindOfClass:[UILabel class]]);
	if (label) {
		[label setText:[self text]];
		[label setFont:[self font]];
		[label setTextColor:[self textColor]];
		[label setShadowColor:[self shadowColor]];
		[label setHighlightedTextColor:[self highlightedTextColor]];
		[label setShadowOffset:[self shadowOffset]];
		[label setAdjustsFontSizeToFitWidth:[self adjustsFontSizeToFitWidth]];
		[label setMinimumFontSize:[self minimumFontSize]];
		[label setNumberOfLines:[self numberOfLines]];
		[label setLineBreakMode:[self lineBreakMode]];
		[label setTextAlignment:[self textAlignment]];
		[label setBaselineAdjustment:[self baselineAdjustment]];
	}
}

@end
