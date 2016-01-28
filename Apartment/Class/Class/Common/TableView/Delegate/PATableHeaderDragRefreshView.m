//
//  PATableHeaderDragRefreshView.m
//  haofang
//
//  Created by PengFeiMeng on 4/1/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import "PATableHeaderDragRefreshView.h"
#import "PADragRefreshImageView.h"
#import "PACircleLoadingView.h"

#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f

@interface PATableHeaderDragRefreshView ()
@property (nonatomic, retain) PADragRefreshImageView* refreshImageView;
//@property (nonatomic, retain) PACircleLoadingView* circleLoadingView;
@property (nonatomic, assign) BOOL hasOverride;
@end

@implementation PATableHeaderDragRefreshView
{
    PAPullRefreshState _state;
    
	UILabel *_lastUpdatedLabel;
	UILabel *_statusLabel;
	CALayer *_arrowImage;
	UIActivityIndicatorView *_activityView;
}



- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    
    if (!_hasOverride) {
        
        _arrowImage.hidden = YES;
        _lastUpdatedLabel.hidden = YES;
        _statusLabel.hidden = YES;
        _activityView.hidden = YES;
        
        if (_refreshImageView == nil) {
            _refreshImageView = [[PADragRefreshImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 280.0f, 60.0f) style:PADragRefreshImageViewAnimationStylePoint];
            [self addSubview:_refreshImageView];
        }
        
        CGRect frame = _refreshImageView.frame;
        frame.origin.x = (APPLICATIONWIDTH - frame.size.width) / 2;
        frame.origin.y = (self.frame.size.height - frame.size.height);
        _refreshImageView.frame = frame;
        
        
#if 0
        if (_circleLoadingView == nil) {
            _circleLoadingView = [[PACircleLoadingView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
            _circleLoadingView.lineColor = [UIColor grayColor];
            [self addSubview:_circleLoadingView];
        }
        
        CGRect frame = _circleLoadingView.frame;
        frame.origin.x = (APPLICATIONWIDTH - 30.0f) / 2;
        frame.origin.y = APPLICATIONHEIGHT - 130.0f;
        _circleLoadingView.frame = frame;
        
#endif
        
        
        _hasOverride = YES;
    }
}


- (void)reDrawRefreshHederView{
    
    
#if 0
    if (!_hasOverride) {
        
        _arrowImage.hidden = YES;
        _lastUpdatedLabel.hidden = YES;
        _statusLabel.hidden = YES;
        _activityView.hidden = YES;
        

        if (_circleLoadingView == nil) {
            _circleLoadingView = [[PACircleLoadingView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
            [self addSubview:_circleLoadingView];
        }
        
        CGRect frame = _circleLoadingView.frame;
        frame.origin.x = (APPLICATIONWIDTH - 30.0f) / 2;
        frame.origin.y = APPLICATIONHEIGHT - 130.0f;
        _circleLoadingView.frame = frame;
        
        frame = _activityView.frame;
        frame.origin.x = (APPLICATIONWIDTH - frame.size.width) / 2;
        _activityView.frame = frame;
        
        _hasOverride = YES;
    }
    

#endif
    
}


- (void)refreshLastUpdatedDate {
	
	if ([self.delegate respondsToSelector:@selector(paRefreshTableHeaderDataSourceLastUpdated:)]) {
		
		NSDate *date = [_delegate paRefreshTableHeaderDataSourceLastUpdated:self];
		
		[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
		[dateFormatter setDateStyle:NSDateFormatterShortStyle];
		[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        
		_lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [dateFormatter stringFromDate:date]];
		[[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
	} else {
		
		_lastUpdatedLabel.text = nil;
		
	}
    
}

- (void)setState:(PAPullRefreshState)aState{
    _refreshImageView.isLoading = NO;
	switch (aState) {
        case PAPullRefreshPulling:
			break;
		case PAPullRefreshNormal:
			
			if (_state == PAPullRefreshPulling) {
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
			
            [_refreshImageView stopRotateAnimation];
			[self refreshLastUpdatedDate];
			
			break;
		case PAPullRefreshLoading:
            _refreshImageView.isLoading = YES;
            [_refreshImageView startRotateAnimation];
			break;
		default:
			break;
	}
    
#if 0
    _circleLoadingView.anglePer = -tableView.contentOffset.y / 75.0f;
    
    
    switch (status) {
        case TTTableHeaderDragRefreshLoading:
            [_circleLoadingView startRotateAnimation];
            _activityView.hidden = YES;
            break;
        case TTTableHeaderDragRefreshPullToReload:
            if (!tableView.dragging) {
                [_circleLoadingView stopRotateAnimation];
            }
        case TTTableHeaderDragRefreshReleaseToReload:
            break;
        default:
            break;
            
    }
#endif
	
	_state = aState;
    
}

#pragma mark scroll callback

- (void)paRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
	
    _refreshImageView.pullOffset = scrollView.contentOffset.y;
	if (_state == PAPullRefreshLoading) {
		
		CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
		offset = MIN(offset, 60);
        UIEdgeInsets insets = scrollView.contentInset;
        insets.top = offset;
		scrollView.contentInset = insets;
        scrollView.contentOffset = CGPointMake(0, -scrollView.contentInset.top);
		
	} else if (scrollView.isDragging) {
		
		BOOL _loading = NO;
		if ([self.delegate respondsToSelector:@selector(paRefreshTableHeaderDataSourceIsLoading:)]) {
			_loading = [_delegate paRefreshTableHeaderDataSourceIsLoading:self];
		}
		
		if (_state == PAPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_loading) {
			[self setState:PAPullRefreshNormal];
		} else if (_state == PAPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_loading) {
			[self setState:PAPullRefreshPulling];
		}
		
		if (scrollView.contentInset.top != 0) {
            UIEdgeInsets insets = scrollView.contentInset;
            insets.top = 0.0;
			scrollView.contentInset = insets;
		}
		
	}
	
}

- (void)paRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
	
	BOOL _loading = NO;
	if ([self.delegate respondsToSelector:@selector(paRefreshTableHeaderDataSourceIsLoading:)]) {
		_loading = [_delegate paRefreshTableHeaderDataSourceIsLoading:self];
	}
	
	if (scrollView.contentOffset.y <= - 65.0f && !_loading) {
		
		if ([self.delegate respondsToSelector:@selector(paRefreshTableHeaderDidTriggerRefresh:)]) {
			[self.delegate paRefreshTableHeaderDidTriggerRefresh:self];
		}
		
		[self setState:PAPullRefreshLoading];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
        UIEdgeInsets insets = scrollView.contentInset;
        insets.top = 60.0;
		scrollView.contentInset = insets;
		[UIView commitAnimations];
		
	}
	
}

- (void)paRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.2];
    UIEdgeInsets insets = scrollView.contentInset;
    insets.top = 0.0;
	[scrollView setContentInset:insets];
	[UIView commitAnimations];
	
	[self setState:PAPullRefreshNormal];
    
}

@end
