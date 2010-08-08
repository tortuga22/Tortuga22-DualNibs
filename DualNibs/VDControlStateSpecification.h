//
//  VDControlStateSpecification.h
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VDDualNibsProtocols.h"

@interface VDControlStateSpecification : NSObject < VDControlStateSpecification > {
}

// VDControlStateSpecification Methods
-(void)copySpecificationFromControl:(UIControl *)control forControlState:(UIControlState)controlState;
-(void)configureControlToSpecification:(UIControl *)control forControlState:(UIControlState)controlState;

// Utilities
-(void)actuallyCopySpecificationFromControl:(UIControl *)control forControlState:(UIControlState)controlState;
-(void)actuallyConfigureControlToSpecification:(UIControl *)control forControlState:(UIControlState)controlState;

@end
