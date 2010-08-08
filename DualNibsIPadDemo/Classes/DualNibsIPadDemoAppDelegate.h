//
//  DualNibsIPadDemoAppDelegate.h
//  DualNibsIPadDemo
//
//  Copyright Tortuga 22, Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DualNibsIPadDemoViewController;

@interface DualNibsIPadDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    DualNibsIPadDemoViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DualNibsIPadDemoViewController *viewController;

@end

