//
//  VDViewRotatorFactory.h
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VDDualNibsProtocols.h"

@class VDViewRotator;

@interface VDViewRotatorFactory : NSObject < VDViewRotatorFactory > {
	id < VDViewRotatorFactoryDelegate > _delegate;
}

// Synthesized Properties
@property(nonatomic, assign, readonly) id < VDViewRotatorFactoryDelegate > delegate;

// Init + Dealloc
-(id)init;
-(id)initWithDelegate:(id < VDViewRotatorFactoryDelegate >)delegate;

// VDViewRotatorFactory Methods
-(VDViewRotator *)viewRotatorForView:(UIView *)view withAccessKey:(NSString *)accessKey;

// Sub-Steps
-(Class)viewSpecificationClassForView:(UIView *)view withAccessKey:(NSString *)accessKey;
-(Class)actuallyProposeViewSpecificationClassForView:(UIView *)view withAccessKey:(NSString *)accessKey;
-(VDViewRotator *)viewRotatorWithViewSpecificationClass:(Class)viewSpecificationClass;

// Classlevel Defaults
+(Class)defaultViewSpecificationClass;

@end
