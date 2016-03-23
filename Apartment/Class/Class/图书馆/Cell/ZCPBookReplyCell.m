
//
//  ZCPBookReplyCell.m
//  Apartment
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookReplyCell.h"

#define ButtonWidth     20  // 按钮宽度
#define ButtonHeight    20  // 按钮高度
#define TimeLabelWidth  80  // 时间标签宽度

@implementation ZCPBookReplyCell

@synthesize userHeadImageView       = _userHeadImageView;
@synthesize userNameLabel           = _userNameLabel;
@synthesize bookreplyContentLabel   = _bookreplyContentLabel;
@synthesize bookreplyTiemLabel      = _bookreplyTiemLabel;
@synthesize bookreplySupportLabel   = _bookreplySupportLabel;
@synthesize supportButton           = _supportButton;
@synthesize item                    = _item;

#pragma mark - Setup Cell
- (void)setupContentView {
    
    // 第一行
    self.userHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(HorizontalMargin, VerticalMargin, 20, 20)];
    [self.userHeadImageView changeToRound];  // 头像显示圆形
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userHeadImageView.right + UIMargin, VerticalMargin, APPLICATIONWIDTH - self.userHeadImageView.right - HorizontalMargin - UIMargin, 20)];
    self.userNameLabel.textAlignment = NSTextAlignmentLeft;
    self.userNameLabel.font =[UIFont defaultFontWithSize:15.0f];
    
    // 第二行
    self.bookreplyContentLabel = [[UILabel alloc] init];
    self.bookreplyContentLabel.textAlignment = NSTextAlignmentLeft;
    self.bookreplyContentLabel.font = [UIFont defaultFontWithSize:15.0f];
    self.bookreplyContentLabel.numberOfLines = 0;
    
    // 第三行
    self.bookreplyTiemLabel = [[UILabel alloc] init];
    self.bookreplyTiemLabel.textAlignment = NSTextAlignmentLeft;
    self.bookreplyTiemLabel.font = [UIFont defaultFontWithSize:13.0f];
    
    self.bookreplySupportLabel = [[UILabel alloc] init];
    self.bookreplySupportLabel.textAlignment = NSTextAlignmentRight;
    self.bookreplySupportLabel.font = [UIFont defaultFontWithSize:13.0f];
    
    self.supportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.supportButton setImageNameNormal:@"support_normal"
                               Highlighted:@"support_selected"
                                  Selected:@"support_selected"
                                  Disabled:@"support_normal"];
    [self.supportButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.userHeadImageView.backgroundColor = [UIColor clearColor];
    self.userNameLabel.backgroundColor = [UIColor clearColor];
    self.bookreplyContentLabel.backgroundColor = [UIColor clearColor];
    self.bookreplyTiemLabel.backgroundColor = [UIColor clearColor];
    self.bookreplySupportLabel.backgroundColor = [UIColor clearColor];
    self.supportButton.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.userHeadImageView];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.bookreplyContentLabel];
    [self.contentView addSubview:self.bookreplyTiemLabel];
    [self.contentView addSubview:self.bookreplySupportLabel];
    [self.contentView addSubview:self.supportButton];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPBookReplyCellItem class]]) {
        self.item = (ZCPBookReplyCellItem *)object;
        
        // 计算内容标签高度
        CGFloat contentLabelHeight = [self.item.bookreplyContent boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin, CGFLOAT_MAX)
                                                                              options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                                           attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:15.0f]}
                                                                              context:nil].size.height;
        
        // 设置frame
        self.bookreplyContentLabel.frame = CGRectMake(HorizontalMargin
                                                      , self.userHeadImageView.bottom + UIMargin
                                                      , APPLICATIONWIDTH - HorizontalMargin * 2
                                                      , contentLabelHeight);
        self.bookreplyTiemLabel.frame = CGRectMake(HorizontalMargin
                                                   , self.bookreplyContentLabel.bottom + UIMargin
                                                   , TimeLabelWidth
                                                   , ButtonHeight);
        self.bookreplySupportLabel.frame = CGRectMake(APPLICATIONWIDTH - HorizontalMargin - UIMargin - ButtonWidth - TimeLabelWidth
                                                      , self.bookreplyContentLabel.bottom + UIMargin
                                                      , TimeLabelWidth
                                                      , ButtonHeight);
        self.supportButton.frame = CGRectMake(APPLICATIONWIDTH - HorizontalMargin - ButtonWidth
                                              , self.bookreplyContentLabel.bottom + UIMargin
                                              , ButtonWidth
                                              , ButtonHeight);
        
        // 设置内容
        self.delegate = self.item.delegate;
        self.supportButton.selected = (self.item.bookreplySupported == ZCPCurrUserHaveSupportBookReply)? YES: NO;
        [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:self.item.userHeadImageURL] placeholderImage:[UIImage imageNamed:HEAD_IMAGE_NAME_DEFAULT]];
        self.userNameLabel.text = self.item.userName;
        self.bookreplyContentLabel.text = self.item.bookreplyContent;
        self.bookreplyTiemLabel.text = [self.item.bookreplyTime toString];
        self.bookreplySupportLabel.text = [NSString stringWithFormat:@"%li", self.item.bookreplySupportNumber];
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPBookReplyCellItem *item = (ZCPBookReplyCellItem *)object;
    
    // 第一行
    CGFloat rowHeight1 = 20;
    // 第二行
    CGFloat rowHeight2 = [item.bookreplyContent boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin, CGFLOAT_MAX)
                                                                  options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                               attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:15.0f]}
                                                                  context:nil].size.height;
    // 第三行
    CGFloat rowHeight3 = ButtonHeight;
    // cell高度
    CGFloat cellHeight = rowHeight1 + rowHeight2 + rowHeight3 + VerticalMargin * 2 + UIMargin * 2;
    
    return cellHeight;
}

#pragma mark - Button Click
/**
 *  按钮响应方法
 */
- (void)buttonClicked:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(bookReplyCell:supportButtonClick:)]) {
        [self.delegate bookReplyCell:self supportButtonClick:button];
    }
}

@end

@implementation ZCPBookReplyCellItem

@synthesize userHeadImageURL = _userHeadImageURL;
@synthesize userName = _userName;
@synthesize bookreplyContent = _bookreplyContent;
@synthesize bookreplyTime = _bookreplyTime;
@synthesize bookreplySupportNumber = _bookreplySupportNumber;

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPBookReplyCell class];
        self.cellType = [ZCPBookReplyCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPBookReplyCell class];
        self.cellType = [ZCPBookReplyCell cellIdentifier];
    }
    return self;
}

@end
