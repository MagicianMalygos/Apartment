//
//  ZCPAddPictureCell.m
//  Apartment
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPAddPictureCell.h"

@implementation ZCPAddPictureCell

#pragma mark - Setup Cell
- (void)setupContentView {
    // 图片
    self.uploadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(HorizontalMargin, VerticalMargin, (150 - VerticalMargin * 2) * 0.618, 150 - VerticalMargin * 2)];
    // 提示文字
    self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.uploadImageView.right + UIMargin, self.uploadImageView.center.y - 15, APPLICATIONWIDTH - HorizontalMargin * 2 - UIMargin - self.uploadImageView.width, 30)];
    self.tipLabel.textAlignment = NSTextAlignmentLeft;
    self.tipLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
    
    self.uploadImageView.backgroundColor = [UIColor redColor];
    self.tipLabel.backgroundColor = [UIColor redColor];
    
    [self.contentView addSubview:self.uploadImageView];
    [self.contentView addSubview:self.tipLabel];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPAddPictureCellItem class]]) {
        self.item = (ZCPAddPictureCellItem *)object;
        
        // 设置信息
        self.tipLabel.text = self.item.tipText;
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPAddPictureCellItem *item = (ZCPAddPictureCellItem *)object;
    return [item.cellHeight floatValue];
}

@end

@implementation ZCPAddPictureCellItem

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPAddPictureCell class];
        self.cellType = [ZCPAddPictureCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPAddPictureCell class];
        self.cellType = [ZCPAddPictureCell cellIdentifier];
        self.cellHeight = @150;
    }
    return self;
}

@end