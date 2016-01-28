//
//  ZCPButtonCell.h
//  Apartment
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewCell.h"

@class ZCPButtonCellItem;
@protocol ZCPButtonCellDelegate;

// 按钮初始状态枚举
typedef enum {
    ZCPButtonInitStateNormal=100,   // normal
    ZCPButtonInitStateHighlighted,  // highlighted
    ZCPButtonInitStateDisabled      // disabled
}ZCPButtonInitialize;


// 只有一个Button的Cell
@interface ZCPButtonCell : ZCPTableViewCell

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) ZCPButtonCellItem *item;
@property (nonatomic, weak) id<ZCPButtonCellDelegate> delegate;

@end

@interface ZCPButtonCellItem : ZCPDataModel

@property (nonatomic, copy) NSString *buttonTitle;
@property (nonatomic, strong) UIColor *titleColorNormal;
@property (nonatomic, strong) UIColor *titleColorHighlighted;
@property (nonatomic, strong) UIFont *titleFontNormal;
@property (nonatomic, strong) UIColor *buttonBackgroundColor;
@property (nonatomic, strong) UIImage *buttonBackgroundImageNormal;
@property (nonatomic, strong) UIImage *buttonBackgroundImageHighlighted;
@property (nonatomic, strong) UIImage *buttonBackgroundImageDisabled;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) ZCPButtonInitialize state;
@property (nonatomic, weak) id<ZCPButtonCellDelegate> delegate;
@property (nonatomic, copy) void(^buttonConfigBlock)(UIButton *button);

@end

@protocol ZCPButtonCellDelegate <NSObject>

- (void)cell:(UITableViewCell *)cell buttonClicked:(UIButton *)button;

@end