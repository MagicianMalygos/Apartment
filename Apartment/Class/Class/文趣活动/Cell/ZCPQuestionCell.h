//
//  ZCPQuestionCell.h
//  Apartment
//
//  Created by apple on 16/4/11.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"
#import "ZCPQuestionModel.h"

#define DEFAULT_INDEX    NSIntegerMax    // 用户选择答案默认索引，用户已回答答案默认索引

@class ZCPQuestionCellItem;
@protocol ZCPQuestionCellDelegate;

// 问题cell
@interface ZCPQuestionCell : ZCPTableViewWithLineCell

@property (nonatomic, strong) UILabel *questionContentLabel;    // 问题内容标签
@property (nonatomic, strong) UIButton *collectButton;          // 收藏按钮
@property (nonatomic, strong) UIButton *optionOneButton;        // 选项一按钮
@property (nonatomic, strong) UIButton *optionTwoButton;        // 选项二按钮
@property (nonatomic, strong) UIButton *optionThreeButton;      // 选项三按钮
@property (nonatomic, strong) UIButton *optionFourButton;       // 选项四按钮
@property (nonatomic, strong) UILabel *optionOneLabel;          // 选项一标签
@property (nonatomic, strong) UILabel *optionTwoLabel;          // 选项二标签
@property (nonatomic, strong) UILabel *optionThreeLabel;        // 选项三标签
@property (nonatomic, strong) UILabel *optionFourLabel;         // 选项四标签
@property (nonatomic, strong) ZCPQuestionCellItem *item;        // item

@end

// 问题cellItem
@interface ZCPQuestionCellItem : ZCPDataModel

@property (nonatomic, strong) ZCPQuestionModel *questionModel;      // 问题模型
@property (nonatomic, assign) BOOL userHaveAnswer;                  // 用户是否已经回答过问题
@property (nonatomic, assign) NSInteger userAnswerIndex;            // 用户答案索引（已答题的情况）
@property (nonatomic, assign) NSInteger userSelectIndex;            // 用户选择答案索引（未答题的情况）
@property (nonatomic, weak) id<ZCPQuestionCellDelegate> delegate;   // delegate

@end

@protocol ZCPQuestionCellDelegate <NSObject>
@optional
// 收藏按钮点击事件
- (void)questionCell:(ZCPQuestionCell *)cell collectButtonClicked:(UIButton *)button;
// 选项按钮点击事件
- (void)questionCell:(ZCPQuestionCell *)cell optionButtonClicked:(UIButton *)button atIndex:(NSInteger)index;

@end
