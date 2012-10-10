//
//  VILoadingDialog.m
//  CustomLoadingDialog
//
//  Created by Anthony Alesia on 3/7/12.
//  Copyright (c) 2012 VOKAL. All rights reserved.
//

#import "VILoadingDialog.h"

@implementation VILoadingDialog
@synthesize containerView = _containerView;
@synthesize progressIndicator = _progressIndicator;
@synthesize activityIndicator = _activityIndicator;
@synthesize titleLabel = _titleLabel;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize type = _type;
@synthesize parentView = _parentView;
@synthesize titleString = _titleString;
@synthesize descriptionString = _descriptionString;
@synthesize animated = _animated;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_type == CustomLoadingDialogTypeDeterminate) {
        _progressIndicator.hidden = NO;
        _progressIndicator.progress = 0.0;
        _activityIndicator.hidden = YES;
    } else if (_type == CustomLoadingDialogTypeIndeterminate) {
        _progressIndicator.hidden = YES;
        _activityIndicator.hidden = NO;
        
        [_activityIndicator startAnimating];
    }
    
    _titleLabel.text = _titleString;
    _descriptionLabel.text = _descriptionString;
    
    [self styleContainer];
    [self updateViewSize];
}

- (void)viewDidUnload
{
    [self setContainerView:nil];
    [self setProgressIndicator:nil];
    [self setActivityIndicator:nil];
    [self setTitleLabel:nil];
    [self setDescriptionLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Setters

- (void)setType:(CustomLoadingDialogType)type
{
    _type = type;
    
    if (_type == CustomLoadingDialogTypeDeterminate) {
        _progressIndicator.hidden = NO;
        _progressIndicator.progress = 0.0;
        _activityIndicator.hidden = YES;
    } else if (_type == CustomLoadingDialogTypeIndeterminate) {
        _progressIndicator.hidden = YES;
        _activityIndicator.hidden = NO;
        
        [_activityIndicator startAnimating];
    }
    
    [self updateViewAnimated:_animated];
}

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    _titleLabel.text = titleString;
    
    [self updateViewAnimated:_animated];
}

- (void)setDescriptionString:(NSString *)descriptionString
{
    _descriptionString = descriptionString;
    _descriptionLabel.text = descriptionString;
    
    [self updateViewAnimated:_animated];
}

#pragma mark - Instance Methods

- (void)increaseProgressBarByAmount:(CGFloat)increaseAmount forTotal:(CGFloat)total
{
    if (_type == CustomLoadingDialogTypeDeterminate) {
        CGFloat progress = _progressIndicator.progress + (increaseAmount / total);
    
        [_progressIndicator setProgress:progress animated:YES];
    
        if (_progressIndicator.progress == 1.0) {
            [_delegate loadingDialog:self didCompleteLoading:YES];
        }
    }
}

- (void)show
{
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y,
                                 _parentView.frame.size.width, _parentView.frame.size.height);
    [_parentView addSubview:self.view];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.2];
    [animation setType:kCATransitionFade];
    [animation setSubtype:kCATransitionFade];
    
    [[self.view layer] addAnimation:animation forKey:@"DisplayView"];
}

- (void)dismiss
{
    [self.view removeFromSuperview];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.2];
    [animation setType:kCATransitionFade];
    [animation setSubtype:kCATransitionFade];
    
    [[self.view layer] addAnimation:animation forKey:@"RemoveView"];
}

- (void)styleContainer
{
    _containerView.layer.cornerRadius = 11.0;
}


- (void)updateViewAnimated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             [self updateViewSize];
                         }];
    } else {
        [self updateViewSize];
    }
}

- (void)updateViewSize
{
    CGSize size = CGSizeMake(2 * HORIZONTAL_BUFFER, 2 * VERTICAL_BUFFER);
    CGSize labelSize = CGSizeMake(0.0, 0.0);
    CGFloat width = 0.0;
    
    if (_type == CustomLoadingDialogTypeDeterminate) {
        labelSize = [self updateLabelSizesForDeterminate];
        width = _progressIndicator.frame.size.width;
        
        size.height = size.height + _progressIndicator.frame.size.height;
    } else if (_type == CustomLoadingDialogTypeIndeterminate) {
        labelSize = [self updateLabelSizesForIndeterminate];
        width = _activityIndicator.frame.size.width;
        
        size.height = size.height + _activityIndicator.frame.size.height;
    }
    
    if (labelSize.width < width) {
        size.width = size.width + width;
    } else {
        size.width = size.width + labelSize.width;
    }
    
    size.height = size.height + labelSize.height;
    
    _containerView.frame = CGRectMake(_containerView.frame.origin.x,
                                      _containerView.frame.origin.y,
                                      size.width,
                                      size.height);
    _containerView.center = self.view.center;
}

