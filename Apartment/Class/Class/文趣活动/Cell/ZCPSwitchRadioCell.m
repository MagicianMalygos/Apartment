//
//  ZCPSwitchRadioCell.m
//  Apartment
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPSwitchRadioCell.h"

@implementation ZCPSwitchRadioCell

@synthesize switchView = _switchView;
@synthesize switchLabel = _switchLabel;
@synthesize radioButtonOne = _radioButtonOne;
@synthesize radioLabelOne = _radioLabelOne;
@synthesize radioButtonTwo = _radioButtonTwo;
@synthesize radioLabelTwo = _radioLabelTwo;

#pragma mark - Setup Cell
- (void)setupContentView {
    
    // 开关
    self.switchView = [[UISwitch alloc] init];
    self.switchLabel = [[UILabel alloc] init];
    self.switchLabel.textAlignment = NSTextAlignmentLeft;
    self.switchLabel.font = [UIFont defaultFontWithSize:15.0f];
    // 按钮一
    self.radioButtonOne = [UIButton buttonWithType:UIButtonTypeCustom];
    // 标签一
    self.radioLabelOne = [[UILabel alloc] init];
    self.radioLabelOne.textAlignment = NSTextAlignmentLeft;
    self.radioLabelOne.font = [UIFont defaultFontWithSize:15.0f];
    // 按钮二
    self.radioButtonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    // 标签二
    self.radioLabelTwo = [[UILabel alloc] init];
    self.radioLabelTwo.textAlignment = NSTextAlignmentLeft;
    self.radioLabelTwo.font = [UIFont defaultFontWithSize:15.0f];
    
    // 设置背景颜色
    self.radioButtonOne.backgroundColor = [UIColor clearColor];
    self.radioButtonTwo.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.switchView];
    [self.contentView addSubview:self.switchLabel];
    [self.contentView addSubview:self.radioButtonOne];
    [self.contentView addSubview:self.radioLabelOne];
    [self.contentView addSubview:self.radioButtonTwo];
    [self.contentView addSubview:self.radioLabelTwo];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPSwitchRadioCellItem class]] && self.item != object) {
        self.item = (ZCPSwitchRadioCellItem *)object;
        
        // 设置属性
        self.switchView.on = self.item.switchInitialValue;
        self.switchLabel.text = self.item.switchTipText;
        self.radioLabelOne.text = self.item.radioTipTextOne;
        self.radioLabelTwo.text = self.item.radioTipTextTwo;
        
        // 设置frame
        self.switchView.frame = CGRectMake(HorizontalMargin
                                           , VerticalMargin
                                           , self.switchView.width
                                           , self.switchView.height);
        self.switchLabel.frame = CGRectMake(self.switchView.right + UIMargin
                                            , VerticalMargin
                                            , self.switchView.width
                                            , self.switchView.height);
        self.radioButtonOne.frame = CGRectMake(CELLWIDTH_DEFAULT - HorizontalMargin - UIMargin * 3 - self.switchView.height * 4
                                               , VerticalMargin
                                               , self.switchView.height
                                               , self.switchView.height);
        self.radioLabelOne.frame = CGRectMake(self.radioButtonOne.right + UIMargin
                                              , VerticalMargin
                                              , self.switchView.height
                                              , self.switchView.height);
        self.radioButtonTwo.frame = CGRectMake(self.radioLabelOne.right + UIMargin
                                               , VerticalMargin
                                               , self.switchView.height
                                               , self.switchView.height);
        self.radioLabelTwo.frame = CGRectMake(self.radioButtonTwo.right + UIMargin
                                              , VerticalMargin
                                              , self.switchView.height
                                              , self.switchView.height);
        
        // 配置块
        if (self.item.radioButtonOneConfigBlock) {
            self.item.radioButtonOneConfigBlock(self.radioButtonOne);
        }
        if (self.item.radioButtonTwoConfigBlock) {
            self.item.radioButtonTwoConfigBlock(self.radioButtonTwo);
        }
        
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPSwitchRadioCellItem *item = (ZCPSwitchRadioCellItem *)object;
    return [item.cellHeight floatValue];
}

@end

@implementation ZCPSwitchRadioCellItem

@synthesize switchInitialValue = _switchInitialValue;
@synthesize switchResponser = _switchResponser;
@synthesize switchTipText = _switchTipText;
@synthesize radioTipTextOne = _radioTipTextOne;
@synthesize radioTipTextTwo = _radioTipTextTwo;

#pragma mark - instancetype
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