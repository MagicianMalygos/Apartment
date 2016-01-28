//
//  PATableHeaderDragRefreshView.h
//  haofang
//
//  Created by PengFeiMeng on 4/1/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//


typedef enum{
	PAPullRefreshPulling = 0,
	PAPullRefreshNormal,
	PAPullRefreshLoading,
} PAPullRefreshState;

@protocol PARefreshTableHeaderDelegate;

@interface PATableHeaderDragRefreshView : UIView

@property (nonatomic, weak) id<PARefreshTableHeaderDelegate, NSObject> delegate;

// 用于消息列表页面中下拉刷新的重写
- (void)reDrawRefreshHederView;

- (void)refreshLastUpdatedDate;
- (void)paRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)paRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)paRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end

@protocol PARefreshTableHeaderDelegate
- (void)paRefreshTableHeaderDidTriggerRefresh:(PATableHeaderDragRefreshView *)view;
- (BOOL)paRefreshTableHeaderDataSourceIsLoading:(PATableHeaderDragRefreshView *)view;
@optional
- (NSDate*)paRefreshTableHeaderDataSourceLastUpdated:(PATableHeaderDragRefreshView *)view;
@end
