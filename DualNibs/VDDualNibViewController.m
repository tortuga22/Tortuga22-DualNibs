//
//  VDDualNibViewController.m
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import "VDDualNibViewController.h"
#import "VDViewControllerRotationManager.h"
#import "VDViewRotatorFactory.h"

@interface VDDualNibViewController ()

// Synthesized Properties
@property(nonatomic, retain, readwrite) VDViewControllerRotationManager *viewControllerRotationManager;
@property(nonatomic, assign, readwrite) BOOL isAlternateViewController;
@property(nonatomic, retain, readwrite) NSString *alternateOrientationNibName;
@property(nonatomic, retain, readwrite) NSBundle *alternateOrientationNibBundle;
@property(nonatomic, assign, readwrite) UIInterfaceOrientation alternateOrientation;

@end

@implementation VDDualNibViewController

#pragma mark Synthesized Properties
@synthesize viewControllerRotationManager = _viewControllerRotationManager;
@synthesize isAlternateViewController = _isAlternateViewController;
@synthesize alternateOrientationNibName = _alternateOrientationNibName;
@synthesize alternateOrientationNibBundle = _alternateOrientationNibBundle;
@synthesize alternateOrientation = _alternateOrientation;

#pragma mark Init + Dealloc
-(id)initAsAlternateViewControllerWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
	if (self = [super initWithNibName:nibName 
							   bundle:bundle]) {
		self.isAlternateViewController = YES;
	}
	return self;
}

-(id)initWithBundle:(NSBundle *)bundle {
	UIInterfaceOrientation currentOrientation = [[UIDevice currentDevice] orientation];
	UIInterfaceOrientation alternateOrientation;
	NSString *primaryNibName = nil;
	NSString *alternateNibName = nil;
	if (UIInterfaceOrientationIsPortrait(currentOrientation)) {
		primaryNibName = [[self class] portraitNibName];
		alternateNibName = [[self class] landscapeNibName];
		alternateOrientation = UIInterfaceOrientationLandscapeLeft;
	} else {
		primaryNibName = [[self class] landscapeNibName];
		alternateNibName = [[self class] portraitNibName];
		alternateOrientation = UIInterfaceOrientationPortrait;		
	}
	return [self initWithPrimaryNibName:primaryNibName 
					   alternateNibName:alternateNibName 
				   alternateOrientation:alternateOrientation 
							  nibBundle:bundle];
}
-(id)initWithPrimaryNibName:(NSString *)primaryNibName alternateNibName:(NSString *)alternateNibName alternateOrientation:(UIInterfaceOrientation)alternateOrientation nibBundle:(NSBundle *)nibBundle {
	VDParameterAssert(primaryNibName != nil);
	VDParameterAssert([primaryNibName isKindOfClass:[NSString class]]);
	VDParameterAssert(alternateNibName != nil);
	VDParameterAssert([alternateNibName isKindOfClass:[NSString class]]);
	VDParameterAssert(nibBundle != nil);
	VDParameterAssert([nibBundle isKindOfClass:[NSBundle class]]);
	if (self = [super initWithNibName:primaryNibName 
							   bundle:nibBundle]) {
		self.alternateOrientationNibName = alternateNibName;
		self.alternateOrientationNibBundle = nibBundle;
		self.isAlternateViewController = NO;
		self.alternateOrientation = alternateOrientation;
	}
	return self;
}

#pragma mark
-(void)dealloc {
	self.viewControllerRotationManager = nil;
	self.alternateOrientationNibName = nil;
	self.alternateOrientationNibBundle = nil;
	[super dealloc];
}

#pragma mark Lifecycle Overrides
-(void)viewDidLoad {
	[super viewDidLoad];
	[self performPostLoadContructionActivities];
	
}

-(void)viewDidUnload {
	self.viewControllerRotationManager = nil;
	[super viewDidUnload];
}

-(void)performPostLoadContructionActivities {
	if ([self shouldPerformLightWeightConstruction]) {
		[self performLightWeightConstruction];
	} else {
		[self performHeavyWeightConstruction];
	}
	[self loadRotationConfigurationIfNecessary];
	if ([self shouldPerformLightWeightContentPopulation]) {
		[self performLightWeightContentPopulation];
	} else {
		[self performHeavyWeightContentPopulation];
	}
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return YES;
}

