//
//  VDContentCarryingViewSpecification.h
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VDDualNibsProtocols.h"
#import "VDViewSpecification.h"

@interface VDContentCarryingViewSpecification : VDViewSpecification {
	BOOL _changesContentAfterMovement;
}

// Synthesized Properties
@property(nonatomic, assign) BOOL changesContentAfterMovement;

// Init + Dealloc
-(id)init;
-(id)initToChangeContentAfterMovmement:(BOOL)changesContentAfterMovement;

// Content Changing
-(void)changeViewContent:(UIView *)view;
-(void)actuallyChangeViewContent:(UIView *)view;

// VDViewSpecification Overrides
-(void)actuallyPerformPreRotationMovementViewConfiguration:(UIView *)view;
-(void)actuallyPerformPostRotationMovementViewConfiguration:(UIView *)view;

// Class Defaults
+(BOOL)changesContentAfterMovement;

@end
