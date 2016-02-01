
//
//  ZCPBookReplyCell.m
//  Apartment
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookReplyCell.h"

#define ButtonWidth     20
#define ButtonHeight    20
#define TimeLabelWidth  80

@implementation ZCPBookReplyCell

@synthesize userHeadImageView = _userHeadImageView;
@synthesize userNameLabel = _userNameLabel;
@synthesize bookreplyContentLabel = _bookreplyContentLabel;
@synthesize bookreplyTiemLabel = _bookreplyTiemLabel;
@synthesize bookreplySupportLabel = _bookreplySupportLabel;
@synthesize supportButton = _supportButton;
@synthesize item = _item;

#pragma mark - Setup Cell
- (void)setupContentView {
    
    // 第一行
    self.userHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(HorizontalMargin, VerticalMargin, 20, 20)];
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userHeadImageView.right + UIMargin, VerticalMargin, APPLICATIONWIDTH - self.userHeadImageView.right - HorizontalMargin - UIMargin, 20)];
    self.userNameLabel.textAlignment = NSTextAlignmentLeft;
    self.userNameLabel.font =[UIFont systemFontOfSize:15.0f];
    
    // 第二行
    self.bookreplyContentLabel = [[UILabel alloc] init];
    self.bookreplyContentLabel.textAlignment = NSTextAlignmentLeft;
    self.bookreplyContentLabel.font = [UIFont systemFontOfSize:13.0f];
    
    // 第三行
    self.bookreplyTiemLabel = [[UILabel alloc] init];
    self.bookreplyTiemLabel.textAlignment = NSTextAlignmentLeft;
    self.bookreplyTiemLabel.font = [UIFont systemFontOfSize:10.0f];
    
    self.bookreplySupportLabel = [[UILabel alloc] init];
    self.bookreplySupportLabel.textAlignment = NSTextAlignmentLeft;
    self.bookreplySupportLabel.font = [UIFont systemFontOfSize:10.0f];
    
    self.supportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.userHeadImageView.backgroundColor = [UIColor redColor];
    self.userNameLabel.backgroundColor = [UIColor redColor];
    self.bookreplyContentLabel.backgroundColor = [UIColor redColor];
    self.bookreplyTiemLabel.backgroundColor = [UIColor redColor];
    self.bookreplySupportLabel.backgroundColor = [UIColor redColor];
    self.supportButton.backgroundColor = [UIColor redColor];
    
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
        CGFloat contentLabelHeight = [self.item.bookreplyContent boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13.0f]} context:nil].size.height;
        
        // 设置frame
        self.bookreplyContentLabel.frame = CGRectMake(HorizontalMargin, self.userHeadImageView.bottom + UIMargin, APPLICATIONWIDTH - HorizontalMargin * 2, contentLabelHeight);
        self.bookreplyTiemLabel.frame = CGRectMake(HorizontalMargin, self.bookreplyContentLabel.bottom + UIMargin, TimeLabelWidth, ButtonHeight);
        self.bookreplySupportLabel.frame = CGRectMake(APPLICATIONWIDTH - HorizontalMargin - UIMargin - ButtonWidth - TimeLabelWidth, self.bookreplyContentLabel.bottom + UIMargin, TimeLabelWidth, ButtonHeight);
        self.supportButton.frame = CGRectMake(APPLICATIONWIDTH - HorizontalMargin - ButtonWidth, self.bookreplyContentLabel.bottom + UIMargin, ButtonWidth, ButtonHeight);
        
        // 设置内容
        self.userHeadImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.item.userHeadImageURL]]];
        self.userNameLabel.text = self.item.userName;
        self.bookreplyContentLabel.text = self.item.bookreplyContent;
        self.bookreplyTiemLabel.text = [self.item.bookreplyTime toString];
        self.bookreplySupportLabel.text = [NSString stringWithFormat:@"%lu 人点赞", self.item.bookreplySupportNumber];
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPBookReplyCellItem *item = (ZCPBookReplyCellItem *)object;
    return [item.cellHeight floatValue];
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
