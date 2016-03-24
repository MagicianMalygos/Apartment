//
//  ZCPMultiLineTextCell.m
//  Apartment
//
//  Created by apple on 16/3/21.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPMultiLineTextCell.h"

@implementation ZCPMultiLineTextCell

#pragma mark - synthesize
@synthesize multiLineTextLabel = _multiLineTextLabel;
@synthesize item = _item;

#pragma mark - Setup Cell
- (void)setupContentView {
    self.multiLineTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(HorizontalMargin, VerticalMargin, APPLICATIONWIDTH, 0)];
    self.multiLineTextLabel.numberOfLines = 0;
    self.multiLineTextLabel.textAlignment = NSTextAlignmentLeft;
    self.multiLineTextLabel.font = [UIFont fontWithName:@"CourierNewPSMT" size:13.0f];
    
    [self.contentView addSubview:self.multiLineTextLabel];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPMultiLineTextCellItem class]]) {
        self.item = (ZCPMultiLineTextCellItem *)object;
        
        // 设置高度
        CGFloat labelHeight = [self.item.multiLineText boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 2, CGFLOAT_MAX)
                                                                         options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                                      attributes:@{NSFontAttributeName: [UIFont fontWithName:@"CourierNewPSMT" size:13.0f]}
                                                                         context:nil].size.height;
        [self.multiLineTextLabel setHeight:labelHeight];
        
        // 设置简介内容
        self.multiLineTextLabel.text = (self.item.multiLineText != nil && ![self.item.multiLineText isEqualToString:@""])? self.item.multiLineText: @"暂无简介...";
    }
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPMultiLineTextCellItem *item = (ZCPMultiLineTextCellItem *)object;
    
    // 设置高度
    CGFloat labelHeight = [item.multiLineText boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 2, CGFLOAT_MAX)
                                                                     options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                                  attributes:@{NSFontAttributeName: [UIFont fontWithName:@"CourierNewPSMT" size:13.0f]}
                                                                     context:nil].size.height;
    CGFloat cellHeight = labelHeight + UIMargin * 2;
    return (cellHeight > 50)? cellHeight: 50;
}

@end

@implementation ZCPMultiLineTextCellItem

#pragma mark - synthesize
@synthesize multiLineText = _multiLineText;

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPMultiLineTextCell class];
        self.cellType = [ZCPMultiLineTextCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPMultiLineTextCell class];
        self.cellType = [ZCPMultiLineTextCell cellIdentifier];
        self.cellHeight = @50;
    }
    return self;
}

@end