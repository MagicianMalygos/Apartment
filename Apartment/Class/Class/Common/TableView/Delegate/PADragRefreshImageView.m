//
//  PADragRefreshImageView.m
//  haofang
//
//  Created by Steven.Lin on 6/4/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import "PADragRefreshImageView.h"


@interface PADragRefreshImageView ()

@property (nonatomic, assign) PADragRefreshImageViewAnimationStyle style;

@property (nonatomic, retain) UIImageView* imageView;
@property (nonatomic, retain) UIImageView* loadingView;
@property (assign, nonatomic) CAShapeLayer* circleLayer;

@property (nonatomic, assign) CGFloat heightOfImage;
@property (nonatomic, strong) NSMutableArray *loadingImages;
@end


@implementation PADragRefreshImageView

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame style:PADragRefreshImageViewAnimationStyleCircle];
}

- (id)initWithFrame:(CGRect)frame style:(PADragRefreshImageViewAnimationStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        _style = style;
        
        UIImage* imageHouse = [UIImage imageNamed:[self houseImageName]];
        CGSize size = imageHouse.size;
        
        _imageView = [[UIImageView alloc] initWithImage:imageHouse];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        _imageView.clipsToBounds = YES;
        
        [self addSubview:_imageView];

        if (_style == PADragRefreshImageViewAnimationStylePoint) {
            _imageView.frame = CGRectMake((frame.size.width - size.width) / 2, frame.size.height - (frame.size.height - size.height) / 2, size.width, 0);
        } else {
            _imageView.frame = CGRectMake((frame.size.width - size.width) / 2, (frame.size.height - size.height) / 2, size.width, size.height);
        }
        
        _heightOfImage = size.height;
        
        UIImage* imageLoading = [UIImage imageNamed:@"icon_loading.png"];
        size = imageLoading.size;
        
        _loadingView = [[UIImageView alloc] initWithImage:imageLoading];
        [self addSubview:_loadingView];
        _loadingView.frame = CGRectMake((frame.size.width - size.width) / 2, (frame.size.height - size.height) / 2, size.width, size.height);
        _loadingView.alpha = 0.0;
        
        // 增加一个开闭的圆环
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:_loadingView.frame];
        self.circleLayer.path = bezierPath.CGPath;
        [self.layer addSublayer:self.circleLayer];
        
        // 安租loading的图标集合
        if (_style == PADragRefreshImageViewAnimationStylePoint) {
            _loadingImages = [NSMutableArray array];
            for (NSUInteger i = 1; i<=12; i++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_loading_%zd", i]];
                [_loadingImages addObject:image];
            }
        }
    }
    return self;
}

- (CAShapeLayer *)circleLayer {
    if (nil == _circleLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.strokeColor = UIColorFromRGB(0xcccccc).CGColor;
        shapeLayer.lineWidth = 2.5;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeEnd = 0.0f;
        shapeLayer.strokeStart = 0.0f;

        self.circleLayer = shapeLayer;
    }
    return _circleLayer;
}

- (void)setPullOffset:(CGFloat)pullOffset {
    if (!self.isLoading) {
        if (_style == PADragRefreshImageViewAnimationStylePoint) {
            // 安租将使用放大动画，不再需要circleLayer
            self.circleLayer.hidden = YES;
            
            CGFloat heightDraggingMax = self.height + 5.0;
            CGFloat spaceUnderImageView = (self.height - self.heightOfImage) * 0.5;
            CGFloat visibleHeight = fabs(pullOffset) - spaceUnderImageView;
            
            if (visibleHeight > heightDraggingMax - spaceUnderImageView) {
                visibleHeight = heightDraggingMax - spaceUnderImageView;
            }
            
            // 直到往下拖到self.height + 5.0即65时，房子图标的大小才1比1显示
            self.imageView.height = self.heightOfImage * visibleHeight / (heightDraggingMax - spaceUnderImageView);
            self.imageView.bottom = self.height - spaceUnderImageView;
        } else {
            self.circleLayer.hidden = NO;
            CGFloat ratio = fabs(pullOffset)/65.0f;
            self.circleLayer.strokeStart = 0.f;
            self.circleLayer.strokeEnd = ratio;
        }
        
    } else {
        self.circleLayer.hidden = YES;
        self.circleLayer.strokeEnd = 0.0f;
    }
}


- (void) setStatus:(PATableHeaderDragRefreshStatus)status {
    
    _imageView.hidden = NO;
    
    switch (status) {
        case PATableHeaderDragRefreshLoading:
            _loadingView.hidden = NO;
            [self startRotateAnimation];
            break;
        case PATableHeaderDragRefreshPullToReload:
//            [self stopRotateAnimation];
            _loadingView.hidden = YES;
            break;
        case PATableHeaderDragRefreshReleaseToReload:
            _loadingView.hidden = YES;
            break;
        default:
            break;
    }
}

- (NSString *)houseImageName {
    if (self.style == PADragRefreshImageViewAnimationStylePoint) {
        return @"icon_house_new.png";
    }
    
    return @"icon_house.png";
}

- (void)startRotateAnimation
{
    if (_style == PADragRefreshImageViewAnimationStylePoint) {
        _imageView.animationImages = self.loadingImages;
        _imageView.animationDuration = 0.6;//0.1 * [self.loadingImages count];
        [_imageView startAnimating];
    } else {
        _loadingView.alpha = 1.0;
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = @(0);
        animation.toValue = @(2*M_PI);
        animation.duration = 0.6f;
        animation.repeatCount = INT_MAX;
    
        [_loadingView.layer addAnimation:animation forKey:@"keyFrameAnimation"];
    }
}

- (void)stopRotateAnimation
{
    if (_style == PADragRefreshImageViewAnimationStylePoint) {
        // 不需要原来的_loadingView，直接拿_imageView作为gif view
        [_imageView stopAnimating];
    } else {
        [_loadingView.layer removeAllAnimations];
        _loadingView.alpha = 0.0;
    }
}

@end
