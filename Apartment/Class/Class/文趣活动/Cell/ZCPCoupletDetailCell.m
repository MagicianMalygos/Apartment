//
//  ZCPCoupletDetailCell.m
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPCoupletDetailCell.h"

@implementation ZCPCoupletDetailCell

#pragma mark - synthesize
@synthesize commentButton           = _commentButton;
@synthesize collectionButton        = _collectionButton;
@synthesize supportButton           = _supportButton;
@synthesize coupletContentLabel     = _coupletContentLabel;
@synthesize userHeadImgView         = _userHeadImgView;
@synthesize userNameLabel           = _userNameLabel;
@synthesize timeLabel               = _timeLabel;
@synthesize item                    = _item;
@synthesize delegate                = _delegate;

#pragma mark - Setup Cell
- (void)setupContentView {
    
    // 第一行
    self.supportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.supportButton setImageNameNormal:@"support_normal" Highlighted:@"support_selected" Selected:@"support_selected" Disabled:@"support_normal"];
    [self.supportButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.collectionButton setImageNameNormal:@"collection_normal" Highlighted:@"collection_selected" Selected:@"collection_selected" Disabled:@"collection_normal"];
    [self.collectionButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commentButton setOnlyImageName:@"comment_normal"];
    [self.commentButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // 第二行
    self.coupletContentLabel = [[UILabel alloc] init];
    self.coupletContentLabel.textAlignment = NSTextAlignmentLeft;               // 左对齐
    self.coupletContentLabel.font = [UIFont defaultBoldFontWithSize:18.0f];     // 设置字体样式
    self.coupletContentLabel.numberOfLines = 0;                                 // 多行显示
    self.coupletContentLabel.textColor = [UIColor boldTextDefaultColor];
    
    // 第三行
    self.userHeadImgView = [[UIImageView alloc] init];
    self.userNameLabel = [[UILabel alloc] init];
    self.userNameLabel.textAlignment = NSTextAlignmentLeft;
    self.userNameLabel.font = [UIFont defaultFontWithSize:13.0f];
    self.userNameLabel.textColor = [UIColor textDefaultColor];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.font = [UIFont defaultFontWithSize:13.0f];
    self.timeLabel.textColor = [UIColor textDefaultColor];
    
    // 设置背景颜色
    self.commentButton.backgroundColor = [UIColor clearColor];
    self.supportButton.backgroundColor = [UIColor clearColor];
    self.collectionButton.backgroundColor = [UIColor clearColor];
    self.coupletContentLabel.backgroundColor = [UIColor clearColor];
    self.userHeadImgView.backgroundColor = [UIColor clearColor];
    self.userNameLabel.backgroundColor = [UIColor clearColor];
    self.timeLabel.backgroundColor = [UIColor clearColor];
    
    // 添加
    [self.contentView addSubview:self.commentButton];
    [self.contentView addSubview:self.supportButton];
    [self.contentView addSubview:self.collectionButton];
    [self.contentView addSubview:self.coupletContentLabel];
    [self.contentView addSubview:self.userHeadImgView];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.timeLabel];
}

- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPCoupletDetailCellItem class]] && self.item != object) {
        self.item = (ZCPCoupletDetailCellItem *)object;
        
        // 设置属性
        self.delegate = self.item.delegate;
        self.supportButton.selected = (self.item.coupletModel.supported == ZCPCurrUserHaveSupportCouplet)? YES: NO;
        self.collectionButton.selected = (self.item.coupletModel.collected == ZCPCurrUserHaveCollectCouplet)? YES: NO;
        self.coupletContentLabel.text = self.item.coupletModel.coupletContent;
        [self.userHeadImgView sd_setImageWithURL:[NSURL URLWithString:self.item.coupletModel.user.userFaceURL] placeholderImage:[UIImage imageNamed:HEAD_IMAGE_NAME_DEFAULT]];
        self.userNameLabel.text = self.item.coupletModel.user.userName;
        self.timeLabel.text = [self.item.coupletModel.coupletTime toString];
        
        [self.userHeadImgView changeToRound];
        self.userHeadImgView.userInteractionEnabled = YES;
        WEAK_SELF;
        [self.userHeadImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            // 跳转到用户信息详情
            [[ZCPNavigator sharedInstance] gotoViewWithIdentifier:APPURL_VIEW_IDENTIFIER_USER_INFO_DETAIL paramDictForInit:@{@"_currUserModel": weakSelf.item.coupletModel.user}];
        }]];
        
        // 第一行
        CGFloat rowHeight1 = 20.0f;
        // 第二行
        CGFloat rowHeight2 = [_item.coupletModel.coupletContent boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - HorizontalMargin * 2, CGFLOAT_MAX)
                                                               options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                            attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:18.0f]}
                                                               context:nil].size.height;
        // 第三行
        CGFloat rowHeight3 = 25.0f;
        // cell高度
        CGFloat cellHeight = rowHeight1 + rowHeight2 + rowHeight3 + VerticalMargin * 2 + UIMargin * 2;
        
        self.item.cellHeight = @(cellHeight);
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPCoupletDetailCellItem *item = (ZCPCoupletDetailCellItem *)object;
    
    return [item.cellHeight floatValue];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.supportButton.frame = CGRectMake(CELLWIDTH_DEFAULT - HorizontalMargin - 20, VerticalMargin, 20, 20);
    self.collectionButton.frame = CGRectMake(self.supportButton.left - UIMargin * 2 - 20, VerticalMargin, 20, 20);
    self.commentButton.frame = CGRectMake(self.collectionButton.left - UIMargin * 2 - 20, VerticalMargin, 20, 20);
    
    // 计算高度
    CGFloat contentHeight = [self.item.coupletModel.coupletContent boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - HorizontalMargin * 2, CGFLOAT_MAX)
                                                                                options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                                             attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:18.0f]}
                                                                                context:nil].size.height;
    // 设置frame
    self.coupletContentLabel.frame = CGRectMake(HorizontalMargin
                                                , self.collectionButton.bottom + VerticalMargin
                                                , CELLWIDTH_DEFAULT - HorizontalMargin * 2
                                                , contentHeight);
    self.userHeadImgView.frame = CGRectMake(HorizontalMargin
                                            , self.coupletContentLabel.bottom + VerticalMargin
                                            , 25
                                            , 25);
    self.timeLabel.frame = CGRectMake(CELLWIDTH_DEFAULT - HorizontalMargin - 100
                                      , self.userHeadImgView.y
                                      , 100
                                      , 25);
    self.userNameLabel.frame = CGRectMake(self.userHeadImgView.right + UIMargin
                                          , self.userHeadImgView.y
                                          , CELLWIDTH_DEFAULT - HorizontalMargin * 2 - self.userHeadImgView.width - self.timeLabel.width - UIMargin * 2
                                          , 25);
}

#pragma mark - Button Click
/**
 *  按钮响应方法
 */
- (void)buttonClicked:(UIButton *)button {
    if (self.delegate) {
        if (button == self.supportButton && [self.delegate respondsToSelector:@selector(coupletDetailCell:supportButtonClicked:)]) {
            [self.delegate coupletDetailCell:self supportButtonClicked:button];
        }
        else if (button == self.collectionButton && [self.delegate respondsToSelector:@selector(coupletDetailCell:collectButtonClicked:)]) {
            [self.delegate coupletDetailCell:self collectButtonClicked:button];
        }
        else if (button == self.commentButton && [self.delegate respondsToSelector:@selector(coupletDetailCell:commentButtonClicked:)]) {
            [self.delegate coupletDetailCell:self commentButtonClicked:button];
        }
    }
}

@end

@implementation ZCPCoupletDetailCellItem

#pragma mark - synthesize
@synthesize coupletModel    = _coupletModel;
@synthesize delegate        = _delegate;

#pragma mark - instancetype
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPCoupletDetailCell class];
        self.cellType = [ZCPCoupletDetailCell cellIdentifier];
    }
    return self;
}

@end