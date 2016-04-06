//
//  ZCPBookpostCommentReplyCell.m
//  Apartment
//
//  Created by apple on 16/4/4.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookpostCommentReplyCell.h"

#define IMAGE_SIDE          30  // 图片边长
#define TIME_LABEL_WIDTH    70  // 时间标签宽度

@implementation ZCPBookpostCommentReplyCell

#pragma mark - synthesize
@synthesize userHeadImageView = _userHeadImageView;
@synthesize userNameLabel = _userNameLabel;
@synthesize replyTimeLabel = _replyTimeLabel;
@synthesize replyContentLabel = _replyContentLabel;
@synthesize supportButton = _supportButton;
@synthesize supportNumberLabel = _supportNumberLabel;

#pragma mark - Setup Cell
- (void)setupContentView {
    // 第一行
    self.userHeadImageView = [[UIImageView alloc] initWithFrame:({
        CGRectMake(HorizontalMargin, VerticalMargin, IMAGE_SIDE, IMAGE_SIDE);
    })];
    
    self.userNameLabel = [[UILabel alloc] initWithFrame:({
        CGRectMake(self.userHeadImageView.right + UIMargin, VerticalMargin, APPLICATIONWIDTH - IMAGE_SIDE - TIME_LABEL_WIDTH - UIMargin * 2 - HorizontalMargin * 2, 20);
    })];
    self.userNameLabel.font = [UIFont defaultFontWithSize:14.0f];
    self.userNameLabel.alpha = 0.6f;
    
    self.replyTimeLabel = [[UILabel alloc] initWithFrame:({
        CGRectMake(APPLICATIONWIDTH - TIME_LABEL_WIDTH - HorizontalMargin, VerticalMargin, TIME_LABEL_WIDTH, 20);
    })];
    self.replyTimeLabel.alpha = 0.6f;
    self.replyTimeLabel.font = [UIFont defaultFontWithSize:13.0f];
    
    // 第二行
    self.replyContentLabel = [[UILabel alloc] initWithFrame:({
        CGRectMake(self.userHeadImageView.right + UIMargin, self.userNameLabel.bottom + UIMargin, APPLICATIONWIDTH - HorizontalMargin * 2 - IMAGE_SIDE - UIMargin, ToBeCalculated);
    })];
    self.replyContentLabel.font = [UIFont defaultFontWithSize:13.0f];
    self.replyContentLabel.numberOfLines = 0;
    // 第三行
    self.supportNumberLabel = [[UILabel alloc] initWithFrame:({
        CGRectMake(APPLICATIONWIDTH - HorizontalMargin - 30, ToBeCalculated, 30, 20);
    })];
    self.supportNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.supportNumberLabel.font = [UIFont defaultFontWithSize:12.0f];
    self.supportNumberLabel.alpha = 0.6;
    
    self.supportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.supportButton.frame = CGRectMake(self.supportNumberLabel.left - UIMargin - 20, ToBeCalculated, 20, 20);
    [self.supportButton setImageNameNormal:@"support_normal" Highlighted:@"support_selected" Selected:@"support_selected" Disabled:@"support_normal"];
    [self.supportButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.userHeadImageView.backgroundColor = [UIColor clearColor];
    self.userNameLabel.backgroundColor = [UIColor clearColor];
    self.replyTimeLabel.backgroundColor = [UIColor clearColor];
    self.replyContentLabel.backgroundColor = [UIColor clearColor];
    self.supportButton.backgroundColor = [UIColor clearColor];
    self.supportNumberLabel.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.userHeadImageView];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.replyTimeLabel];
    [self.contentView addSubview:self.replyContentLabel];
    [self.contentView addSubview:self.supportButton];
    [self.contentView addSubview:self.supportNumberLabel];
}
- (void)setObject:(NSObject *)object {
    if (object && self.item != object) {
        self.item = (ZCPBookpostCommentReplyCellItem *)object;
        
        // 设置属性
        [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:self.item.replyModel.user.userFaceURL] placeholderImage:[UIImage imageNamed:HEAD_IMAGE_NAME_DEFAULT]];
        
        if (self.item.replyModel.user.userId == self.item.replyModel.receiver.userId) {
            self.userNameLabel.text = self.item.replyModel.user.userName;
        } else {
            self.userNameLabel.text = [NSString stringWithFormat:@"%@ 回复 %@", self.item.replyModel.user.userName, self.item.replyModel.receiver.userName];
        }
        
        self.replyTimeLabel.text = [self.item.replyModel.replyTime toString];
        self.replyContentLabel.text = self.item.replyModel.replyContent;
        self.supportButton.selected = (self.item.replyModel.supported == ZCPCurrUserHaveSupportBookpostCommentReply)? YES: NO;
        self.supportNumberLabel.text = [NSString getFormateFromNumberOfPeople:self.item.replyModel.replySupport];
        
        // 设置frame
        self.replyContentLabel.height = [self.replyContentLabel.text boundingRectWithSize:CGSizeMake(self.replyContentLabel.width, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]} context:nil].size.height;
        self.supportButton.top = self.replyContentLabel.bottom + UIMargin;
        self.supportNumberLabel.top = self.replyContentLabel.bottom + UIMargin;
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPBookpostCommentReplyCellItem *item = (ZCPBookpostCommentReplyCellItem *)object;
    
    CGFloat contentHeight = [item.replyModel.replyContent boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - IMAGE_SIDE - HorizontalMargin * 2 - UIMargin, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:13.0f]} context:nil].size.height;
    
    return 20 + contentHeight + 20 + HorizontalMargin * 2 + UIMargin * 2;
}

#pragma mark - Button Clicked
- (void)buttonClicked:(UIButton *)button {
    if (self.item.delegate && [self.item.delegate respondsToSelector:@selector(bookpostCommentReplyCell:supportButtonClicked:)]) {
        [self.item.delegate bookpostCommentReplyCell:self supportButtonClicked:button];
    }
}

@end

@implementation ZCPBookpostCommentReplyCellItem

#pragma mark - synthesize
@synthesize replyModel = _replyModel;
@synthesize delegate = _delegate;

#pragma mark - init
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPBookpostCommentReplyCell class];
        self.cellType = [ZCPBookpostCommentReplyCell cellIdentifier];
    }
    return self;
}

@end