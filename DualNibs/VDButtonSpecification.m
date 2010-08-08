//
//  VDButtonSpecification.m
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import "VDButtonSpecification.h"
#import "VDButtonStateSpecification.h"

@interface VDButtonSpecification ()

// Synthesized Properties
@property(nonatomic, assign, readwrite) BOOL reversesTitleShadowWhenHighlighted;
@property(nonatomic, assign, readwrite) BOOL adjustsImageWhenHighlighted;
@property(nonatomic, assign, readwrite) BOOL adjustsImageWhenDisabled;
@property(nonatomic, assign, readwrite) BOOL showsTouchWhenHighlighted;
@property(nonatomic, assign, readwrite) UIEdgeInsets contentEdgeInsets;
@property(nonatomic, assign, readwrite) UIEdgeInsets titleEdgeInsets;
@property(nonatomic, assign, readwrite) UIEdgeInsets imageEdgeInsets;
@property(nonatomic, retain, readwrite) id < VDControlStateSpecification > normalStateSpecification;
@property(nonatomic, retain, readwrite) id < VDControlStateSpecification > highlightedStateSpecification;
@property(nonatomic, retain, readwrite) id < VDControlStateSpecification > selectedStateSpecification;
@property(nonatomic, retain, readwrite) id < VDControlStateSpecification > disabledStateSpecification;

@end

@implementation VDButtonSpecification 

#pragma mark Synthesized Properties
@synthesize reversesTitleShadowWhenHighlighted = _reversesTitleShadowWhenHighlighted;
@synthesize adjustsImageWhenHighlighted = _adjustsImageWhenHighlighted;
@synthesize adjustsImageWhenDisabled = _adjustsImageWhenDisabled;
@synthesize showsTouchWhenHighlighted = _showsTouchWhenHighlighted;
@synthesize contentEdgeInsets = _contentEdgeInsets;
@synthesize titleEdgeInsets = _titleEdgeInsets;
@synthesize imageEdgeInsets = _imageEdgeInsets;
@synthesize normalStateSpecification = _normalStateSpecification;
@synthesize highlightedStateSpecification = _highlightedStateSpecification;
@synthesize selectedStateSpecification = _selectedStateSpecification;
@synthesize disabledStateSpecification = _disabledStateSpecification;

@synthesize prefersTitlesToImages = _prefersTitlesToImages;

#pragma mark Init + Dealloc
-(id)init {
	return [self initToPreferTitlesToImages:[[self class] prefersTitlesToImages]];
}

-(id)initToPreferTitlesToImages:(BOOL)prefersTitlesToImages {
	if (self = [super init]) {
		self.prefersTitlesToImages = prefersTitlesToImages;
		self.normalStateSpecification = [[self class] constructControlStateSpecification];
		self.highlightedStateSpecification = [[self class] constructControlStateSpecification];
		self.selectedStateSpecification = [[self class] constructControlStateSpecification];
		self.disabledStateSpecification = [[self class] constructControlStateSpecification];
	}
	return self;
}

#pragma mark -
-(void)dealloc {
	self.normalStateSpecification = nil;
	self.highlightedStateSpecification = nil;
	self.selectedStateSpecification = nil;
	self.disabledStateSpecification = nil;
	[super dealloc];
}

#pragma mark Casting Utility
-(UIButton *)castViewToButton:(UIView *)view {
	UIButton *button = nil;
	if (view) {
		if ([view isKindOfClass:[UIView class]]) {
			button = ((UIButton *)view);
		}
	}
	return button;
}

#pragma mark  Copying Overrides + Utilities
-(void)actuallyCopySpecificationFromView:(UIView *)view {
	[super actuallyCopySpecificationFromView:view];
	UIButton *button = [self castViewToButton:view];
	if (button) {
		[self copyButtonLevelPropertiesFromButton:button];
		[self copyControlStateLevelPropertiesFromButton:button];
	}
}

