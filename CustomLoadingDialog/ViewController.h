//
//  ViewController.h
//  CustomLoadingDialog
//
//  Created by Anthony Alesia on 3/7/12.
//  Copyright (c) 2012 VOKAL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VILoadingDialog.h"

@interface ViewController : UIViewController <VILoadingDialogDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (strong, nonatomic) VILoadingDialog *loadingController;

- (IBAction)pressedIndeterminate:(id)sender;
- (IBAction)pressedIndeterminateTitle:(id)sender;
- (IBAction)pressedIndeterminateDescription:(id)sender;
- (IBAction)pressedIndeterminateTitleDescription:(id)sender;
- (IBAction)pressedDeterminate:(id)sender;
- (IBAction)pressedDeterminateTitle:(id)sender;
- (IBAction)pressedDeterminateDescription:(id)sender;
- (IBAction)pressedDeterminateTitleDescription:(id)sender;
- (IBAction)pressedSetTItle:(id)sender;
- (IBAction)pressedIncreaseDeterminate:(id)sender;

@end
