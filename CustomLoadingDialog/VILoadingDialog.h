//
//  VILoadingDialog.h
//  CustomLoadingDialog
//
//  Created by Anthony Alesia on 3/7/12.
//  Copyright (c) 2012 VOKAL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define VERTICAL_BUFFER         20.0
#define HORIZONTAL_BUFFER       25.0
#define LABEL_BUFFER            8.0

typedef enum {
    CustomLoadingDialogTypeDeterminate,
    CustomLoadingDialogTypeIndeterminate,
} CustomLoadingDialogType;

@class VILoadingDialog;

@protocol VILoadingDialogDelegate <NSObject>

@optional
- (void)loadingDialog:(VILoadingDialog *)loadingDialog didCompleteLoading:(BOOL)complete;

@end

@interface VILoadingDialog : UIViewController
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (assign, nonatomic) id<VILoadingDialogDelegate> delegate;
@property (assign, nonatomic) BOOL animated;
@property (assign, nonatomic) CustomLoadingDialogType type;
@property (retain, nonatomic) UIView *parentView;
@property (retain, nonatomic) NSString *titleString;
@property (retain, nonatomic) NSString *descriptionString;

- (void)show;
- (void)dismiss;
- (void)styleContainer;
- (void)updateViewAnimated:(BOOL)animated;
- (void)updateViewSize;
- (CGSize)updateLabelSizesForDeterminate;
- (CGSize)updateLabelSizesForIndeterminate;
- (void)increaseProgressBarByAmount:(CGFloat)increaseAmount forTotal:(CGFloat)total;

+ (id)loadingDialogForView:(UIView *)parentView
                                  withType:(CustomLoadingDialogType)type
                                     title:(NSString *)title
                               description:(NSString *)description 
                                  delegate:(id)delegate
                                  animated:(BOOL)animated;

@end
