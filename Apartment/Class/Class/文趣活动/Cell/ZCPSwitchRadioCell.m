//
//  ZCPSwitchRadioCell.m
//  Apartment
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPSwitchRadioCell.h"

@implementation ZCPSwitchRadioCell

- (void)setupContentView {
    [super setupContentView];
    
    self.switchView = [[UISwitch alloc] init];
    self.switchLabel = [[UILabel alloc] init];
    self.switchLabel.textAlignment = NSTextAlignmentLeft;
    self.switchLabel.font = [UIFont systemFontOfSize:15.0f];
    
    self.radioButtonOne = [UIButton buttonWithType:UIButtonTypeCustom];
    self.radioButtonOne.backgroundColor = [UIColor redColor];
    
    self.radioLabelOne = [[UILabel alloc] init];
    self.radioLabelOne.textAlignment = NSTextAlignmentLeft;
    self.radioLabelOne.font = [UIFont systemFontOfSize:15.0f];
    
    self.radioButtonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    self.radioButtonTwo.backgroundColor = [UIColor redColor];
    
    self.radioLabelTwo = [[UILabel alloc] init];
    self.radioLabelTwo.textAlignment = NSTextAlignmentLeft;
    self.radioLabelTwo.font = [UIFont systemFontOfSize:15.0f];
    
    [self.contentView addSubview:self.switchView];
    [self.contentView addSubview:self.switchLabel];
    [self.contentView addSubview:self.radioButtonOne];
    [self.contentView addSubview:self.radioLabelOne];
    [self.contentView addSubview:self.radioButtonTwo];
    [self.contentView addSubview:self.radioLabelTwo];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPSwitchRadioCellItem class]] && self.item != object) {
        [super setObject:object];
        self.item = (ZCPSwitchRadioCellItem *)object;
        
        // 设置frame
        self.switchView.frame = CGRectMake(HorizontalMargin, VerticalMargin, self.switchView.width, self.switchView.height);
        self.switchLabel.frame = CGRectMake(self.switchView.right + UIMargin, VerticalMargin, self.switchView.width, self.switchView.height);
        self.radioButtonOne.frame = CGRectMake(APPLICATIONWIDTH - HorizontalMargin - UIMargin * 3 - self.switchView.height * 4, VerticalMargin, self.switchView.height, self.switchView.height);
        self.radioLabelOne.frame = CGRectMake(self.radioButtonOne.right + UIMargin, VerticalMargin, self.switchView.height, self.switchView.height);
        self.radioButtonTwo.frame = CGRectMake(self.radioLabelOne.right + UIMargin, VerticalMargin, self.switchView.height, self.switchView.height);
        self.radioLabelTwo.frame = CGRectMake(self.radioButtonTwo.right + UIMargin, VerticalMargin, self.switchView.height, self.switchView.height);
        
        // 设置属性
        self.switchView.on = self.item.switchInitialValue;
        self.switchLabel.text = self.item.switchTipText;
        self.radioLabelOne.text = self.item.radioTipTextOne;
        self.radioLabelTwo.text = self.item.radioTipTextTwo;
        
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPSwitchRadioCellItem *item = (ZCPSwitchRadioCellItem *)object;
    return [item.cellHeight floatValue];
}


@end

@implementation ZCPSwitchRadioCellItem

- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPSwitchRadioCell class];
        self.cellType = [ZCPSwitchRadioCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPSwitchRadioCell class];
        self.cellType = [ZCPSwitchRadioCell cellIdentifier];
        self.cellHeight = @47;
    }
    return self;
}

@end