- (CGSize)updateLabelSizesForDeterminate
{
    CGSize size = CGSizeMake(0.0, 0.0);
    
    if ([_titleLabel.text length] > 0) {
        _titleLabel.hidden = NO;
        
        _titleLabel.frame = CGRectMake(_titleLabel.frame.origin.x,
                                       _progressIndicator.frame.origin.y + _progressIndicator.frame.size.height + LABEL_BUFFER,
                                       _titleLabel.frame.size.width,
                                       _titleLabel.frame.size.height);
        
        size.height = size.height + _titleLabel.frame.size.height + LABEL_BUFFER;
        size.width = _titleLabel.frame.size.width;
    } else {
        _titleLabel.hidden = YES;
    }
    
    if ([_descriptionLabel.text length] > 0) {
        _descriptionLabel.hidden = NO;
        
        CGSize textSize = [_descriptionLabel.text sizeWithFont:_descriptionLabel.font
                                             constrainedToSize:CGSizeMake(_descriptionLabel.frame.size.width, 300)
                                                 lineBreakMode:UILineBreakModeWordWrap];
        
        CGFloat y = 0.0;
        
        if (_titleLabel.hidden) {
            y = _progressIndicator.frame.origin.y + _progressIndicator.frame.size.height + LABEL_BUFFER;
        } else {
            y = _titleLabel.frame.origin.y + _titleLabel.frame.size.height + LABEL_BUFFER;
        }
        
        _descriptionLabel.frame = CGRectMake(_descriptionLabel.frame.origin.x, y,
                                             _descriptionLabel.frame.size.width,
                                             textSize.height);
        
        size.height = size.height + _descriptionLabel.frame.size.height + LABEL_BUFFER;
        size.width = _descriptionLabel.frame.size.width;
    } else {
        _descriptionLabel.hidden = YES;
    }
    
    return size;
}

- (CGSize)updateLabelSizesForIndeterminate
{
    CGSize size = CGSizeMake(0.0, 0.0);
    
    if ([_titleLabel.text length] > 0) {
        _titleLabel.hidden = NO;
        
        _titleLabel.frame = CGRectMake(_titleLabel.frame.origin.x,
                                       _activityIndicator.frame.origin.y + _activityIndicator.frame.size.height + LABEL_BUFFER,
                                       _titleLabel.frame.size.width,
                                       _titleLabel.frame.size.height);
        
        size.height = size.height + _titleLabel.frame.size.height + LABEL_BUFFER;
        size.width = _titleLabel.frame.size.width;
    } else {
        _titleLabel.hidden = YES;
    }
    
    if ([_descriptionLabel.text length] > 0) {
        _descriptionLabel.hidden = NO;
        
        CGSize textSize = [_descriptionLabel.text sizeWithFont:_descriptionLabel.font
                                             constrainedToSize:CGSizeMake(_descriptionLabel.frame.size.width, 300)
                                                 lineBreakMode:UILineBreakModeWordWrap];
        
        CGFloat y = 0.0;
        
        if (_titleLabel.hidden) {
            y = _activityIndicator.frame.origin.y + _activityIndicator.frame.size.height + LABEL_BUFFER;
        } else {
            y = _titleLabel.frame.origin.y + _titleLabel.frame.size.height + LABEL_BUFFER;
        }
        
        _descriptionLabel.frame = CGRectMake(_descriptionLabel.frame.origin.x, y,
                                             _descriptionLabel.frame.size.width,
                                             textSize.height);
        
        size.height = size.height + _descriptionLabel.frame.size.height + LABEL_BUFFER;
        size.width = _descriptionLabel.frame.size.width;
    } else {
        _descriptionLabel.hidden = YES;
    }
    
    return size;
}

#pragma mark - Class Methods

+ (id)loadingDialogForView:(UIView *)parentView
                                  withType:(CustomLoadingDialogType)type
                                     title:(NSString *)title
                               description:(NSString *)description 
                                  delegate:(id)delegate
                                  animated:(BOOL)animated
{
    VILoadingDialog *loadingDialog = [[VILoadingDialog alloc] 
                                                                    initWithNibName:@"VILoadingDialog"
                                                                    bundle:nil];
    
    loadingDialog.parentView = parentView;
    loadingDialog.type = type;
    loadingDialog.titleString = title;
    loadingDialog.descriptionString = description;
    loadingDialog.animated = animated;
    loadingDialog.delegate = delegate;
    
    return loadingDialog;
}

@end
