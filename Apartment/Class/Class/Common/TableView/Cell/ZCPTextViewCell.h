//
//  ZCPTextViewCell.h
//  Apartment
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"
#import "ZCPTextView.h"

@class ZCPTextViewCellItem;

// 只有一个TextView的Cell
@interface ZCPTextViewCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) ZCPTextView *textView;            // 文本输入框
@property (nonatomic, strong) ZCPTextViewCellItem *item;        // item

@end

// 文本输入框TextView CellItem
@interface ZCPTextViewCellItem : ZCPDataModel

@property (nonatomic, copy) NSString *placeholder;              // 提示文字
@property (nonatomic, assign) UIEdgeInsets textEdgeInset;       // 输入框外边距
@property (nonatomic, copy) NSString *textInputValue;           // 文本输入内容
@property (nonatomic, weak) id<UITextViewDelegate> delegate;    // delegate

@end
