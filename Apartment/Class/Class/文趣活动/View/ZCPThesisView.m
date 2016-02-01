//
//  ZCPThesisView.m
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPThesisView.h"

#import "ZCPThesisModel.h"


#define VernierWidth 14                     // 游标宽度
#define StaffMargin 4                       // 尺线中间间距
#define DefaultHeight 20                    // 标签和按钮的默认高度
#define ButtonDefaultWidth DefaultHeight    // 按钮的默认宽度


@implementation ZCPThesisView

- (instancetype)initWithFrame:(CGRect)frame thesis:(ZCPThesisModel *)thesisModel {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor greenColor]; // clearColor
        [self setThesisModel:thesisModel];
    }
    return self;
}
/**
 *  设置thesisModel，通过thesisModel设置控件，计算并设置视图高度
 *
 *  @param thesisModel 辩题模型
 */
- (void)setThesisModel:(ZCPThesisModel *)thesisModel {
    if (thesisModel == nil) {
        return;
    }
    _thesisModel = thesisModel;
    
    // 添加的顺序不能变，因为需要计算文字高度的问题，所以后者的frame是由前者控制的
    [self addSubview:[self createThesisContentLabel]];
    [self addSubview:[self createProsLabel]];
    [self addSubview:[self createConsLabel]];
    [self addSubview:[self createVernierView]];
    [self addSubview:[self createProsStaffView]];
    [self addSubview:[self createConsStaffView]];
    [self addSubview:[self createProsRateLabel]];
    [self addSubview:[self createConsRateLabel]];
    [self addSubview:[self createProsArgumentLabel]];
    [self addSubview:[self createConsArgumentLabel]];
    [self addSubview:[self createReplyNumberLabel]];
    [self addSubview:[self createCollectionNumberLabel]];
    [self addSubview:[self createCommentButton]];
    [self addSubview:[self createCollectionButton]];
    [self addSubview:[self createShareThesisButton]];

    self.frame = CGRectMake(self.x, self.y, self.width, self.collectionButton.bottom + HorizontalMargin);
}

#pragma mark - 创建子控件
/**
 *  创建辩题标题标签
 *
 *  @return 辩题标题标签
 */
- (UILabel *)createThesisContentLabel {
    
    CGFloat height = [self.thesisModel.thesisContent boundingRectWithSize:CGSizeMake(self.width - HorizontalMargin * 2, CGFLOAT_MAX)
                                                                  options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17.0f weight:10.0f]}
                                                                  context:nil].size.height;
    UILabel *thesisContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(HorizontalMargin, VerticalMargin, self.width - HorizontalMargin * 2, height)];
    thesisContentLabel.numberOfLines = 0;
    thesisContentLabel.textAlignment = NSTextAlignmentCenter;
    thesisContentLabel.font = [UIFont systemFontOfSize:17.0f weight:10.0f];
    thesisContentLabel.text = self.thesisModel.thesisContent;
    self.thesisContentLabel = thesisContentLabel;
    return thesisContentLabel;
}
/**
 *  创建‘正方’文字标签
 *
 *  @return ‘正方’文字标签
 */
- (UILabel *)createProsLabel {
    UILabel *prosLabel = [[UILabel alloc] initWithFrame:CGRectMake(HorizontalMargin, self.thesisContentLabel.bottom + UIMargin, 40, DefaultHeight)];
    prosLabel.textAlignment = NSTextAlignmentLeft;
    prosLabel.textColor = [UIColor whiteColor];
    prosLabel.font = [UIFont systemFontOfSize:17.0f];
    prosLabel.text = @"正方";
    self.prosLabel = prosLabel;
    return prosLabel;
}
/**
 *  创建‘反方’文字标签
 *
 *  @return ‘反方’文字标签
 */
- (UILabel *)createConsLabel {
    UILabel *consLabel = [[UILabel alloc] initWithFrame:CGRectMake(APPLICATIONWIDTH - HorizontalMargin - 40, self.thesisContentLabel.bottom + UIMargin, 40, DefaultHeight)];
    consLabel.textAlignment = NSTextAlignmentRight;
    consLabel.textColor = [UIColor whiteColor];
    consLabel.font = [UIFont systemFontOfSize:17.0f];
    consLabel.text = @"反方";
    self.consLabel = consLabel;
    return consLabel;
}
/**
 *  创建游标视图
 *
 *  @return 游标视图
 */
