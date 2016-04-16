//
//  ZCPBookpostCommentCell.m
//  Apartment
//
//  Created by apple on 16/4/4.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookpostCommentCell.h"

#define HEAD_IMAGE_SIDE 25
#define LABEL_HEIGHT    20

@implementation ZCPBookpostCommentCell

#pragma mark - synthesize
@synthesize userHeadImageView       = _userHeadImageView;
@synthesize userNameLabel           = _userNameLabel;
@synthesize supportNumberLabel      = _supportNumberLabel;
@synthesize commentContentLabel     = _commentContentLabel;

#pragma mark - Setup Cell
- (void)setupContentView {
    // 第一行
    self.userHeadImageView = [[UIImageView alloc] initWithFrame:({
        CGRectMake(HorizontalMargin, VerticalMargin, HEAD_IMAGE_SIDE, HEAD_IMAGE_SIDE);
    })];
    [self.userHeadImageView changeToRound];
    self.userHeadImageView.userInteractionEnabled = YES;
    
    self.userNameLabel = [[UILabel alloc] initWithFrame:({
        CGRectMake(self.userHeadImageView.right + UIMargin, VerticalMargin, APPLICATIONWIDTH - HEAD_IMAGE_SIDE - HorizontalMargin * 2 - UIMargin, self.userHeadImageView.height);
    })];
    self.userNameLabel.textAlignment = NSTextAlignmentLeft;
    self.userNameLabel.font = [UIFont defaultFontWithSize:14.0f];
    self.userNameLabel.textColor = [UIColor lightTextDefaultColor];
    
    // 第二行
    self.supportNumberLabel = [[UILabel alloc] initWithFrame:({
        CGRectMake(HorizontalMargin, self.userHeadImageView.bottom + UIMargin, self.userHeadImageView.width, 16);
    })];
    self.supportNumberLabel.textAlignment = NSTextAlignmentCenter;
    self.supportNumberLabel.font = [UIFont defaultFontWithSize:12.0f];
    self.supportNumberLabel.textColor = [UIColor whiteColor];
    
    self.commentContentLabel = [[UILabel alloc] initWithFrame:({
        CGRectMake(self.supportNumberLabel.right + UIMargin, self.userHeadImageView.bottom + UIMargin, APPLICATIONWIDTH - self.supportNumberLabel.width - HorizontalMargin * 2 - UIMargin, ToBeCalculated);
    })];
    self.commentContentLabel.font = [UIFont defaultFontWithSize:14.0f];
    self.commentContentLabel.numberOfLines = 3;
    self.commentContentLabel.textColor = [UIColor textDefaultColor];
    
    self.userHeadImageView.backgroundColor = [UIColor clearColor];
    self.userNameLabel.backgroundColor = [UIColor clearColor];
    self.supportNumberLabel.backgroundColor = [UIColor buttonDefaultColor];
    self.commentContentLabel.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.userHeadImageView];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.supportNumberLabel];
    [self.contentView addSubview:self.commentContentLabel];
}
- (void)setObject:(NSObject *)object {
    if (object && self.item != object) {
        self.item = (ZCPBookPostCommentModel *)object;
        
        // 设置属性
        [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:self.item.user.userFaceURL] placeholderImage:[UIImage imageNamed:HEAD_IMAGE_NAME_DEFAULT]];
        WEAK_SELF;
        [self.userHeadImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            // 跳转到用户信息详情
            [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_USER_INFO_DETAIL paramDictForInit:@{@"_currUserModel": weakSelf.item.user}];
        }]];
        self.userNameLabel.text = self.item.user.userName;
        self.supportNumberLabel.text = [NSString getFormateFromNumberOfPeople:self.item.commentSupport];
        self.commentContentLabel.text = self.item.commentContent;
        
        // 计算内容高度
        CGFloat contentLabelHeight = [self.commentContentLabel.text boundingRectWithSize:CGSizeMake(self.commentContentLabel.width, 60.0f) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]} context:nil].size.height;
        self.commentContentLabel.height = (contentLabelHeight > LABEL_HEIGHT)? contentLabelHeight: LABEL_HEIGHT;
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPBookPostCommentModel *item = (ZCPBookPostCommentModel *)object;
    CGFloat cellHeight;
    
    // 计算内容高度
    CGFloat contentLabelHeight = [item.commentContent boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HEAD_IMAGE_SIDE - HorizontalMargin * 2 - UIMargin, 60.0f) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]} context:nil].size.height;
    
    cellHeight = VerticalMargin * 2 + HEAD_IMAGE_SIDE + UIMargin + ((contentLabelHeight > LABEL_HEIGHT)? contentLabelHeight: LABEL_HEIGHT);
    return cellHeight;
}

@end
