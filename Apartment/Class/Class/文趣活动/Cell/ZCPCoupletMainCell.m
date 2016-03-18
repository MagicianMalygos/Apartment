//
//  ZCPCoupletMainCell.m
//  Apartment
//
//  Created by apple on 16/1/22.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPCoupletMainCell.h"

@implementation ZCPCoupletMainCell

@synthesize userHeadImgView = _userHeadImgView;
@synthesize userNameLabel = _userNameLabel;
@synthesize coupletContentLabel = _coupletContentLabel;
@synthesize timeLabel = _timeLabel;
@synthesize supportLabel = _supportLabel;
@synthesize replyNumLabel = _replyNumLabel;
@synthesize item = _item;

#pragma mark - Setup Cell
- (void)setupContentView {
    
    // 第一行
    self.userHeadImgView = [[UIImageView alloc] initWithFrame:CGRectMake(HorizontalMargin, VerticalMargin, 25, 25)];
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userHeadImgView.right + HorizontalMargin, VerticalMargin, CELLWIDTH_DEFAULT - self.userHeadImgView.right - HorizontalMargin * 2, 25)];
    self.userNameLabel.textAlignment = NSTextAlignmentLeft;
    self.userNameLabel.font = [UIFont defaultFontWithSize:14.0f];
    
    // 第二行
    self.coupletContentLabel = [[UILabel alloc] init];
    self.coupletContentLabel.textAlignment = NSTextAlignmentLeft;  // 左对齐
    self.coupletContentLabel.font = [UIFont defaultBoldFontWithSize:18.0f];  // 设置字体样式
    self.coupletContentLabel.numberOfLines = 0;  // 多行显示
    
    // 第三行
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont defaultFontWithSize:13.0f];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.supportLabel = [[UILabel alloc] init];
    self.supportLabel.font = [UIFont defaultFontWithSize:13.0f];
    self.supportLabel.textAlignment = NSTextAlignmentRight;
    self.replyNumLabel = [[UILabel alloc] init];
    self.replyNumLabel.font = [UIFont defaultFontWithSize:13.0f];
    self.replyNumLabel.textAlignment = NSTextAlignmentRight;
    
    // 设置背景颜色
    self.userHeadImgView.backgroundColor = [UIColor clearColor];
    self.userNameLabel.backgroundColor = [UIColor clearColor];
    self.coupletContentLabel.backgroundColor = [UIColor clearColor];
    self.timeLabel.backgroundColor = [UIColor clearColor];
    self.supportLabel.backgroundColor = [UIColor clearColor];
    self.replyNumLabel.backgroundColor = [UIColor clearColor];
    
    
    [self addSubview:self.userHeadImgView];
    [self addSubview:self.userNameLabel];
    [self addSubview:self.coupletContentLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.supportLabel];
    [self addSubview:self.replyNumLabel];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPCoupletMainCellItem class]] && self.item != object) {
        self.item = (ZCPCoupletMainCellItem *)object;
        
        // 计算高度
        CGFloat contentHeight = [self.item.coupletContent boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - 2 * HorizontalMargin, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:18.0f]} context:nil].size.height;
        
        // 设置frame
        self.coupletContentLabel.frame = CGRectMake(HorizontalMargin, self.userHeadImgView.bottom + UIMargin, CELLWIDTH_DEFAULT - 2 * HorizontalMargin, contentHeight);
        self.timeLabel.frame = CGRectMake(CELLWIDTH_DEFAULT - HorizontalMargin - 100, self.coupletContentLabel.bottom + VerticalMargin, 100, 20);
        self.replyNumLabel.frame = CGRectMake(self.timeLabel.left - UIMargin - 80, self.timeLabel.y, 80, 20);
        self.supportLabel.frame = CGRectMake(self.replyNumLabel.left - UIMargin - 80, self.timeLabel.y, 80, 20);
        
        // 设置内容
        [self.userHeadImgView sd_setImageWithURL:[NSURL URLWithString:self.item.userHeadImageURL] placeholderImage:[UIImage imageNamed:HEAD_IMAGE_NAME_DEFAULT]];
        self.userNameLabel.text = self.item.userName;
        [self.coupletContentLabel setText:self.item.coupletContent];
        self.supportLabel.text = [NSString stringWithFormat:@"%li 人点赞", self.item.supportNumber];
        self.replyNumLabel.text = [NSString stringWithFormat:@"%li 人回复", self.item.replyNumber];
        self.timeLabel.text = [self.item.time toString];
        
        // 设置cell高度
        self.item.cellHeight = [NSNumber numberWithFloat:self.timeLabel.bottom + VerticalMargin];
        
        [self.userHeadImgView changeToRound];
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPCoupletMainCellItem *item = (ZCPCoupletMainCellItem *)object;
    
    // 第一行
    CGFloat rowHeight1 = 25.0f;
    // 第二行
    CGFloat rowHeight2 = [item.coupletContent boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - 2 * HorizontalMargin
                                                                              , CGFLOAT_MAX)
                                                           options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                        attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:18.0f]}
                                                           context:nil].size.height;
    // 第三行
    CGFloat rowHeight3 = 20.0f;
    // cell高度
    CGFloat cellHeight = rowHeight1 + rowHeight2 + rowHeight3 + VerticalMargin * 2 + UIMargin * 2;
    
    return cellHeight;
}


@end

@implementation ZCPCoupletMainCellItem

@synthesize userHeadImageURL = _userHeadImageURL;
@synthesize userName = _userName;
@synthesize coupletContent = _coupletContent;
@synthesize time = _time;
@synthesize supportNumber = _supportNumber;
@synthesize replyNumber = _replyNumber;

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPCoupletMainCell class];
        self.cellType = [ZCPCoupletMainCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPCoupletMainCell class];
        self.cellType = [ZCPCoupletMainCell cellIdentifier];
    }
    return self;
}

@end