- (UIImageView *)createVernierView {
    UIImageView *vernierImgView = [[UIImageView alloc] initWithFrame:CGRectMake((APPLICATIONWIDTH - VernierWidth) / 2, self.thesisContentLabel.bottom + UIMargin, VernierWidth, DefaultHeight)];
    vernierImgView.backgroundColor = [UIColor redColor];  // 改为clearColor
    self.vernierView = vernierImgView;
    return vernierImgView;
}
/**
 *  创建正方尺线
 *
 *  @return 正方尺线
 */
- (UIView *)createProsStaffView {
    UIView *prosStaffView = [[UIView alloc] initWithFrame:CGRectMake(HorizontalMargin, self.vernierView.bottom + UIMargin, (APPLICATIONWIDTH - HorizontalMargin * 2 - StaffMargin) / 2, 10)];
    prosStaffView.backgroundColor = [UIColor redColor];
    self.prosStaffView = prosStaffView;
    return prosStaffView;
}
/**
 *  创建反方尺线
 *
 *  @return 反方尺线
 */
- (UIView *)createConsStaffView {
    UIView *consStaffView = [[UIView alloc] initWithFrame:CGRectMake(self.prosStaffView.right + StaffMargin, self.vernierView.bottom + UIMargin, (APPLICATIONWIDTH - HorizontalMargin * 2 - StaffMargin) / 2, 10)];
    consStaffView.backgroundColor = [UIColor blueColor];
    self.consStaffView = consStaffView;
    return consStaffView;
}
/**
 *  创建正方比例标签
 *
 *  @return 正方比例标签
 */
- (UILabel *)createProsRateLabel {
    UILabel *prosRateLabel = [[UILabel alloc] initWithFrame:CGRectMake(HorizontalMargin, self.prosStaffView.bottom + UIMargin, 40, DefaultHeight)];
    prosRateLabel.textAlignment = NSTextAlignmentLeft;
    prosRateLabel.textColor = [UIColor whiteColor];
    prosRateLabel.font = [UIFont systemFontOfSize:15.0f];
    prosRateLabel.text = @"50%";
    self.prosRateLabel = prosRateLabel;
    return prosRateLabel;
}
/**
 *  创建反方比例标签
 *
 *  @return 反方比例标签
 */
- (UILabel *)createConsRateLabel {
    UILabel *consRateLabel = [[UILabel alloc] initWithFrame:CGRectMake(APPLICATIONWIDTH - HorizontalMargin - 40, self.consStaffView.bottom + UIMargin, 40, DefaultHeight)];
    consRateLabel.textAlignment = NSTextAlignmentRight;
    consRateLabel.textColor = [UIColor whiteColor];
    consRateLabel.font = [UIFont systemFontOfSize:15.0f];
    consRateLabel.text = @"50%";
    self.consRateLabel = consRateLabel;
    return consRateLabel;
}
/**
 *  创建正方论点标签
 *
 *  @return 正方论点标签
 */
- (UILabel *)createProsArgumentLabel {
    
    CGFloat height = [self.thesisModel.thesisPros boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 2, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0f weight:10.0f]} context:nil].size.height;
    
    UILabel *prosArgumentLabel = [[UILabel alloc] initWithFrame:CGRectMake(HorizontalMargin, self.prosRateLabel.bottom +  UIMargin, APPLICATIONWIDTH - HorizontalMargin * 2, height)];
    prosArgumentLabel.numberOfLines = 0;
    prosArgumentLabel.textAlignment = NSTextAlignmentLeft;
    prosArgumentLabel.textColor = [UIColor whiteColor];
    prosArgumentLabel.font = [UIFont systemFontOfSize:15.0f weight:10.0f];
    prosArgumentLabel.text = self.thesisModel.thesisPros;
    self.prosArgumentLabel = prosArgumentLabel;
    return prosArgumentLabel;
}
/**
 *  创建反方论点标签
 *
 *  @return 创建反方论点标签
 */
