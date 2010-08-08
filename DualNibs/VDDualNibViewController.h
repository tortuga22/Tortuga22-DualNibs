//
//  VDDualNibViewController.h
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VDDualNibsProtocols.h"

@class VDViewControllerRotationManager;

@interface VDDualNibViewController : UIViewController < VDViewRotatorFactoryDelegate > {
	VDViewControllerRotationManager *_viewControllerRotationManager;
	BOOL _isAlternateViewController;
	NSString *_alternateOrientationNibName;
	NSBundle *_alternateOrientationNibBundle;
	UIInterfaceOrientation _alternateOrientation;
}

// Synthesized Properties
@property(nonatomic, retain, readonly) VDViewControllerRotationManager *viewControllerRotationManager;
@property(nonatomic, assign, readonly) BOOL isAlternateViewController;
@property(nonatomic, retain, readonly) NSString *alternateOrientationNibName;
@property(nonatomic, retain, readonly) NSBundle *alternateOrientationNibBundle;
@property(nonatomic, assign, readonly) UIInterfaceOrientation alternateOrientation;

// Init + Dealloc
-(id)initAsAlternateViewControllerWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle;
-(id)initWithBundle:(NSBundle *)bundle;
-(id)initWithPrimaryNibName:(NSString *)primaryNibName alternateNibName:(NSString *)alternateNibName alternateOrientation:(UIInterfaceOrientation)alternateOrientation nibBundle:(NSBundle *)bundle;
-(void)dealloc;

// Lifecyle Overrides
-(void)viewDidLoad;
-(void)viewDidUnload;
-(void)performPostLoadContructionActivities;

// Rotation Overrides
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration;
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;

// Configuring For Rotation
-(BOOL)shouldLoadRotationConfiguration;
-(void)loadRotationConfigurationIfNecessary;
-(void)actuallyLoadRotationConfiguration;
-(void)registerRotatingViewsWithViewControllerManager:(VDViewControllerRotationManager *)viewControllerRotatorManager alternateViewController:(UIViewController *)alternateViewController alternateOrientation:(UIInterfaceOrientation)alternateOrientation;

// Post-Load, Pre-Rotation-Configuration Construction
-(BOOL)shouldPerformLightWeightConstruction;
-(void)performHeavyWeightConstruction;
-(void)performLightWeightConstruction;
-(void)actuallyPerformHeavyWeightConstruction;
-(void)actuallyPerformLightWeightConstruction;

// Content Population
-(BOOL)shouldPerformLightWeightContentPopulation;
-(void)performHeavyWeightContentPopulation;
-(void)performLightWeightContentPopulation;
-(void)actuallyPerformHeavyWeightContentPopulation;
-(void)actuallyPerformLightWeightContentPopulation;

// VDViewRotatorFactoryDelegate Methods
-(Class)viewRotatorFactory:(id < VDViewRotatorFactory >)viewRotatorFactory proposesToUseViewSpecificationClass:(Class)proposedViewSpecificationClass whenConstructingViewRotatorForView:(UIView *)view withAccessKey:(NSString *)accessKey;
-(void)viewRotatorFactory:(id < VDViewRotatorFactory >)viewRotatorFactory constructedViewRotator:(VDViewRotator *)viewRotator forView:(UIView *)view withAccessKey:(NSString *)accessKey;

// Object Level Parameterization
-(id < VDViewRotatorFactory >)viewRotatorFactory;

// Classlevel Parameters
+(NSString *)baseNibName;
+(NSString *)fullNibNameForOrientation:(UIInterfaceOrientation)orientation withBaseNibName:(NSString *)baseNibName;
+(NSString *)portraitNibName;
+(NSString *)landscapeNibName;
+(NSSet *)keysForRotatingViews;
+(void)addKeysForRotatingViews:(NSMutableSet *)targetSet;
+(void)actuallyAddKeysForRotatingViews:(NSMutableSet *)targetSet;

@end
