//
//  ZCPQuestionCell.m
//  Apartment
//
//  Created by apple on 16/4/11.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPQuestionCell.h"

#define BUTTON_SIDE         20.0f   // 按钮边长
#define OPTION_LABEL_HEIGHT 20.0f   // 选项标签高度

@implementation ZCPQuestionCell

#pragma mark - synthesize
@synthesize questionContentLabel = _questionContentLabel;
@synthesize collectButton = _collectButton;
@synthesize optionOneButton = _optionOneButton;
@synthesize optionTwoButton = _optionTwoButton;
@synthesize optionThreeButton = _optionThreeButton;
@synthesize optionFourButton = _optionFourButton;
@synthesize optionOneLabel = _optionOneLabel;
@synthesize optionTwoLabel = _optionTwoLabel;
@synthesize optionThreeLabel = _optionThreeLabel;
@synthesize optionFourLabel = _optionFourLabel;

#pragma mark - setup cell
- (void)setupContentView {
    
    // 内容和点赞按钮
    self.questionContentLabel = [[UILabel alloc] init];
    self.questionContentLabel.numberOfLines = 0;
    self.questionContentLabel.font = [UIFont defaultBoldFontWithSize:17.0f];
    self.collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.collectButton setImageNameNormal:@"collection_normal" Highlighted:@"collectv_selected" Selected:@"collection_selected" Disabled:@"collection_normal"];
    [self.collectButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // 选项按钮
    self.optionOneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.optionOneButton setImageNameNormal:@"choice_normal" Highlighted:@"choice_selected" Selected:@"choice_selected" Disabled:@"choice_normal"];
    [self.optionOneButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.optionTwoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.optionTwoButton setImageNameNormal:@"choice_normal" Highlighted:@"choice_selected" Selected:@"choice_selected" Disabled:@"choice_normal"];
    [self.optionTwoButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.optionThreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.optionThreeButton setImageNameNormal:@"choice_normal" Highlighted:@"choice_selected" Selected:@"choice_selected" Disabled:@"choice_normal"];
    [self.optionThreeButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.optionFourButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.optionFourButton setImageNameNormal:@"choice_normal" Highlighted:@"choice_selected" Selected:@"choice_selected" Disabled:@"choice_normal"];
    [self.optionFourButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    // 选项标签
    self.optionOneLabel = [[UILabel alloc] init];
    self.optionOneLabel.numberOfLines = 0;
    self.optionOneLabel.font = [UIFont defaultFontWithSize:15.0f];
    self.optionTwoLabel = [[UILabel alloc] init];
    self.optionTwoLabel.numberOfLines = 0;
    self.optionTwoLabel.font = [UIFont defaultFontWithSize:15.0f];
    self.optionThreeLabel = [[UILabel alloc] init];
    self.optionThreeLabel.numberOfLines = 0;
    self.optionThreeLabel.font = [UIFont defaultFontWithSize:15.0f];
    self.optionFourLabel = [[UILabel alloc] init];
    self.optionFourLabel.numberOfLines = 0;
    self.optionFourLabel.font = [UIFont defaultFontWithSize:15.0f];
    
    
    self.questionContentLabel.backgroundColor = [UIColor clearColor];
    self.collectButton.backgroundColor = [UIColor clearColor];
    self.optionOneButton.backgroundColor = [UIColor clearColor];
    self.optionTwoButton.backgroundColor = [UIColor clearColor];
    self.optionThreeButton.backgroundColor = [UIColor clearColor];
    self.optionFourButton.backgroundColor = [UIColor clearColor];
    self.optionOneLabel.backgroundColor = [UIColor clearColor];
    self.optionTwoLabel.backgroundColor = [UIColor clearColor];
    self.optionThreeLabel.backgroundColor = [UIColor clearColor];
    self.optionFourLabel.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.questionContentLabel];
    [self.contentView addSubview:self.collectButton];
    [self.contentView addSubview:self.optionOneButton];
    [self.contentView addSubview:self.optionTwoButton];
    [self.contentView addSubview:self.optionThreeButton];
    [self.contentView addSubview:self.optionFourButton];
    [self.contentView addSubview:self.optionOneLabel];
    [self.contentView addSubview:self.optionTwoLabel];
    [self.contentView addSubview:self.optionThreeLabel];
    [self.contentView addSubview:self.optionFourLabel];
}
- (void)setObject:(NSObject *)object {
    if (object && self.item != object) {
        self.item = (ZCPQuestionCellItem *)object;
        
        // 相关变量
        NSInteger optionAnswerIndex = 0;  // 实际展示的4个选项中答案对应的索引值
        NSString *showOrder = self.item.questionModel.questionShowOrder;    // 展示顺序，每个字符值-1即为实际展示答案的索引值
        NSArray *optionLabelArr = @[self.optionOneLabel, self.optionTwoLabel, self.optionThreeLabel, self.optionFourLabel];
        NSArray *optionButtonArr = @[self.optionOneButton, self.optionTwoButton, self.optionThreeButton, self.optionFourButton];
        NSArray *optionArr = @[self.item.questionModel.questionOptionOne, self.item.questionModel.questionOptionTwo, self.item.questionModel.questionOptionThree, self.item.questionModel.questionAnswer];
        
        // 设置属性
        self.questionContentLabel.text = self.item.questionModel.questionContent;
        self.collectButton.selected = (self.item.questionModel.collected == ZCPCurrUserHaveCollectQuestion)? YES: NO;
        
        // 设置label内容
        for (int i = 0; i < optionLabelArr.count; i++) {
            UILabel *label = optionLabelArr[i];
            // 找出第i个标签对应选项的索引
            NSInteger optionIndex = [[showOrder substringWithRange:NSMakeRange(i, 1)] integerValue] - 1;
            // 通过索引找到选项值进行设置
            label.text = optionArr[optionIndex];
            label.textColor = [UIColor blackColor];
            
            // 如果为答案
            if (optionIndex == 3) {
                optionAnswerIndex = i;
            }
        }
        
        // 如果当前用户已经答过题
        if (self.item.userHaveAnswer) {
            
            // 将所有按钮设为不可用
            for (UIButton *button in optionButtonArr) {
                button.userInteractionEnabled = NO;
            }
            if (self.item.userAnswerIndex >=0 && self.item.userAnswerIndex <= 3) {
                // 设置用户答案对应按钮为选中
                UIButton *userSelectButton = optionButtonArr[self.item.userAnswerIndex];
                userSelectButton.selected = YES;
            }
            
            // 设置正确答案标签文字为红色
            UILabel *label = optionLabelArr[optionAnswerIndex];
            label.textColor = [UIColor redColor];
        } else {  // 如果未答过题
            // 初始化按钮状态
            for (UIButton *button in optionButtonArr) {
                button.userInteractionEnabled = YES;
                button.selected = NO;
            }
            // 如果用户已选择答案，将用户所选按钮标记为已选择
            if (self.item.userSelectIndex >= 0 && self.item.userSelectIndex <= 3) {
                UIButton *button = optionButtonArr[self.item.userSelectIndex];
                button.selected = YES;
            }
        }
    }
    
    // 设置frame
    // 计算
    CGFloat contentHeight = [self.item.questionModel.questionContent boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 2 - UIMargin - BUTTON_SIDE, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:17.0f]} context:nil].size.height;
    contentHeight = (contentHeight > BUTTON_SIDE)? contentHeight: BUTTON_SIDE;
    // 设置
    self.questionContentLabel.frame = CGRectMake(HorizontalMargin, VerticalMargin, APPLICATIONWIDTH - HorizontalMargin * 2 - UIMargin - BUTTON_SIDE, contentHeight);
    self.collectButton.frame = CGRectMake(self.questionContentLabel.right + UIMargin, VerticalMargin, BUTTON_SIDE, BUTTON_SIDE);
    self.optionOneButton.frame = CGRectMake(HorizontalMargin, self.questionContentLabel.bottom + UIMargin, BUTTON_SIDE, BUTTON_SIDE);
    self.optionOneLabel.frame = CGRectMake(self.optionOneButton.right + UIMargin, self.questionContentLabel.bottom + UIMargin, APPLICATIONWIDTH / 2 - HorizontalMargin - UIMargin * 3 / 4 - BUTTON_SIDE, OPTION_LABEL_HEIGHT);
    self.optionTwoButton.frame = CGRectMake(APPLICATIONWIDTH / 2 - UIMargin / 2, self.questionContentLabel.bottom + UIMargin, BUTTON_SIDE, BUTTON_SIDE);
    self.optionTwoLabel.frame = CGRectMake(self.optionTwoButton.right + UIMargin, self.questionContentLabel.bottom + UIMargin, APPLICATIONWIDTH / 2 - HorizontalMargin - UIMargin * 3 / 4 - BUTTON_SIDE, OPTION_LABEL_HEIGHT);
    self.optionThreeButton.frame = CGRectMake(HorizontalMargin, self.optionOneButton.bottom + UIMargin, BUTTON_SIDE, BUTTON_SIDE);
    self.optionThreeLabel.frame = CGRectMake(self.optionThreeButton.right + UIMargin, self.optionOneButton.bottom + UIMargin, APPLICATIONWIDTH / 2 - HorizontalMargin - UIMargin * 3 / 4 - BUTTON_SIDE, OPTION_LABEL_HEIGHT);
    self.optionFourButton.frame = CGRectMake(APPLICATIONWIDTH / 2 - UIMargin / 2, self.optionOneButton.bottom + UIMargin, BUTTON_SIDE, BUTTON_SIDE);
    self.optionFourLabel.frame = CGRectMake(self.optionFourButton.right + UIMargin, self.optionOneButton.bottom + UIMargin, APPLICATIONWIDTH / 2 - HorizontalMargin - UIMargin * 3 / 4 - BUTTON_SIDE, OPTION_LABEL_HEIGHT);
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPQuestionCellItem *item = (ZCPQuestionCellItem *)object;
    
    CGFloat contentHeight = [item.questionModel.questionContent boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 2 - UIMargin - BUTTON_SIDE, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:17.0f]} context:nil].size.height;
    contentHeight = (contentHeight > BUTTON_SIDE)? contentHeight: BUTTON_SIDE;
    
    return contentHeight + 20 * 2 + VerticalMargin * 2 + UIMargin * 2;
}

