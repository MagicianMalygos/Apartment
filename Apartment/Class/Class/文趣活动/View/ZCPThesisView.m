//
//  ZCPThesisView.m
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPThesisView.h"

#import "ZCPThesisModel.h"


#define VernierWidth        14                  // 游标宽度
#define StaffHeight         10                  // 尺线高度
#define StaffMargin         4                   // 尺线中间间距
#define DefaultHeight       20                  // 标签和按钮的默认高度
#define ButtonDefaultWidth  DefaultHeight       // 按钮的默认宽度
#define RateLabelWidth      40                  // 比例标签宽度
#define NumberLabelWidth    90                  // 计数相关标签宽度


@implementation ZCPThesisView

#pragma mark instancetype
- (instancetype)initWithFrame:(CGRect)frame thesis:(ZCPThesisModel *)thesisModel {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setThesisModel:thesisModel];
    }
    return self;
}

#pragma mark life circle
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置背景图片
    self.bgView.frame = self.frame;
}

#pragma mark getter / setter
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

- (UIImageView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIImageView alloc] initWithFrame:self.frame];
        _bgView.image = [UIImage imageNamed:@"thesis_bg"];
        [self addSubview:_bgView];         // 添加到辩题视图
        [self sendSubviewToBack:_bgView];  // 置底
    }
    return _bgView;
}

#pragma mark - 创建子控件
/**
 *  创建辩题标题标签
 */
- (UILabel *)createThesisContentLabel {
    // 可重用部分
    if (self.thesisContentLabel == nil) {
        self.thesisContentLabel = [[UILabel alloc] init];
        self.thesisContentLabel.numberOfLines = 0;
        self.thesisContentLabel.textAlignment = NSTextAlignmentCenter;
        self.thesisContentLabel.textColor = [UIColor whiteColor];
        self.thesisContentLabel.font = [UIFont defaultBoldFontWithSize:18.0f];
    }
    // 每次设置thesisModel需更新部分
    CGFloat height = [self.thesisModel.thesisContent boundingRectWithSize:CGSizeMake(self.width - HorizontalMargin * 2, CGFLOAT_MAX)
                                                                  options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:18.0f]}
                                                                  context:nil].size.height;
    self.thesisContentLabel.frame = CGRectMake(HorizontalMargin, VerticalMargin, self.width - HorizontalMargin * 2, height);
    self.thesisContentLabel.text = self.thesisModel.thesisContent;
    return self.thesisContentLabel;
}
/**
 *  创建‘正方’文字标签
 */
- (UILabel *)createProsLabel {
    // 可重用部分
    if (self.prosLabel == nil) {
        self.prosLabel = [[UILabel alloc] initWithFrame:CGRectMake(HorizontalMargin, self.thesisContentLabel.bottom + UIMargin, 40, DefaultHeight)];
        self.prosLabel.textAlignment = NSTextAlignmentLeft;
        self.prosLabel.textColor = [UIColor whiteColor];
        self.prosLabel.font = [UIFont defaultFontWithSize:18.0f];
        self.prosLabel.text = @"正方";
    }
    return self.prosLabel;
}
/**
 *  创建‘反方’文字标签
 */
- (UILabel *)createConsLabel {
    // 可重用部分
    if (self.consLabel == nil) {
        self.consLabel = [[UILabel alloc] initWithFrame:CGRectMake(APPLICATIONWIDTH - HorizontalMargin - 40, self.thesisContentLabel.bottom + UIMargin, 40, DefaultHeight)];
        self.consLabel.textAlignment = NSTextAlignmentRight;
        self.consLabel.textColor = [UIColor whiteColor];
        self.consLabel.font = [UIFont defaultFontWithSize:18.0f];
        self.consLabel.text = @"反方";
    }
    return self.consLabel;
}
/**
 *  创建游标视图
 */
- (UIImageView *)createVernierView {
    // 可重用部分
    if (self.vernierView == nil) {
        self.vernierView = [[UIImageView alloc] init];
        self.vernierView.backgroundColor = [UIColor clearColor];  // 改为clearColor
    }
    // 每次设置thesisModel需更新部分
    // 游标x值范围：self.prosLabel.right ~ self.consLabel.left - VernierWidth
    CGFloat XLen = (self.consLabel.left - VernierWidth) - self.prosLabel.right;
    CGFloat prosRate = [self calculateProsRate];            // 计算正方比例
    CGFloat x = self.prosLabel.right + XLen * prosRate;     // 得到origin的x值
    // 设置frame
    self.vernierView.frame = CGRectMake(x, self.thesisContentLabel.bottom + UIMargin, VernierWidth, DefaultHeight);
    // 设置背景图片
    NSString *bgImageName = @"vernier_balance";
    if (prosRate > 0.5) {
        bgImageName = @"vernier_red";
    }
    else if (prosRate < 0.5) {
        bgImageName = @"vernier_blue";
    }
    else {
        bgImageName = @"vernier_balance";
    }
    [self.vernierView setImage:[UIImage imageNamed:bgImageName]];
    
    return self.vernierView;
}
/**
 *  创建正方尺线
 */
