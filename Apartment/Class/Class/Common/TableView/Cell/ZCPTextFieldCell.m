//
//  ZCPTextFieldCell.m
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTextFieldCell.h"

@implementation ZCPTextFieldCell

@synthesize textField = _textField;
@synthesize item = _item;

#pragma mark - Setup Cell
- (void)setupContentView {
    
    self.textField = [[UITextField alloc] init];
    [self.contentView addSubview:self.textField];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPTextFieldCellItem class]] && self.item != object) {
        self.item = (ZCPTextFieldCellItem *)object;
        ZCPTextFieldCellItem *item = (ZCPTextFieldCellItem *)object;
        CGFloat cellHeight = [item.cellHeight floatValue];
        
        self.textField.frame = CGRectMake(HorizontalMargin, VerticalMargin, CELLWIDTH_DEFAULT - HorizontalMargin * 2, cellHeight - VerticalMargin * 2);
        self.textField.placeholder = item.placeholder;
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPTextFieldCellItem *item = (ZCPTextFieldCellItem *)object;
    return [item.cellHeight floatValue];
}

@end

@implementation ZCPTextFieldCellItem

@synthesize textFieldConfigBlock = _textFieldConfigBlock;
@synthesize placeholder = _placeholder;

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPTextFieldCell class];
        self.cellType = [ZCPTextFieldCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPTextFieldCell class];
        self.cellType = [ZCPTextFieldCell cellIdentifier];
        self.cellHeight = @50;
    }
    return self;
}

@end
