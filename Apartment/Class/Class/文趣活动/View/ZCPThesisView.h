//
//  ZCPThesisView.h
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCPThesisModel;
@protocol ZCPThesisViewDelegate;

@interface ZCPThesisView : UIView

@property (nonatomic, strong) ZCPThesisModel *thesisModel;              // 辩题模型
@property (nonatomic, strong) UIImageView *bgView;                      // 背景视图

@property (nonatomic, strong) UILabel *prosLabel;                       // 正方标签
@property (nonatomic, strong) UILabel *consLabel;                       // 反方标签
@property (nonatomic, strong) UIView *prosStaffView;                    // 正方尺线视图
@property (nonatomic, strong) UIView *consStaffView;                    // 反方尺线视图
@property (nonatomic, strong) UIImageView *vernierView;                 // 游标
@property (nonatomic, strong) UILabel *prosRateLabel;                   // 正方比率标签
@property (nonatomic, strong) UILabel *consRateLabel;                   // 正方比率标签

@property (nonatomic, strong) UILabel *thesisContentLabel;              // 辩题内容标签
@property (nonatomic, strong) UILabel *prosArgumentLabel;               // 正方论点
@property (nonatomic, strong) UILabel *consArgumentLabel;               // 反方论点

@property (nonatomic, strong) UILabel *replyNumberLabel;                // 回复人数标签
@property (nonatomic, strong) UILabel *collectionNumberLabel;           // 收藏人数标签
@property (nonatomic, strong) UIButton *commentButton;                  // 发表评论按钮
@property (nonatomic, strong) UIButton *collectionButton;               // 辩题收藏按钮
@property (nonatomic, strong) UIButton *shareThesisButton;              // 分享辩题按钮

@property (nonatomic, weak) id<ZCPThesisViewDelegate> delegate;         // 代理

/**
 *  设置视图大小并设置thesisModel，同时会使用thesisModel初始化视图的所有控件，计算并设置视图高度。视图frame的高度值可以缺省。
 *
 *  @param frame       视图大小，高度可缺省
 *  @param thesisModel 辩题模型
 *
 *  @return 辩题视图
 */
- (instancetype)initWithFrame:(CGRect)frame thesis:(ZCPThesisModel *)thesisModel;
/**
 *  设置thesisModel，通过thesisModel设置控件，计算并设置视图高度
 *
 *  @param thesisModel 辩题模型
 */
- (void)setThesisModel:(ZCPThesisModel *)thesisModel;

@end


#pragma mark - Protocol
@protocol ZCPThesisViewDelegate <NSObject>

// 评论按钮点击事件代理
- (void)thesisView:(ZCPThesisView *)thesisView didClickedCommentButton:(UIButton *)button;
// 收藏按钮点击事件代理
- (void)thesisView:(ZCPThesisView *)thesisView didClickedCollectionButton:(UIButton *)button;
// 分享按钮点击事件代理
- (void)thesisView:(ZCPThesisView *)thesisView didClickedSharedThesisButton:(UIButton *)button;

@end