- (UIView *)createProsStaffView {
    // 可重用部分
    if (self.prosStaffView == nil) {
        self.prosStaffView = [[UIView alloc] init];
        self.prosStaffView.backgroundColor = [UIColor redColor];
    }
    // 每次设置thesisModel需更新部分
    // 设置frame
    self.prosStaffView.frame = CGRectMake(HorizontalMargin
                                          , self.vernierView.bottom + UIMargin
                                          , self.vernierView.center.x - StaffMargin / 2 - HorizontalMargin
                                          , StaffHeight);
    
    return self.prosStaffView;
}
/**
 *  创建反方尺线
 */
- (UIView *)createConsStaffView {
    // 可重用部分
    if (self.consStaffView == nil) {
        self.consStaffView = [[UIView alloc] init];
        self.consStaffView.backgroundColor = [UIColor blueColor];
    }
    // 每次设置thesisModel需更新部分
    self.consStaffView.frame = CGRectMake(self.prosStaffView.right + StaffMargin
                                          , self.vernierView.bottom + UIMargin
                                          , APPLICATIONWIDTH - (self.vernierView.center.x + StaffMargin / 2) - HorizontalMargin
                                          , StaffHeight);
    return self.consStaffView;
}
/**
 *  创建正方比例标签
 */
- (UILabel *)createProsRateLabel {
    // 可重用部分
    if (self.prosRateLabel == nil) {
        self.prosRateLabel = [[UILabel alloc] init];
        self.prosRateLabel.frame = CGRectMake(HorizontalMargin
                                              , self.prosStaffView.bottom + UIMargin
                                              , RateLabelWidth
                                              , DefaultHeight);
        self.prosRateLabel.textAlignment = NSTextAlignmentLeft;
        self.prosRateLabel.textColor = [UIColor whiteColor];
        self.prosRateLabel.font = [UIFont defaultFontWithSize:15.0f];
    }
    // 每次设置thesisModel需更新部分
    self.prosRateLabel.text = [NSString stringWithFormat:@"%lu%%", (NSInteger)([self calculateProsRate] * 100)];
    return self.prosRateLabel;
}
/**
 *  创建反方比例标签
 */
- (UILabel *)createConsRateLabel {
    // 可重用部分
    if (self.consRateLabel == nil) {
        self.consRateLabel = [[UILabel alloc] init];
        self.consRateLabel.frame = CGRectMake(APPLICATIONWIDTH - HorizontalMargin - RateLabelWidth
                                              , self.consStaffView.bottom + UIMargin
                                              , RateLabelWidth
                                              , DefaultHeight);
        self.consRateLabel.textAlignment = NSTextAlignmentRight;
        self.consRateLabel.textColor = [UIColor whiteColor];
        self.consRateLabel.font = [UIFont defaultFontWithSize:15.0f];
    }
    // 每次设置thesisModel需更新部分
    self.consRateLabel.text = [NSString stringWithFormat:@"%lu%%", 100 - (NSInteger)([self calculateProsRate] * 100)];
    return self.consRateLabel;
}
/**
 *  创建正方论点标签
 */
- (UILabel *)createProsArgumentLabel {
    // 可重用部分
    if (self.prosArgumentLabel == nil) {
        self.prosArgumentLabel = [[UILabel alloc] init];
        self.prosArgumentLabel.numberOfLines = 0;
        self.prosArgumentLabel.textAlignment = NSTextAlignmentLeft;
        self.prosArgumentLabel.textColor = [UIColor whiteColor];
        self.prosArgumentLabel.font = [UIFont defaultBoldFontWithSize:15.0f];
    }
    // 每次设置thesisModel需更新部分
    CGFloat height = [self.thesisModel.thesisPros boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 2, CGFLOAT_MAX)
                                                               options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                            attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:15.0f]}
                                                               context:nil].size.height;
    self.prosArgumentLabel.frame = CGRectMake(HorizontalMargin
                                              , self.prosRateLabel.bottom +  UIMargin
                                              , APPLICATIONWIDTH - HorizontalMargin * 2
                                              , height);

    self.prosArgumentLabel.text = self.thesisModel.thesisPros;
    return self.prosArgumentLabel;
}
/**
 *  创建反方论点标签
 */
- (UILabel *)createConsArgumentLabel {
    // 可重用部分
    if (self.consArgumentLabel == nil) {
        self.consArgumentLabel = [[UILabel alloc] init];
        self.consArgumentLabel.numberOfLines = 0;
        self.consArgumentLabel.textAlignment = NSTextAlignmentLeft;
        self.consArgumentLabel.textColor = [UIColor whiteColor];
        self.consArgumentLabel.font = [UIFont defaultBoldFontWithSize:15.0f];
    }
    // 每次设置thesisModel需更新部分
    CGFloat height = [self.thesisModel.thesisCons boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 2, CGFLOAT_MAX)
                                                               options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                            attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:15.0f]}
                                                               context:nil].size.height;
    self.consArgumentLabel.frame = CGRectMake(HorizontalMargin
                                              , self.prosArgumentLabel.bottom + UIMargin
                                              , APPLICATIONWIDTH - HorizontalMargin * 2
                                              , height);

    self.consArgumentLabel.text = self.thesisModel.thesisCons;
    return self.consArgumentLabel;
}
/**
 *  创建回复人数标签
 */