-(void)copyButtonLevelPropertiesFromButton:(UIButton *)button {
	VDParameterAssert(button != nil);
	VDParameterAssert([button isKindOfClass:[UIButton class]]);
	if (button) {
		@try {
			[self actuallyCopyButtonLevelPropertiesFromButton:button];
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
	}
}

-(void)actuallyCopyButtonLevelPropertiesFromButton:(UIButton *)button {
	VDParameterAssert(button != nil);
	VDParameterAssert([button isKindOfClass:[UIButton class]]);
	if (button) {
		[self setReversesTitleShadowWhenHighlighted:[button reversesTitleShadowWhenHighlighted]];
		[self setAdjustsImageWhenHighlighted:[button adjustsImageWhenHighlighted]];
		[self setAdjustsImageWhenDisabled:[button adjustsImageWhenDisabled]];
		[self setShowsTouchWhenHighlighted:[button showsTouchWhenHighlighted]];
		[self setContentEdgeInsets:[button contentEdgeInsets]];
		[self setTitleEdgeInsets:[button titleEdgeInsets]];
		[self setImageEdgeInsets:[button imageEdgeInsets]];
	}
}

-(void)copyControlStateLevelPropertiesFromButton:(UIButton *)button {
	VDParameterAssert(button != nil);
	VDParameterAssert([button isKindOfClass:[UIButton class]]);
	if (button) {
		@try {
			[self actuallyCopyControlStateLevelPropertiesFromButton:button];
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
	}
}
-(void)actuallyCopyControlStateLevelPropertiesFromButton:(UIButton *)button {
	VDParameterAssert(button != nil);
	VDParameterAssert([button isKindOfClass:[UIButton class]]);
	VDAssert(self.normalStateSpecification != nil, @"Shouldn't ever get here with nil self.normalStateSpecification.");
	VDAssert(self.highlightedStateSpecification != nil, @"Shouldn't ever get here with nil self.highlightedStateSpecification");
	VDAssert(self.selectedStateSpecification != nil, @"Shouldn't ever get here with nil self.selectedStateSpecification.");
	VDAssert(self.disabledStateSpecification != nil, @"Shouldn't ever get here with nil self.disabledStateSpecification");
	if (button) {
		[self.normalStateSpecification copySpecificationFromControl:button 
													forControlState:UIControlStateNormal];
		[self.highlightedStateSpecification copySpecificationFromControl:button 
														 forControlState:UIControlStateHighlighted];
		[self.selectedStateSpecification copySpecificationFromControl:button 
													  forControlState:UIControlStateSelected];
		[self.disabledStateSpecification copySpecificationFromControl:button 
													  forControlState:UIControlStateDisabled];
	}	
}

-(void)actuallyChangeViewContent:(UIView *)view {
	[super actuallyChangeViewContent:view];
	UIButton *button = [self castViewToButton:view];
	if (button) {
		[self configureButtonLevelPropertiesToSpecification:button];
		[self configureControlStateLevelPropertiesToSpecification:button];
	}
}

#pragma mark Configuration Overrides + Utilities
-(void)actuallyConfigureViewToSpecification:(UIView *)view {
	[super actuallyConfigureViewToSpecification:view];
	UIButton *button = [self castViewToButton:view];
	if (button) {
		[self configureButtonLevelPropertiesToSpecification:button];
		[self configureControlStateLevelPropertiesToSpecification:button];
	}
}

-(void)configureButtonLevelPropertiesToSpecification:(UIButton *)button {
	VDParameterAssert(button != nil);
	VDParameterAssert([button isKindOfClass:[UIButton class]]);
	if (button) {
		@try {
			[self actuallyConfigureButtonLevelPropertiesToSpecification:button];
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
	}
}

-(void)actuallyConfigureButtonLevelPropertiesToSpecification:(UIButton *)button {
	VDParameterAssert(button != nil);
	VDParameterAssert([button isKindOfClass:[UIButton class]]);
	if (button) {
		[button setReversesTitleShadowWhenHighlighted:[self reversesTitleShadowWhenHighlighted]];
		[button setAdjustsImageWhenHighlighted:[self adjustsImageWhenHighlighted]];
		[button setAdjustsImageWhenDisabled:[self adjustsImageWhenDisabled]];
		[button setShowsTouchWhenHighlighted:[self showsTouchWhenHighlighted]];
		[button setContentEdgeInsets:[self contentEdgeInsets]];
		[button setTitleEdgeInsets:[self titleEdgeInsets]];
		[button setImageEdgeInsets:[self imageEdgeInsets]];
	}
}

-(void)configureControlStateLevelPropertiesToSpecification:(UIButton *)button {
	VDParameterAssert(button != nil);
	VDParameterAssert([button isKindOfClass:[UIButton class]]);
	if (button) {
		@try {
			[self actuallyConfigureControlStateLevelPropertiesToSpecification:button];
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
	}
}

-(void)actuallyConfigureControlStateLevelPropertiesToSpecification:(UIButton *)button {
	VDParameterAssert(button != nil);
	VDParameterAssert([button isKindOfClass:[UIButton class]]);
	VDAssert(self.normalStateSpecification != nil, @"Shouldn't ever get here with nil self.normalStateSpecification.");
	VDAssert(self.highlightedStateSpecification != nil, @"Shouldn't ever get here with nil self.highlightedStateSpecification");
	VDAssert(self.selectedStateSpecification != nil, @"Shouldn't ever get here with nil self.selectedStateSpecification.");
	VDAssert(self.disabledStateSpecification != nil, @"Shouldn't ever get here with nil self.disabledStateSpecification");
	if (button) {
		[self.normalStateSpecification configureControlToSpecification:button 
													   forControlState:UIControlStateNormal];
		[self.highlightedStateSpecification configureControlToSpecification:button 
															forControlState:UIControlStateHighlighted];
		[self.selectedStateSpecification configureControlToSpecification:button 
														 forControlState:UIControlStateSelected];
		[self.disabledStateSpecification configureControlToSpecification:button 
														 forControlState:UIControlStateDisabled];
	}
}

#pragma mark Classlevel Stuff
+(BOOL)prefersTitlesToImages {
	return NO;
}

+(id < VDControlStateSpecification >)constructControlStateSpecification {
	return [[[VDButtonStateSpecification alloc] initToPreferTitlesToImages:[self prefersTitlesToImages]] autorelease];
}

@end
