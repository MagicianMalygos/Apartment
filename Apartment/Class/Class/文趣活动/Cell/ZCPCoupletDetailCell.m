//
//  ZCPCoupletDetailCell.m
//  Apartment
//
//  Created by apple on 16/1/23.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPCoupletDetailCell.h"

@implementation ZCPCoupletDetailCell

@synthesize commentButton = _commentButton;
@synthesize collectionButton = _collectionButton;
@synthesize supportButton = _supportButton;
@synthesize coupletContentLabel = _coupletContentLabel;
@synthesize userHeadImgView = _userHeadImgView;
@synthesize userNameLabel = _userNameLabel;
@synthesize timeLabel = _timeLabel;
@synthesize item = _item;

#pragma mark - Setup Cell
- (void)setupContentView {
    
    // 第一行
    self.supportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.supportButton.frame = CGRectMake(CELLWIDTH_DEFAULT - HorizontalMargin - 20, VerticalMargin, 20, 20);
    [self.supportButton setImageNameNormal:@"support_normal" Highlighted:@"support_selected" Selected:@"support_selected" Disabled:@"support_normal"];
    [self.supportButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectionButton.frame = CGRectMake(self.supportButton.left - UIMargin * 2 - 20, VerticalMargin, 20, 20);
    [self.collectionButton setImageNameNormal:@"collection_normal" Highlighted:@"collection_selected" Selected:@"collection_selected" Disabled:@"collection_normal"];
    [self.collectionButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentButton.frame = CGRectMake(self.collectionButton.left - UIMargin * 2 - 20, VerticalMargin, 20, 20);
    [self.commentButton setOnlyImageName:@"comment_normal"];
    [self.commentButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // 第二行
    self.coupletContentLabel = [[UILabel alloc] init];
    self.coupletContentLabel.textAlignment = NSTextAlignmentLeft;               // 左对齐
    self.coupletContentLabel.font = [UIFont defaultBoldFontWithSize:18.0f];     // 设置字体样式
    self.coupletContentLabel.numberOfLines = 0;                                 // 多行显示
    
    // 第三行
    self.userHeadImgView = [[UIImageView alloc] init];
    self.userNameLabel = [[UILabel alloc] init];
    self.userNameLabel.textAlignment = NSTextAlignmentLeft;
    self.userNameLabel.font = [UIFont defaultFontWithSize:13.0f];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.font = [UIFont defaultFontWithSize:13.0f];
    
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
        
        // 计算高度
        CGFloat contentHeight = [self.item.coupletContent boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - HorizontalMargin * 2, CGFLOAT_MAX)
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
        
        // 设置属性
        self.delegate = self.item.delegate;
        self.supportButton.selected = (self.item.coupletSupported == ZCPCurrUserHaveSupportCouplet)? YES: NO;
        self.collectionButton.selected = (self.item.coupletCollected == ZCPCurrUserHaveCollectCouplet)? YES: NO;
        self.coupletContentLabel.text = self.item.coupletContent;
        [self.userHeadImgView sd_setImageWithURL:[NSURL URLWithString:self.item.userHeadImageURL] placeholderImage:[UIImage imageNamed:@"head_default"]];
        self.userNameLabel.text = self.item.userName;
        self.timeLabel.text = [self.item.time toString];
        
        // 设置cell高度
        self.item.cellHeight = [NSNumber numberWithFloat:self.userHeadImgView.bottom + VerticalMargin];
        
        [self.userHeadImgView changeToRound];
    }
    
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPCoupletDetailCellItem *item = (ZCPCoupletDetailCellItem *)object;
    // 计算高度
    CGFloat contentHeight = [item.coupletContent boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - HorizontalMargin * 2, CGFLOAT_MAX)
                                                              options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:18.0f]}
                                                              context:nil].size.height;
    return 20.0f + contentHeight + 25.0f + UIMargin * 2 + VerticalMargin * 2;
//    return [((ZCPCoupletDetailCellItem *)item).cellHeight floatValue];
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

@synthesize coupletContent = _coupletContent;
@synthesize userHeadImageURL = _userHeadImageURL;
@synthesize userName = _userName;
@synthesize time = _time;
@synthesize supportNumber = _supportNumber;
@synthesize delegate = _delegate;

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPCoupletDetailCell class];
        self.cellType = [ZCPCoupletDetailCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPCoupletDetailCell class];
        self.cellType = [ZCPCoupletDetailCell cellIdentifier];
    }
    return self;
}

@end