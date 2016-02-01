//
//  ZCPIntroductionCell.m
//  Apartment
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPIntroductionCell.h"

@implementation ZCPIntroductionCell

#pragma mark - Setup Cell
- (void)setupContentView {
    self.introductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(HorizontalMargin, VerticalMargin, APPLICATIONWIDTH, 0)];
    self.introductionLabel.numberOfLines = 0;
    self.introductionLabel.textAlignment = NSTextAlignmentLeft;
    self.introductionLabel.font = [UIFont fontWithName:@"CourierNewPSMT" size:13.0f];
    
    [self.contentView addSubview:self.introductionLabel];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPIntroductionCellItem class]]) {
        self.item = (ZCPIntroductionCellItem *)object;
        
        // 设置高度
        CGFloat labelHeight = [self.item.introductionString boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 2, CGFLOAT_MAX)
                                                                         options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                                      attributes:@{NSFontAttributeName: [UIFont fontWithName:@"CourierNewPSMT" size:13.0f]}
                                                                         context:nil].size.height;
        [self.introductionLabel setHeight:labelHeight];
        
        // 设置简介内容
        self.introductionLabel.text = (self.item.introductionString != nil && ![self.item.introductionString isEqualToString:@""])? self.item.introductionString: @"暂无简介...";
        
        self.item.cellHeight = [NSNumber numberWithFloat:(labelHeight > 50)? labelHeight: 50];
    }
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPIntroductionCellItem *item = (ZCPIntroductionCellItem *)object;
    return [item.cellHeight floatValue];
}


@end

@implementation ZCPIntroductionCellItem

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPIntroductionCell class];
        self.cellType = [ZCPIntroductionCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPIntroductionCell class];
        self.cellType = [ZCPIntroductionCell cellIdentifier];
        self.cellHeight = @50;
    }
    return self;
}


@end