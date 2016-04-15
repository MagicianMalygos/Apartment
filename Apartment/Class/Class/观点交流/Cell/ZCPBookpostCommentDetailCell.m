//
//  ZCPBookpostCommentDetailCell.m
//  Apartment
//
//  Created by apple on 16/4/4.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookpostCommentDetailCell.h"

#define IMAGE_SIDE          30   // 图片边长
#define TIME_LABEL_WIDTH    120  // 时间标签宽度

@implementation ZCPBookpostCommentDetailCell

#pragma mark - synthesize
@synthesize userHeadImageView       = _userHeadImageView;
@synthesize userNameLabel           = _userNameLabel;
@synthesize supportButton           = _supportButton;
@synthesize commentContentLabel     = _commentContentLabel;
@synthesize commentTimeLabel        = _commentTimeLabel;

#pragma mark - Setup Cell
- (void)setupContentView {
    // 第一行
    self.userHeadImageView = [[UIImageView alloc] initWithFrame:({
        CGRectMake(HorizontalMargin, VerticalMargin, IMAGE_SIDE, IMAGE_SIDE);
    })];
    [self.userHeadImageView changeToRound];
    self.userHeadImageView.userInteractionEnabled = YES;
    
    self.replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.replyButton.frame = CGRectMake(APPLICATIONWIDTH - HorizontalMargin - UIMargin * 2 - 20 * 2, VerticalMargin, 20, 20);
    [self.replyButton setOnlyImageName:@"comment_normal"];
    [self.replyButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.supportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.supportButton.frame = CGRectMake(APPLICATIONWIDTH - HorizontalMargin - 20, VerticalMargin, 20, 20);
    [self.supportButton setImageNameNormal:@"support_normal" Highlighted:@"support_selected" Selected:@"support_selected" Disabled:@"support_normal"];
    [self.supportButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.userNameLabel = [[UILabel alloc] initWithFrame:({
        CGRectMake(self.userHeadImageView.right + UIMargin, VerticalMargin, APPLICATIONWIDTH - 20 - IMAGE_SIDE - HorizontalMargin * 2 - UIMargin * 2, 20);
    })];
    self.userNameLabel.font = [UIFont defaultFontWithSize:14.0f];
    
    // 第二行
    self.commentContentLabel = [[UILabel alloc] initWithFrame:({
        CGRectMake(HorizontalMargin, self.userHeadImageView.bottom + UIMargin, APPLICATIONWIDTH - HorizontalMargin * 2, ToBeCalculated);
    })];
    self.commentContentLabel.font = [UIFont defaultFontWithSize:14.0f];
    self.commentContentLabel.numberOfLines = 0;
    
    // 第三行
    self.commentTimeLabel = [[UILabel alloc] initWithFrame:({
        CGRectMake(APPLICATIONWIDTH - HorizontalMargin - TIME_LABEL_WIDTH, ToBeCalculated, TIME_LABEL_WIDTH, 20);
    })];
    self.commentTimeLabel.alpha = 0.6f;
    self.commentTimeLabel.font = [UIFont defaultFontWithSize:14.0f];
    
    self.userHeadImageView.backgroundColor = [UIColor clearColor];
    self.replyButton.backgroundColor = [UIColor clearColor];
    self.supportButton.backgroundColor = [UIColor clearColor];
    self.userNameLabel.backgroundColor = [UIColor clearColor];
    self.commentContentLabel.backgroundColor = [UIColor clearColor];
    self.commentTimeLabel.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.userHeadImageView];
    [self.contentView addSubview:self.replyButton];
    [self.contentView addSubview:self.supportButton];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.commentContentLabel];
    [self.contentView addSubview:self.commentTimeLabel];
}
- (void)setObject:(NSObject *)object {
    if (object && self.item != object) {
        self.item = (ZCPBookpostCommentDetailCellItem *)object;
        
        // 设置属性
        [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:self.item.bookpostCommentModel.user.userFaceURL] placeholderImage:[UIImage imageNamed:HEAD_IMAGE_NAME_DEFAULT]];
        WEAK_SELF;
        [self.userHeadImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            // 跳转到用户信息详情
            [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_USER_INFO_DETAIL paramDictForInit:@{@"_currUserModel": weakSelf.item.bookpostCommentModel.user}];
        }]];
        self.userNameLabel.text = self.item.bookpostCommentModel.user.userName;
        self.supportButton.selected = (self.item.bookpostCommentModel.supported == ZCPCurrUserHaveSupportBookpostComment)? YES: NO;
        self.commentContentLabel.text = self.item.bookpostCommentModel.commentContent;
        self.commentTimeLabel.text = [NSString stringWithFormat:@"发表于 %@", [self.item.bookpostCommentModel.commentTime toString]];
        
        // 设置frame
        CGFloat contentHeight = [self.commentContentLabel.text boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 2, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]} context:nil].size.height;
        self.commentContentLabel.height = contentHeight;
        self.commentTimeLabel.top = self.commentContentLabel.bottom + UIMargin;
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPBookpostCommentDetailCellItem *item = (ZCPBookpostCommentDetailCellItem *)object;
    
    CGFloat contentHeight = [item.bookpostCommentModel.commentContent boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 2, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]} context:nil].size.height;
    return 30 + contentHeight + 20 + HorizontalMargin * 2 + UIMargin * 2;
}

#pragma mark - Button Clicked
- (void)buttonClicked:(UIButton *)button {
    
    if (!self.item.delegate) {
        return;
    }
    
    if (button == self.replyButton && [self.item.delegate respondsToSelector:@selector(bookpostCommentDetailCell:replyButtonClicked:)]) {
        [self.item.delegate bookpostCommentDetailCell:self replyButtonClicked:button];
    } else if (button == self.supportButton && [self.item.delegate respondsToSelector:@selector(bookpostCommentDetailCell:supportButtonClicked:)]) {
        [self.item.delegate bookpostCommentDetailCell:self supportButtonClicked:button];
    }
}

@end

@implementation ZCPBookpostCommentDetailCellItem

#pragma mark - synthesize
@synthesize bookpostCommentModel    = _bookpostCommentModel;
@synthesize delegate                = _delegate;

#pragma mark - init
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPBookpostCommentDetailCell class];
        self.cellType = [ZCPBookpostCommentDetailCell cellIdentifier];
    }
    return self;
}

@end
