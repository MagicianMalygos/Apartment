//
//  PACircleLoadingView.m
//  haofang
//
//  Created by Steven.Lin on 6/16/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import "PACircleLoadingView.h"


#define ANGLE(a) 2*M_PI/360*a


@implementation PACircleLoadingView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    if (self.anglePer <= 0) {
        _anglePer = 0;
    }
    
//    NSLog(@"%f", _anglePer);
    
    CGFloat lineWidth = 1.f;
    UIColor *lineColor = [UIColor lightGrayColor];
    if (self.lineWidth) {
        lineWidth = self.lineWidth;
    }
    if (self.lineColor) {
        lineColor = self.lineColor;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextAddArc(context,
                    CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds),
                    CGRectGetWidth(self.bounds)/2-lineWidth,
                    ANGLE(-90), ANGLE(-90)+ANGLE(360)*self.anglePer,
                    0);
    CGContextStrokePath(context);
}


- (void)setAnglePer:(CGFloat)anglePer
{
    _anglePer = (anglePer > 0.94f) ? 0.94f : anglePer;
    
    [self setNeedsDisplay];
}

- (void)startRotateAnimation
{
    self.anglePer = 0.94f;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0);
    animation.toValue = @(2*M_PI);
    animation.duration = 0.6f;
    animation.repeatCount = INT_MAX;
    
    [self.layer addAnimation:animation forKey:@"keyFrameAnimation"];
}

- (void)stopRotateAnimation
{
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.anglePer = 0;
        [self.layer removeAllAnimations];
        self.alpha = 1;
    }];
}


@end