#pragma mark Rotation Overrides
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willRotateToInterfaceOrientation:toInterfaceOrientation 
								   duration:duration];
	if (self.viewControllerRotationManager) {
		[self.viewControllerRotationManager viewController:self 
						  willRotateToInterfaceOrientation:toInterfaceOrientation 
								  fromInterfaceOrientation:[self interfaceOrientation] 
												  duration:duration];
	}
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
	[super willAnimateRotationToInterfaceOrientation:interfaceOrientation 
											duration:duration];
	if (self.viewControllerRotationManager) {
		[self.viewControllerRotationManager viewController:self 
				 willAnimateRotationToInterfaceOrientation:interfaceOrientation 
												  duration:duration];
	}
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	if (self.viewControllerRotationManager) {
		[self.viewControllerRotationManager viewController:self 
						   didRotateToInterfaceOrientation:[self interfaceOrientation]];
	}
}

#pragma mark Configuring For Rotation
-(BOOL)shouldLoadRotationConfiguration {
	// logically: only if both of these are true:
	// - we're NOT the "alternate view controller"
	// - we've got a non-nil alternate nib name
	return VDForceYesOrNo((![self isAlternateViewController]) && (self.alternateOrientationNibName != nil));
}

-(void)loadRotationConfigurationIfNecessary {
	if ([self shouldLoadRotationConfiguration]) {
		@try {
			[self actuallyLoadRotationConfiguration];
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
	}
}
-(void)actuallyLoadRotationConfiguration {
	UIViewController *alternateViewController = nil;
	@try {
		alternateViewController = [[[self class] alloc] initAsAlternateViewControllerWithNibName:self.alternateOrientationNibName 
																						  bundle:self.alternateOrientationNibBundle];
		if (alternateViewController) {
			UIView *view = [alternateViewController view];
			// hack to force it to load view
			if (view) {
				self.viewControllerRotationManager = [[[VDViewControllerRotationManager alloc] initWithViewRotatorFactory:[self viewRotatorFactory]] autorelease];
				if (self.viewControllerRotationManager) {
					[self registerRotatingViewsWithViewControllerManager:self.viewControllerRotationManager 
												 alternateViewController:alternateViewController 
													alternateOrientation:self.alternateOrientation];
				}
			}
		}
	}
	@catch (NSException *e) {
		VDLogException(e);
	}
	@finally {
		if (alternateViewController) {
			[alternateViewController release];
			alternateViewController = nil;
		}
	}
}

#pragma mark -
-(void)registerRotatingViewsWithViewControllerManager:(VDViewControllerRotationManager *)viewControllerRotatorManager alternateViewController:(UIViewController *)alternateViewController alternateOrientation:(UIInterfaceOrientation)alternateOrientation {
	VDParameterAssert(viewControllerRotatorManager != nil);
	VDParameterAssert([viewControllerRotatorManager isKindOfClass:[VDViewControllerRotationManager class]]);
	VDParameterAssert(alternateViewController != nil);
	VDParameterAssert([alternateViewController isKindOfClass:[UIViewController class]]);
	if (viewControllerRotatorManager && alternateViewController) {
		NSSet *keysForRotatingViews = [[self class] keysForRotatingViews];
		if (keysForRotatingViews) {
			for (NSString *rotatingViewKey in keysForRotatingViews) {
				VDAssert([rotatingViewKey isKindOfClass:[NSString class]], @"All rotatingViewKey objects should be instances of NSString.");
				@try {
					[viewControllerRotatorManager registerRotatingViewWithAccessKey:rotatingViewKey 
														  fromPrimaryViewController:self 
															alternateViewController:alternateViewController 
															   alternateOrientation:alternateOrientation];
				}
				@catch (NSException *e) {
					VDLogException(e);
				}
			}
		}
	}
}

#pragma mark Post-Load, Pre-Rotation-Configuration Construction
-(BOOL)shouldPerformLightWeightConstruction {
	return [self isAlternateViewController];
}

-(void)performHeavyWeightConstruction {
	@try {
		[self actuallyPerformHeavyWeightConstruction];
	}
	@catch (NSException *e) {
		VDLogException(e);
	}
}

-(void)performLightWeightConstruction {
	@try {
		[self actuallyPerformLightWeightConstruction];
	}
	@catch (NSException *e) {
		VDLogException(e);
	}
}

#pragma mark -
-(void)actuallyPerformHeavyWeightConstruction {
	
}

-(void)actuallyPerformLightWeightConstruction {
	
}

#pragma mark Populating Content
-(BOOL)shouldPerformLightWeightContentPopulation {
	// logic: for now, only perform lightweight if we're flagged as "alternate" view controller
	return [self isAlternateViewController];
}

-(void)performHeavyWeightContentPopulation {
	@try {
		[self actuallyPerformHeavyWeightContentPopulation];
	}
	@catch (NSException *e) {
		VDLogException(e);
	}
}

-(void)performLightWeightContentPopulation {
	@try {
		[self actuallyPerformLightWeightContentPopulation];
	}
	@catch (NSException *e) {
		VDLogException(e);
	}
}

-(void)actuallyPerformHeavyWeightContentPopulation {
	
}

-(void)actuallyPerformLightWeightContentPopulation {
	
}

#pragma mark VDViewRotatorFactoryDelegate Methods
-(Class)viewRotatorFactory:(id < VDViewRotatorFactory >)viewRotatorFactory proposesToUseViewSpecificationClass:(Class)proposedViewSpecificationClass whenConstructingViewRotatorForView:(UIView *)view withAccessKey:(NSString *)accessKey {
	return proposedViewSpecificationClass;
}

-(void)viewRotatorFactory:(id < VDViewRotatorFactory >)viewRotatorFactory constructedViewRotator:(VDViewRotator *)viewRotator forView:(UIView *)view withAccessKey:(NSString *)accessKey {
	; // who cares?
}

#pragma mark Objectlevel Parameters
-(id < VDViewRotatorFactory >)viewRotatorFactory {
	return [[[VDViewRotatorFactory alloc] initWithDelegate:self] autorelease];
}

#pragma mark Classlevel Parameters
+(NSString *)baseNibName {
	return NSStringFromClass([self class]);
}

+(NSString *)fullNibNameForOrientation:(UIInterfaceOrientation)orientation withBaseNibName:(NSString *)baseNibName {
	VDParameterAssert(baseNibName != nil);
	VDParameterAssert([baseNibName isKindOfClass:[NSString class]]);
	NSString *fullNibName = nil;
	if (baseNibName) {
		if (UIInterfaceOrientationIsPortrait(orientation)) {
			fullNibName = [NSString stringWithFormat:@"%@-Portrait",baseNibName];
		} else {
			fullNibName = [NSString stringWithFormat:@"%@-Landscape",baseNibName];
		}
	}
	return fullNibName;
}

+(NSString *)portraitNibName {
	return [self fullNibNameForOrientation:UIInterfaceOrientationPortrait withBaseNibName:[self baseNibName]];
}

+(NSString *)landscapeNibName {
	return [self fullNibNameForOrientation:UIInterfaceOrientationLandscapeLeft withBaseNibName:[self baseNibName]];
}

#pragma mark
+(NSSet *)keysForRotatingViews {
	NSSet *keysForRotatingViews = nil;
	NSMutableSet *workingSet = nil;
	@try  {
		workingSet = [NSMutableSet set];
		[self addKeysForRotatingViews:workingSet];
	}
	@catch (NSException *e) {
		VDLogException(e);
		workingSet = nil;
	}
	@finally {
		if (workingSet && ([workingSet count] > 0)) {
			keysForRotatingViews = [NSSet setWithSet:workingSet];
		}
	}
	return keysForRotatingViews;
}

+(void)addKeysForRotatingViews:(NSMutableSet *)targetSet {
	if (targetSet) {
		@try {
			[self actuallyAddKeysForRotatingViews:targetSet];
		}
		@catch (NSException *e) {
			VDLogException(e);
		}
	}
}

+(void)actuallyAddKeysForRotatingViews:(NSMutableSet *)targetSet {
	// nothing
}

@end