- (UILabel *)createConsArgumentLabel {
    CGFloat height = [self.thesisModel.thesisCons boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 2, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0f weight:10.0f]} context:nil].size.height;
    
    UILabel *consArgumentLabel = [[UILabel alloc] initWithFrame:CGRectMake(HorizontalMargin, self.prosArgumentLabel.bottom + UIMargin, APPLICATIONWIDTH - HorizontalMargin * 2, height)];
    consArgumentLabel.numberOfLines = 0;
    consArgumentLabel.textAlignment = NSTextAlignmentLeft;
    consArgumentLabel.textColor = [UIColor whiteColor];
    consArgumentLabel.font = [UIFont systemFontOfSize:15.0f weight:10.0f];
    consArgumentLabel.text = self.thesisModel.thesisCons;
    self.consArgumentLabel = consArgumentLabel;
    return consArgumentLabel;
}
/**
 *  创建回复人数标签
 *
 *  @return 回复人数标签
 */
- (UILabel *)createReplyNumberLabel {
    UILabel *replyNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(HorizontalMargin, self.consArgumentLabel.bottom + UIMargin, 90, DefaultHeight)];
    replyNumberLabel.textAlignment = NSTextAlignmentRight;
    replyNumberLabel.textColor = [UIColor whiteColor];
    replyNumberLabel.font = [UIFont systemFontOfSize:13.0f];
    replyNumberLabel.text = @"0 人回复";
    self.replyNumberLabel = replyNumberLabel;
    return replyNumberLabel;
}
/**
 *  创建收藏人数标签
 *
 *  @return 收藏人数标签
 */
- (UILabel *)createCollectionNumberLabel {
    UILabel *collectionNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.replyNumberLabel.right + UIMargin, self.consArgumentLabel.bottom + UIMargin, 90, DefaultHeight)];
    collectionNumberLabel.textAlignment = NSTextAlignmentRight;
    collectionNumberLabel.textColor = [UIColor whiteColor];
    collectionNumberLabel.font = [UIFont systemFontOfSize:13.0f];
    collectionNumberLabel.text = @"0 人收藏";
    self.collectionNumberLabel = collectionNumberLabel;
    return collectionNumberLabel;
}
/**
 *  创建发表评论按钮
 *
 *  @return 发表评论按钮
 */
- (UIButton *)createCommentButton {
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.frame = CGRectMake(APPLICATIONWIDTH - HorizontalMargin - UIMargin * 2 - ButtonDefaultWidth * 3, self.consArgumentLabel.bottom + UIMargin, ButtonDefaultWidth, DefaultHeight);
    commentButton.backgroundColor = [UIColor redColor];
    [commentButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.commentButton = commentButton;
    return commentButton;
}
/**
 *  创建收藏按钮
 *
 *  @return 收藏按钮
 */
- (UIButton *)createCollectionButton {
    UIButton *collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    collectionButton.frame = CGRectMake(APPLICATIONWIDTH - HorizontalMargin - UIMargin - ButtonDefaultWidth * 2, self.consArgumentLabel.bottom + UIMargin, ButtonDefaultWidth, DefaultHeight);
    collectionButton.backgroundColor = [UIColor redColor];
    [collectionButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.collectionButton = collectionButton;
    return collectionButton;
}
/**
 *  创建分享辩题按钮
 *
 *  @return 分享辩题按钮
 */
- (UIButton *)createShareThesisButton {
    UIButton *shareThesisButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareThesisButton.frame = CGRectMake(APPLICATIONWIDTH - HorizontalMargin - ButtonDefaultWidth, self.consArgumentLabel.bottom + UIMargin, ButtonDefaultWidth, DefaultHeight);
    shareThesisButton.backgroundColor = [UIColor redColor];
    [shareThesisButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.shareThesisButton = shareThesisButton;
    return shareThesisButton;
}

#pragma mark - Button Click
/**
 *  按钮点击事件响应方法
 *
 *  @param button 被点击button
 */
- (void)buttonClick:(UIButton *)button {
    if (!self.delegate) {
        return;
    }
    if (button == self.commentButton && [self.delegate respondsToSelector:@selector(thesisView:didClickedCommentButton:)]) {
        [self.delegate thesisView:self didClickedCommentButton:button];
    }
    else if (button == self.collectionButton && [self.delegate respondsToSelector:@selector(thesisView:didClickedCollectionButton:)]) {
        [self.delegate thesisView:self didClickedCollectionButton:button];
    }
    else if (button == self.shareThesisButton && [self.delegate respondsToSelector:@selector(thesisView:didClickedSharedThesisButton:)]) {
        [self.delegate thesisView:self didClickedSharedThesisButton:button];
    }
}






@end
