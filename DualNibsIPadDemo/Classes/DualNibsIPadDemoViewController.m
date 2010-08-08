//
//  DualNibsIPadDemoViewController.m
//  DualNibsIPadDemo
//
//  Copyright Tortuga 22, Inc 2010. All rights reserved.
//

#import "DualNibsIPadDemoViewController.h"

@implementation DualNibsIPadDemoViewController

@synthesize catFacesLabel;
@synthesize fontChangingLabel;
@synthesize kingOfThreadsLabel;
@synthesize catToothbrushLabel;
@synthesize buttonsCaptionLabel;

@synthesize leftCatFaceImageView;
@synthesize centerCatFaceImageView;
@synthesize rightCatFaceImageView;
@synthesize kingOfThreadsImageView;
@synthesize catToothbrushImageView;

@synthesize button1;
@synthesize button2;
@synthesize button3;
@synthesize button4;
@synthesize button5;
@synthesize button6;
@synthesize button7;
@synthesize button8;
@synthesize button9;

// Not sure why this disappeared from IB
@dynamic view;

+(void)actuallyAddKeysForRotatingViews:(NSMutableSet *)targetSet {
	[super actuallyAddKeysForRotatingViews:targetSet];
	if (targetSet) {
		[targetSet addObject:@"catFacesLabel"];
		[targetSet addObject:@"fontChangingLabel"];
		[targetSet addObject:@"kingOfThreadsLabel"];
		[targetSet addObject:@"catToothbrushLabel"];
		[targetSet addObject:@"buttonsCaptionLabel"];

		[targetSet addObject:@"leftCatFaceImageView"];
		[targetSet addObject:@"centerCatFaceImageView"];
		[targetSet addObject:@"rightCatFaceImageView"];
		[targetSet addObject:@"kingOfThreadsImageView"];
		[targetSet addObject:@"catToothbrushImageView"];

		[targetSet addObject:@"button1"];
		[targetSet addObject:@"button2"];
		[targetSet addObject:@"button3"];
		[targetSet addObject:@"button4"];
		[targetSet addObject:@"button5"];
		[targetSet addObject:@"button6"];
		[targetSet addObject:@"button7"];
		[targetSet addObject:@"button8"];
		[targetSet addObject:@"button9"];
	}
}

@end
