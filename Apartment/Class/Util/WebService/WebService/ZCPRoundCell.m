//
//  ZCPRoundCell.m
//  Apartment
//
//  Created by apple on 16/4/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPRoundCell.h"

@implementation ZCPRoundCell

#pragma mark - synthesize
@synthesize roundContentView = _roundContentView;

#pragma mark - setup cell
- (void)setupContentView {
    self.roundContentView = [[UIView alloc] init];
    
    self.roundContentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.roundContentView];
}
- (void)setObject:(NSObject *)object {
    if (object) {
        self.item = (ZCPRoundCellItem *)object;
        ZCPRoundCellItem *item = (ZCPRoundCellItem *)object;
        
        if (item.roundContentColor) {
            self.roundContentView.backgroundColor = item.roundContentColor;
        } else {
            self.roundContentView.backgroundColor = [UIColor whiteColor];
        }
        
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 100;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.roundContentView.frame = CGRectMake(HorizontalMargin, VerticalMargin, APPLICATIONWIDTH - HorizontalMargin * 2, self.contentView.height - VerticalMargin * 2);
    self.roundContentView.layer.masksToBounds = YES;
    self.roundContentView.layer.cornerRadius = 5.0;
}

@end

@implementation ZCPRoundCellItem

#pragma mark - synthesize
@synthesize roundContentColor = _roundContentColor;

#pragma mark - init
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPRoundCell class];
        self.cellType = [ZCPRoundCell cellIdentifier];
    }
    return self;
}

@end