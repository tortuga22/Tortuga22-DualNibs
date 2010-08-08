//
//  VDButtonStateSpecification.m
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import "VDButtonStateSpecification.h"

@interface VDButtonStateSpecification ()

// Synthesized Properties
@property(nonatomic, retain, readwrite) NSString *title;
@property(nonatomic, retain, readwrite) UIImage *image;
@property(nonatomic, retain, readwrite) UIColor *titleColor;
@property(nonatomic, retain, readwrite) UIColor *titleShadowColor;
@property(nonatomic, retain, readwrite) UIImage *backgroundImage;
@property(nonatomic, assign, readwrite) BOOL prefersTitlesToImages;

@end

@implementation VDButtonStateSpecification

#pragma mark Synthesized Properties
@synthesize title = _title;
@synthesize image = _image;
@synthesize titleColor = _titleColor;
@synthesize titleShadowColor = _titleShadowColor;
@synthesize backgroundImage = _backgroundImage;
@synthesize prefersTitlesToImages = _prefersTitlesToImages;

#pragma mark Init + Dealloc
-(id)init {
	return [self initToPreferTitlesToImages:[[self class] prefersTitlesToImages]];
}

-(id)initToPreferTitlesToImages:(BOOL)prefersTitlesToImages {
	if (self = [super init]) {
		self.prefersTitlesToImages = prefersTitlesToImages;
	}
	return self;
}

#pragma mark -
-(void)dealloc {
	self.title = nil;
	self.image = nil;
	self.titleColor = nil;
	self.titleShadowColor = nil;
	self.backgroundImage = nil;
	[super dealloc];
}

#pragma mark Casting
-(UIButton *)castControlToButton:(UIControl *)control {
	UIButton *button = nil;
	if (control) {
		if ([control isKindOfClass:[UIButton class]]) {
			button = ((UIButton *)control);
		}
	}
	return button;
}

#pragma mark VDControlStateSpecification Overrides
-(void)actuallyCopySpecificationFromControl:(UIControl *)control forControlState:(UIControlState)controlState {
	VDParameterAssert(control != nil);
	VDParameterAssert([control isKindOfClass:[UIControl class]]);
	UIButton *button = [self castControlToButton:control];
	if (button) {
		[self copySpecificationFromButton:button 
						  forControlState:controlState];
	}
}

-(void)actuallyConfigureControlToSpecification:(UIControl *)control forControlState:(UIControlState)controlState {
	VDParameterAssert(control != nil);
	VDParameterAssert([control isKindOfClass:[UIControl class]]);
	UIButton *button = [self castControlToButton:control];
	if (button) {
		[self configureButtonToSpecification:button 
							 forControlState:controlState];
	}
}

#pragma mark Button Configuration
-(void)copySpecificationFromButton:(UIButton *)button forControlState:(UIControlState)controlState {
	VDParameterAssert(button != nil);
	VDParameterAssert([button isKindOfClass:[UIButton class]]);
	if (button) {
		[self setImage:[button imageForState:controlState]];
		[self setTitle:[button titleForState:controlState]];
		[self setTitleColor:[button titleColorForState:controlState]];
		[self setTitleShadowColor:[button titleShadowColorForState:controlState]];
		[self setBackgroundImage:[button backgroundImageForState:controlState]];
	}
}

-(void)configureButtonToSpecification:(UIButton *)button forControlState:(UIControlState)controlState {
	VDParameterAssert(button != nil);
	VDParameterAssert([button isKindOfClass:[UIButton class]]);
	// This is a little confusing, and may be redundant upon further investigation.
	// It was a work around for what is look like a poor use of UIButton in the code
	// this library was extracted from, and in the future the prefersTitlesToImages
	// flag and checks can probably be eliminated.
	if (button) {
		if ([self prefersTitlesToImages]) {
			if (self.title) {
				[button setImage:nil forState:controlState];
				[button setTitle:self.title forState:controlState];
				[button setTitleColor:self.titleColor forState:controlState];
				[button setTitleShadowColor:self.titleShadowColor forState:controlState];
				[button setBackgroundImage:self.backgroundImage forState:controlState];
			} else {
				[button setImage:self.image forState:controlState];
				[button setTitle:nil forState:controlState];
				[button setTitleColor:nil forState:controlState];
				[button setTitleShadowColor:nil forState:controlState];
				[button setBackgroundImage:self.backgroundImage forState:controlState];
			}
		} else {
			if (self.image) {
				[button setImage:self.image forState:controlState];
				[button setTitle:nil forState:controlState];
				[button setTitleColor:nil forState:controlState];
				[button setTitleShadowColor:nil forState:controlState];
				[button setBackgroundImage:self.backgroundImage forState:controlState];
			} else {
				[button setImage:nil forState:controlState];
				[button setTitle:self.title forState:controlState];
				[button setTitleColor:self.titleColor forState:controlState];
				[button setTitleShadowColor:self.titleShadowColor forState:controlState];
				[button setBackgroundImage:self.backgroundImage forState:controlState];
			}
		}
	}
}

#pragma mark Classlevel Defaults
+(BOOL)prefersTitlesToImages {
	return NO;
}

@end
