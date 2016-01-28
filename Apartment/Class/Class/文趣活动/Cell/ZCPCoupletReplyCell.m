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

- (void)setupContentView {
    [super setupContentView];
    
    // 第一行
    self.userHeadImgView = [[UIImageView alloc] initWithFrame:CGRectMake(HorizontalMargin, VerticalMargin, 25, 25)];
    self.supportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.supportButton.frame = CGRectMake(APPLICATIONWIDTH - HorizontalMargin - 20, VerticalMargin + 5, 20, 20);
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userHeadImgView.right + UIMargin, VerticalMargin, APPLICATIONWIDTH - HorizontalMargin * 2 - UIMargin * 2 - self.userHeadImgView.width - self.supportButton.width, 25)];
    self.userNameLabel.textAlignment = NSTextAlignmentLeft;
    self.userNameLabel.font = [UIFont systemFontOfSize:14.0f];
    
    // 第二行
    self.replyContentLabel = [[UILabel alloc] init];
    self.replyContentLabel.numberOfLines = 0;
    self.replyContentLabel.font = [UIFont systemFontOfSize:18.0f weight:10.0f];
    self.replyContentLabel.textAlignment = NSTextAlignmentLeft;
    
    // 第三行
    self.replyTimeLabel = [[UILabel alloc] init];
    self.replyTimeLabel.textAlignment = NSTextAlignmentRight;
    self.replyTimeLabel.font = [UIFont systemFontOfSize:13.0f];
    
    self.userHeadImgView.backgroundColor = [UIColor redColor];
    self.userNameLabel.backgroundColor = [UIColor blueColor];
    self.supportButton.backgroundColor = [UIColor yellowColor];
    self.replyContentLabel.backgroundColor = [UIColor magentaColor];
    self.replyTimeLabel.backgroundColor = [UIColor greenColor];
    
    [self.contentView addSubview:self.userHeadImgView];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.supportButton];
    [self.contentView addSubview:self.replyContentLabel];
    [self.contentView addSubview:self.replyTimeLabel];
}

- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPCoupletReplyCellItem class]] && self.item != object) {
        [super setObject:object];
        self.item = (ZCPCoupletReplyCellItem *)object;
        
        // 计算高度
        CGFloat contentHeight = [self.item.replyContent boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 2, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18.0f weight:10.0f]} context:nil].size.height;
        
        // 设置frame
        self.replyContentLabel.frame = CGRectMake(HorizontalMargin, self.userHeadImgView.bottom + UIMargin, APPLICATIONWIDTH - HorizontalMargin * 2, contentHeight);
        self.replyTimeLabel.frame = CGRectMake(HorizontalMargin, self.replyContentLabel.bottom + UIMargin, APPLICATIONWIDTH - HorizontalMargin * 2, 20);
        
        // 设置内容
        self.replyContentLabel.text = self.item.replyContent;
        self.replyTimeLabel.text = [ZCPDataModel stringValueFromDateValue:self.item.replyTime];
        
        // 设置cell高度
        self.item.cellHeight = [NSNumber numberWithFloat:self.replyTimeLabel.bottom + VerticalMargin];
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPCoupletReplyCellItem *item = (ZCPCoupletReplyCellItem *)object;
    // 计算高度
    CGFloat contentHeight = [item.replyContent boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 2, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18.0f weight:10.0f]} context:nil].size.height;
    return 25.0f + contentHeight + 20.0f + UIMargin * 2 + VerticalMargin * 2;
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
