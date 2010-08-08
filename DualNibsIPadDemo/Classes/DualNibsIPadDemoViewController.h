//
//  DualNibsIPadDemoViewController.h
//  DualNibsIPadDemo
//
//  Copyright Tortuga 22, Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VDDualNibs.h>

@interface DualNibsIPadDemoViewController : VDDualNibViewController {

}

@property(nonatomic, retain) IBOutlet UILabel *catFacesLabel;
@property(nonatomic, retain) IBOutlet UILabel *fontChangingLabel;
@property(nonatomic, retain) IBOutlet UILabel *kingOfThreadsLabel;
@property(nonatomic, retain) IBOutlet UILabel *catToothbrushLabel;
@property(nonatomic, retain) IBOutlet UILabel *buttonsCaptionLabel;

@property(nonatomic, retain) IBOutlet UIImageView *leftCatFaceImageView;
@property(nonatomic, retain) IBOutlet UIImageView *centerCatFaceImageView;
@property(nonatomic, retain) IBOutlet UIImageView *rightCatFaceImageView;
@property(nonatomic, retain) IBOutlet UIImageView *kingOfThreadsImageView;
@property(nonatomic, retain) IBOutlet UIImageView *catToothbrushImageView;

@property(nonatomic, retain) IBOutlet UIButton *button1;
@property(nonatomic, retain) IBOutlet UIButton *button2;
@property(nonatomic, retain) IBOutlet UIButton *button3;
@property(nonatomic, retain) IBOutlet UIButton *button4;
@property(nonatomic, retain) IBOutlet UIButton *button5;
@property(nonatomic, retain) IBOutlet UIButton *button6;
@property(nonatomic, retain) IBOutlet UIButton *button7;
@property(nonatomic, retain) IBOutlet UIButton *button8;
@property(nonatomic, retain) IBOutlet UIButton *button9;

// Somehow disappeared from IB
@property(nonatomic, retain) IBOutlet UIView *view;

@end

