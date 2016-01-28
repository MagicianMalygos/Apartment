//
//  PADragRefreshImageView.h
//  haofang
//
//  Created by Steven.Lin on 6/4/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PATableHeaderDragRefreshReleaseToReload,
    PATableHeaderDragRefreshPullToReload,
    PATableHeaderDragRefreshLoading
} PATableHeaderDragRefreshStatus;

typedef NS_ENUM(NSInteger, PADragRefreshImageViewAnimationStyle) {
    PADragRefreshImageViewAnimationStyleCircle  = 1,    // 好房风格的圆圈动画
    PADragRefreshImageViewAnimationStylePoint   = 2,    // 安租风格的点阵动画
};

@interface PADragRefreshImageView : UIImageView

/**
 *  @brief  scrollView 下拉的距离
 */
@property (assign, nonatomic) CGFloat pullOffset;
@property (assign, nonatomic) BOOL isLoading;

- (id)initWithFrame:(CGRect)frame style:(PADragRefreshImageViewAnimationStyle)style;

- (void) setStatus:(PATableHeaderDragRefreshStatus)status;

- (void)startRotateAnimation;
- (void)stopRotateAnimation;

@end
