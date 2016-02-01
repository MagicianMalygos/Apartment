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
        if (self.item.textFieldConfigBlock) {
            self.item.textFieldConfigBlock(self.textField);
        }
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPTextFieldCellItem *item = (ZCPTextFieldCellItem *)object;
    return [item.cellHeight floatValue];
}

@end

@implementation ZCPTextFieldCellItem

@synthesize textFieldConfigBlock = _textFieldConfigBlock;

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
        self.cellHeight = @46;
    }
    return self;
}

@end


@implementation ZCPLabelTextFieldCell

#pragma mark - Setup Cell
- (void)setupContentView {
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(HorizontalMargin, VerticalMargin, 0, 30)];
    self.label.numberOfLines = 1;
    self.label.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    
    self.textField = [[UITextField alloc] init],
    
    self.label.backgroundColor = [UIColor redColor];
    self.textField.backgroundColor = [UIColor redColor];
    
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.textField];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPLabelTextFieldCellItem class]]) {
        self.item = (ZCPLabelTextFieldCellItem *)object;
        ZCPLabelTextFieldCellItem *item = (ZCPLabelTextFieldCellItem *)object;
        
        // 设置label文字，并适配宽度
        self.label.text = item.labelText;
        [self.label sizeToFit];
        
        // 根据label宽度设置textField的frame
        self.textField.frame = CGRectMake(self.label.right + UIMargin, VerticalMargin, CELLWIDTH_DEFAULT - HorizontalMargin * 2 - UIMargin - self.label.width, 30);
        if (self.item.textFieldConfigBlock) {
            self.item.textFieldConfigBlock(self.textField);
        }
        // 设置label中心的y值
        self.label.center = CGPointMake(self.label.center.x, self.textField.center.y);
        
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPLabelTextFieldCellItem *item = (ZCPLabelTextFieldCellItem *)object;
    return [item.cellHeight floatValue];
}

@end

@implementation ZCPLabelTextFieldCellItem

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPLabelTextFieldCell class];
        self.cellType = [ZCPLabelTextFieldCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPLabelTextFieldCell class];
        self.cellType = [ZCPLabelTextFieldCell cellIdentifier];
        self.cellHeight = @46;
    }
    return self;
}
@end