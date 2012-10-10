//
//  ViewController.m
//  CustomLoadingDialog
//
//  Created by Anthony Alesia on 3/7/12.
//  Copyright (c) 2012 VOKAL. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize containerView = _containerView;
@synthesize loadingController = _loadingController;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setContainerView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (IBAction)pressedIndeterminate:(id)sender 
{
    if (_loadingController != nil) {
        [_loadingController dismiss];
    }
    
    _loadingController = [VILoadingDialog loadingDialogForView:_containerView withType:CustomLoadingDialogTypeIndeterminate title:nil description:nil delegate:self animated:YES];
    [_loadingController show];
}

- (IBAction)pressedIndeterminateTitle:(id)sender
{
    if (_loadingController != nil) {
        [_loadingController dismiss];
    }
    
    _loadingController = [VILoadingDialog loadingDialogForView:_containerView withType:CustomLoadingDialogTypeIndeterminate title:@"Loading..." description:nil delegate:self animated:YES];
    [_loadingController show];
}

- (IBAction)pressedIndeterminateDescription:(id)sender 
{
    if (_loadingController != nil) {
        [_loadingController dismiss];
    }
    
    _loadingController = [VILoadingDialog loadingDialogForView:_containerView withType:CustomLoadingDialogTypeIndeterminate title:nil description:@"The app is loading" delegate:self animated:YES];
    [_loadingController show];
}

- (IBAction)pressedIndeterminateTitleDescription:(id)sender 
{
    if (_loadingController != nil) {
        [_loadingController dismiss];
    }
    
    _loadingController = [VILoadingDialog loadingDialogForView:_containerView withType:CustomLoadingDialogTypeIndeterminate title:@"Loading..." description:@"The app is loading" delegate:self animated:YES];
    [_loadingController show];
}

- (IBAction)pressedDeterminate:(id)sender 
{
    if (_loadingController != nil) {
        [_loadingController dismiss];
    }
    
    _loadingController = [VILoadingDialog loadingDialogForView:_containerView withType:CustomLoadingDialogTypeDeterminate title:nil description:nil delegate:self animated:YES];
    [_loadingController show];
}

- (IBAction)pressedDeterminateTitle:(id)sender 
{
    if (_loadingController != nil) {
        [_loadingController dismiss];
    }
    
    _loadingController = [VILoadingDialog loadingDialogForView:_containerView withType:CustomLoadingDialogTypeDeterminate title:@"Loading..." description:nil delegate:self animated:YES];
    [_loadingController show];
}

- (IBAction)pressedDeterminateDescription:(id)sender 
{
    if (_loadingController != nil) {
        [_loadingController dismiss];
    }
    
    _loadingController = [VILoadingDialog loadingDialogForView:_containerView withType:CustomLoadingDialogTypeDeterminate title:nil description:@"The app is loading" delegate:self animated:YES];
    [_loadingController show];
}

- (IBAction)pressedDeterminateTitleDescription:(id)sender 
{
    if (_loadingController != nil) {
        [_loadingController dismiss];
    }
    
    _loadingController = [VILoadingDialog loadingDialogForView:_containerView withType:CustomLoadingDialogTypeDeterminate title:@"Loading..." description:@"The app is loading" delegate:self animated:YES];
    [_loadingController show];
}

- (IBAction)pressedSetTItle:(id)sender 
{
    if (_loadingController != nil) {
        [_loadingController setTitleString:@"Loading..."];
    }
}

- (IBAction)pressedIncreaseDeterminate:(id)sender 
{
    if (_loadingController != nil) {
        [_loadingController increaseProgressBarByAmount:1.0 forTotal:10.0];
    }
}

- (void)loadingDialog:(VILoadingDialog *)loadingDialog didCompleteLoading:(BOOL)complete
{
    [_loadingController dismiss];
}

@end
