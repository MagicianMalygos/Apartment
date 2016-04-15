//
//  ZCPCoupletReplyCell.m
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPCoupletReplyCell.h"

@implementation ZCPCoupletReplyCell

#pragma mark - synthesize
@synthesize userHeadImgView     = _userHeadImgView;
@synthesize userNameLabel       = _userNameLabel;
@synthesize replySupportLabel   = _replySupportLabel;
@synthesize supportButton       = _supportButton;
@synthesize replyContentLabel   = _replyContentLabel;
@synthesize replyTimeLabel      = _replyTimeLabel;
@synthesize item                = _item;
@synthesize delegate            = _delegate;

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
    
    self.replySupportLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.supportButton.left - UIMargin - 80
                                                                       , VerticalMargin + 5
                                                                       , 80
                                                                       , 20)];
    self.replySupportLabel.textAlignment = NSTextAlignmentRight;
    self.replySupportLabel.font = [UIFont defaultFontWithSize:13.0f];
    
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userHeadImgView.right + UIMargin
                                                                   , VerticalMargin
                                                                   , self.replySupportLabel.left - UIMargin * 2 - HorizontalMargin - 25
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
    self.replySupportLabel.backgroundColor = [UIColor clearColor];
    self.supportButton.backgroundColor = [UIColor clearColor];
    self.replyContentLabel.backgroundColor = [UIColor clearColor];
    self.replyTimeLabel.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.userHeadImgView];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.replySupportLabel];
    [self.contentView addSubview:self.supportButton];
    [self.contentView addSubview:self.replyContentLabel];
    [self.contentView addSubview:self.replyTimeLabel];
}

- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPCoupletReplyCellItem class]] && self.item != object) {
        self.item = (ZCPCoupletReplyCellItem *)object;
        
        // 计算高度
        CGFloat contentHeight = [self.item.coupletReplyModel.replyContent boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - HorizontalMargin * 2, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:18.0f]} context:nil].size.height;
        
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
        [self.userHeadImgView sd_setImageWithURL:[NSURL URLWithString:self.item.coupletReplyModel.user.userFaceURL] placeholderImage:[UIImage imageNamed:HEAD_IMAGE_NAME_DEFAULT]];
        self.replySupportLabel.text = [NSString getFormateFromNumberOfPeople:self.item.coupletReplyModel.replySupport];
        self.supportButton.selected = (self.item.coupletReplyModel.supported == ZCPCurrUserHaveSupportCoupletReply)? YES: NO;
        self.userNameLabel.text = self.item.coupletReplyModel.user.userName;
        self.replyContentLabel.text = self.item.coupletReplyModel.replyContent;
        self.replyTimeLabel.text = [self.item.coupletReplyModel.replyTime toString];
        
        // 设置cell高度
        self.item.cellHeight = [NSNumber numberWithFloat:self.replyTimeLabel.bottom + VerticalMargin];
        
        [self.userHeadImgView changeToRound];
        self.userHeadImgView.userInteractionEnabled = YES;
        WEAK_SELF;
        [self.userHeadImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            // 跳转到用户信息详情
            [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_USER_INFO_DETAIL paramDictForInit:@{@"_currUserModel": weakSelf.item.coupletReplyModel.user}];
        }]];
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPCoupletReplyCellItem *item = (ZCPCoupletReplyCellItem *)object;
    
    // 第一行
    CGFloat rowHeight1 = 25.0f;
    // 第二行
    CGFloat rowHeight2 = [item.coupletReplyModel.replyContent boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - HorizontalMargin * 2, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:18.0f]} context:nil].size.height;
    // 第三行
    CGFloat rowHeight3 = 20.0f;
    // cell高度
    CGFloat cellHeight = rowHeight1 + rowHeight2 + rowHeight3 + VerticalMargin * 2 + UIMargin * 2;
    
    return cellHeight;
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

#pragma mark - synthesize
@synthesize coupletReplyModel   = _coupletReplyModel;
@synthesize delegate            = _delegate;

#pragma mark - instancetype
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPCoupletReplyCell class];
        self.cellType = [ZCPCoupletReplyCell cellIdentifier];
    }
    return self;
}
@end
