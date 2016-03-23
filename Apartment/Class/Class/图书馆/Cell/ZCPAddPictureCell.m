//
//  ZCPAddPictureCell.m
//  Apartment
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPAddPictureCell.h"

#define COVER_HEIGHT            (150 - VerticalMargin * 2)      // 封面高度
#define COVER_RATE              0.707f                          // 封面宽高比
#define COVER_WIDTH             (COVER_HEIGHT * COVER_RATE)     // 封面宽度

@implementation ZCPAddPictureCell

#pragma mark - Setup Cell
- (void)setupContentView {
    // 图片
    self.uploadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(HorizontalMargin
                                                                         , VerticalMargin
                                                                         , COVER_WIDTH
                                                                         , COVER_HEIGHT)];
    // 提示文字
    self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.uploadImageView.right + UIMargin
                                                              , self.uploadImageView.center.y - 15
                                                              , APPLICATIONWIDTH - HorizontalMargin * 2 - UIMargin - self.uploadImageView.width
                                                              , 30)];
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel.font = [UIFont defaultBoldFontWithSize:18.0f];
    
    // 背景颜色
    self.uploadImageView.backgroundColor = [UIColor clearColor];
    self.tipLabel.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.uploadImageView];
    [self.contentView addSubview:self.tipLabel];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPAddPictureCellItem class]]) {
        self.item = (ZCPAddPictureCellItem *)object;
        
        // 设置属性
        self.tipLabel.text = self.item.tipText;
        if (self.item.uploadImage) {
            [self.uploadImageView setImage:self.item.uploadImage];
        } else {
            [self.uploadImageView setImage:[UIImage imageNamed:@"cover_default"]];
        }
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