//
//  ZCPOptionCell.m
//  Apartment
//
//  Created by apple on 16/1/22.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPOptionCell.h"

@implementation ZCPOptionCell

@synthesize optionView = _optionView;
@synthesize item = _item;

- (void)setupContentView {
    [super setupContentView];
    
    self.optionView = [[ZCPOptionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self addSubview:self.optionView];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPOptionCellItem class]] && self.item != object) {
        [super setObject:object];
        self.item = (ZCPOptionCellItem *)object;
        ZCPOptionCellItem *item = (ZCPOptionCellItem *)object;
        
        // 设置frame
        self.optionView.frame  = CGRectMake(0, 0, APPLICATIONWIDTH, [item.cellHeight floatValue]);
        
        // 设置属性
        [self.optionView setLabelArrWithAttributeStringArr:item.attributedStringArr];
        self.optionView.delegate = self.item.delegate;
        
        [self.optionView hideMarkView];
        [self.optionView hideLineView];
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPOptionCellItem *item = (ZCPOptionCellItem *)object;
    return [item.cellHeight floatValue];
}

@end

@implementation ZCPOptionCellItem

@synthesize attributedStringArr = _attributedStringArr;
@synthesize delegate = _delegate;

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPOptionCell class];
        self.cellType = [ZCPOptionCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPOptionCell class];
        self.cellType = [ZCPOptionCell cellIdentifier];
        self.cellHeight = @30;
    }
    return self;
}

@end