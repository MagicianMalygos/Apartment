//
//  ZCPCoupletReplyCell.m
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPCoupletReplyCell.h"

@implementation ZCPCoupletReplyCell

@synthesize userHeadImgView = _userHeadImgView;
@synthesize userNameLabel = _userNameLabel;
@synthesize supportButton = _supportButton;
@synthesize replyContentLabel = _replyContentLabel;
@synthesize replyTimeLabel = _replyTimeLabel;
@synthesize item = _item;

#pragma mark - Setup Cell
- (void)setupContentView {
    
    // 第一行
    self.userHeadImgView = [[UIImageView alloc] initWithFrame:CGRectMake(HorizontalMargin
                                                                         , VerticalMargin
                                                                         , 25
                                                                         , 25)];
    self.supportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.supportButton.frame = CGRectMake(CELLWIDTH_DEFAULT - HorizontalMargin - 20
                                          , VerticalMargin + 5
                                          , 20
                                          , 20);
    [self.supportButton setImageNameNormal:@"support_normal" Highlighted:@"support_selected" Selected:@"support_selected" Disabled:@"support_normal"];
    [self.supportButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userHeadImgView.right + UIMargin
                                                                   , VerticalMargin
                                                                   , CELLWIDTH_DEFAULT - HorizontalMargin * 2 - UIMargin * 2 - self.userHeadImgView.width - self.supportButton.width
                                                                   , 25)];
    self.userNameLabel.textAlignment = NSTextAlignmentLeft;
    self.userNameLabel.font = [UIFont defaultFontWithSize:14.0f];
    
    // 第二行
    self.replyContentLabel = [[UILabel alloc] init];
    self.replyContentLabel.numberOfLines = 0;
    self.replyContentLabel.font = [UIFont defaultBoldFontWithSize:18.0f];
    self.replyContentLabel.textAlignment = NSTextAlignmentLeft;
    
    // 第三行
    self.replyTimeLabel = [[UILabel alloc] init];
    self.replyTimeLabel.textAlignment = NSTextAlignmentRight;
    self.replyTimeLabel.font = [UIFont defaultFontWithSize:13.0f];
    
    self.userHeadImgView.backgroundColor = [UIColor clearColor];
    self.userNameLabel.backgroundColor = [UIColor clearColor];
    self.supportButton.backgroundColor = [UIColor clearColor];
    self.replyContentLabel.backgroundColor = [UIColor clearColor];
    self.replyTimeLabel.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.userHeadImgView];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.supportButton];
    [self.contentView addSubview:self.replyContentLabel];
    [self.contentView addSubview:self.replyTimeLabel];
}

- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPCoupletReplyCellItem class]] && self.item != object) {
        self.item = (ZCPCoupletReplyCellItem *)object;
        
        // 计算高度
        CGFloat contentHeight = [self.item.replyContent boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - HorizontalMargin * 2, CGFLOAT_MAX)
                                                                     options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                                  attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:18.0f]}
                                                                     context:nil].size.height;
        
        // 设置frame
        self.replyContentLabel.frame = CGRectMake(HorizontalMargin
                                                  , self.userHeadImgView.bottom + UIMargin
                                                  , CELLWIDTH_DEFAULT - HorizontalMargin * 2
                                                  , contentHeight);
        self.replyTimeLabel.frame = CGRectMake(HorizontalMargin
                                               , self.replyContentLabel.bottom + UIMargin
                                               , CELLWIDTH_DEFAULT - HorizontalMargin * 2
                                               , 20);
        
        // 设置内容
        self.delegate = self.item.delegate;
        [self.userHeadImgView sd_setImageWithURL:[NSURL URLWithString:self.item.userHeadImageURL] placeholderImage:[UIImage imageNamed:@"head_default"]];
        self.supportButton.selected = (self.item.replySupported == ZCPCurrUserHaveSupportCoupletReply)? YES: NO;
        self.userNameLabel.text = self.item.userName;
        self.replyContentLabel.text = self.item.replyContent;
        self.replyTimeLabel.text = [self.item.replyTime toString];
        
        // 设置cell高度
        self.item.cellHeight = [NSNumber numberWithFloat:self.replyTimeLabel.bottom + VerticalMargin];
        
        [self.userHeadImgView changeToRound];
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPCoupletReplyCellItem *item = (ZCPCoupletReplyCellItem *)object;
    // 计算高度
    CGFloat contentHeight = [item.replyContent boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - HorizontalMargin * 2, CGFLOAT_MAX)
                                                            options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                         attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:18.0f]}
                                                            context:nil].size.height;
    return 25.0f + contentHeight + 20.0f + UIMargin * 2 + VerticalMargin * 2;
}

#pragma mark - Button Click
- (void)buttonClicked:(UIButton *)button {
    if (self.delegate
        && button == self.supportButton
        && [self.delegate respondsToSelector:@selector(coupletReplyCell:supportButtonClicked:)]) {
            [self.delegate coupletReplyCell:self supportButtonClicked:button];
    }
}

@end

@implementation ZCPCoupletReplyCellItem

@synthesize replyContent = _replyContent;
@synthesize userHeadImageURL = _userHeadImageURL;
@synthesize userName = _userName;
@synthesize replyTime = _replyTime;

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPCoupletReplyCell class];
        self.cellType = [ZCPCoupletReplyCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPCoupletReplyCell class];
        self.cellType = [ZCPCoupletReplyCell cellIdentifier];
    }
    return self;
}
@end
