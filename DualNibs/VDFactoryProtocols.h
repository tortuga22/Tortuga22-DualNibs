//
//  VDFactoryProtocols.h
//  DualNibs
//
//  Copyright 2010 Tortuga 22, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VDViewRotator;
@protocol VDViewRotatorFactory;
@protocol VDViewRotatorFactoryPseudoDelegate;

@protocol VDViewRotatorFactory < NSObject >

-(VDViewRotator *)viewRotatorForView:(UIView *)view withAccessKey:(NSString *)accessKey;

@end

@protocol VDViewRotatorFactoryDelegate < NSObject >

-(Class)viewRotatorFactory:(id < VDViewRotatorFactory >)viewRotatorFactory proposesToUseViewSpecificationClass:(Class)proposedViewSpecificationClass whenConstructingViewRotatorForView:(UIView *)view withAccessKey:(NSString *)accessKey;
-(void)viewRotatorFactory:(id < VDViewRotatorFactory >)viewRotatorFactory constructedViewRotator:(VDViewRotator *)viewRotator forView:(UIView *)view withAccessKey:(NSString *)accessKey;

@end