- (UILabel *)createReplyNumberLabel {
    // 可重用部分
    if (self.replyNumberLabel == nil) {
        self.replyNumberLabel = [[UILabel alloc] init];
        self.replyNumberLabel.frame = CGRectMake(HorizontalMargin, self.consArgumentLabel.bottom + UIMargin, NumberLabelWidth, DefaultHeight);
        self.replyNumberLabel.textAlignment = NSTextAlignmentRight;
        self.replyNumberLabel.textColor = [UIColor whiteColor];
        self.replyNumberLabel.font = [UIFont defaultFontWithSize:13.0f];
    }
    // 每次设置thesisModel需更新部分
    
    self.replyNumberLabel.text = [NSString stringWithFormat:@"%d 人回复", self.thesisModel.thesisProsReplyNumber];
    return self.replyNumberLabel;
}
/**
 *  创建收藏人数标签
 */
- (UILabel *)createCollectionNumberLabel {
    // 可重用部分
    if (self.collectionNumberLabel == nil) {
        self.collectionNumberLabel = [[UILabel alloc] init];
        self.collectionNumberLabel.frame = CGRectMake(self.replyNumberLabel.right + UIMargin, self.consArgumentLabel.bottom + UIMargin, NumberLabelWidth, DefaultHeight);
        self.collectionNumberLabel.textAlignment = NSTextAlignmentRight;
        self.collectionNumberLabel.textColor = [UIColor whiteColor];
        self.collectionNumberLabel.font = [UIFont defaultFontWithSize:13.0f];
    }
    // 每次设置thesisModel需更新部分
    self.collectionNumberLabel.text = [NSString stringWithFormat:@"%d 人收藏", self.thesisModel.thesisCollectNumber];
    return self.collectionNumberLabel;
}
/**
 *  创建发表评论按钮
 */
- (UIButton *)createCommentButton {
    if (self.commentButton == nil) {
        self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.commentButton.frame = CGRectMake(APPLICATIONWIDTH - HorizontalMargin - UIMargin * 4 - ButtonDefaultWidth * 3, self.consArgumentLabel.bottom + UIMargin, ButtonDefaultWidth, DefaultHeight);
        self.commentButton.backgroundColor = [UIColor clearColor];
        // 设置图片
        [self.commentButton setOnlyImageName:@"comment_normal"];
        // 设置点击事件
        [self.commentButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self.commentButton;
}
/**
 *  创建收藏按钮
 */
- (UIButton *)createCollectionButton {
    if (self.collectionButton == nil) {
        self.collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.collectionButton .frame = CGRectMake(APPLICATIONWIDTH - HorizontalMargin - UIMargin * 2 - ButtonDefaultWidth * 2, self.consArgumentLabel.bottom + UIMargin, ButtonDefaultWidth, DefaultHeight);
        self.collectionButton .backgroundColor = [UIColor clearColor];
        // 设置图片
        [self.collectionButton  setImageNameNormal:@"collection_normal" Highlighted:@"collection_selected" Selected:@"collection_normal" Disabled:@"collection_normal"];
        // 设置点击事件
        [self.collectionButton  addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    return self.collectionButton ;
}
/**
 *  创建分享辩题按钮
 */
- (UIButton *)createShareThesisButton {
    if (self.shareThesisButton == nil) {
        self.shareThesisButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.shareThesisButton.frame = CGRectMake(APPLICATIONWIDTH - HorizontalMargin - ButtonDefaultWidth, self.consArgumentLabel.bottom + UIMargin, ButtonDefaultWidth, DefaultHeight);
        self.shareThesisButton.backgroundColor = [UIColor clearColor];
        // 设置图片
        [self.shareThesisButton setOnlyImageName:@"share_normal"];
        // 设置点击事件
        [self.shareThesisButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self.shareThesisButton;
}

#pragma mark - Button Click
/**
 *  按钮点击事件响应方法
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


#pragma mark - Private Method
/**
 *  计算正方比例
 */
- (CGFloat)calculateProsRate {
    if (self.thesisModel == nil) {
        return 0.5;
    }
    CGFloat prosRate;
    if (self.thesisModel.thesisProsReplyNumber == 0
        && self.thesisModel.thesisConsReplyNumber == 0) {
        prosRate = 0.5;
    }
    else {
        prosRate = (CGFloat)self.thesisModel.thesisProsReplyNumber / (CGFloat)(self.thesisModel.thesisProsReplyNumber + self.thesisModel.thesisConsReplyNumber);
    }
    return prosRate;
}


@end
