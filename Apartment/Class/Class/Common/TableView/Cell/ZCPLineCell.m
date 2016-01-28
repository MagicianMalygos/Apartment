//
//  ZCPLineCell.m
//  Apartment
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPLineCell.h"

@implementation ZCPLineCell

- (void)setupContentView {
    self.backgroundColor = [UIColor clearColor];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPLineCellItem class]] && self.item != object) {
        self.item = (ZCPLineCellItem *)object;
        ZCPLineCellItem *item = (ZCPLineCellItem *)object;
        
        self.backgroundColor = item.backgroundColor;
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPLineCellItem *item = (ZCPLineCellItem *)object;
    return [item.cellHeight floatValue];
}

@end

@implementation ZCPLineCellItem

- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPLineCell class];
        self.cellType = [ZCPLineCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPLineCell class];
        self.cellType = [ZCPLineCell cellIdentifier];
        self.cellHeight = @20;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end