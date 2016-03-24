//
//  PACircleLoadingView.h
//  haofang
//
//  Created by Steven.Lin on 6/16/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PACircleLoadingView : UIView

//default is 1.0f
@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign) CGFloat anglePer;

//default is [UIColor lightGrayColor]
@property (nonatomic, retain) UIColor *lineColor;

@property (nonatomic, readonly) BOOL isAnimating;

- (void)startRotateAnimation;
- (void)stopRotateAnimation;
@end