#pragma mark - Button Click
- (void)buttonClicked:(UIButton *)button {
    
    if (!self.item.delegate) {
        return;
    }
    
    NSArray *buttonArr = @[self.optionOneButton, self.optionTwoButton, self.optionThreeButton, self.optionFourButton];
    if (button == self.collectButton && [self.item.delegate respondsToSelector:@selector(questionCell:collectButtonClicked:)]) {
        [self.item.delegate questionCell:self collectButtonClicked:button];
    } else {
        if (![self.item.delegate respondsToSelector:@selector(questionCell:optionButtonClicked:atIndex:)]) {
            return;
        }
        for (int i = 0; i < buttonArr.count; i++) {
            if (button == buttonArr[i]) {
                [self.item.delegate questionCell:self optionButtonClicked:button atIndex:i];
            }
        }
    }
}

@end

@implementation ZCPQuestionCellItem

#pragma mark - synthesize
@synthesize questionModel   = _questionModel;
@synthesize userHaveAnswer = _userHaveAnswer;
@synthesize userAnswerIndex = _userAnswerIndex;
@synthesize userSelectIndex = _userSelectIndex;
@synthesize delegate = _delegate;

#pragma mark - init
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPQuestionCell class];
        self.cellType = [ZCPQuestionCell cellIdentifier];
    }
    return self;
}

@end
