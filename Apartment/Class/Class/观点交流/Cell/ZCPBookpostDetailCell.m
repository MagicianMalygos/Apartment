//
//  ZCPBookpostDetailCell.m
//  Apartment
//
//  Created by apple on 16/3/30.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookpostDetailCell.h"

#define BookNameLabelWidth      200  // 书名label宽度
#define FieldLabelWidth         50   // 类型label宽度
#define NumberLabelWidth        80   // 数字相关的label宽度
#define NumberLabelHeight       20   // 数字相关的label高度
#define ButtonSide              20   // 按钮边长
#define TimeLabelWidth          150  // 时间相关的label宽度
#define LabelHeight             20   // label高度

@implementation ZCPBookpostDetailCell

#pragma mark - Setup Cell
- (void)setupContentView {
    
    // 第一行
    self.fieldLabel = [[UILabel alloc] init];
    self.fieldLabel.font = [UIFont defaultFontWithSize:15.0f];
    self.fieldLabel.alpha = 0.6f;
    self.fieldLabel.textColor = [UIColor lightTextDefaultColor];
    self.bookNameLabel = [[UILabel alloc] init];
    self.bookNameLabel.font = [UIFont defaultFontWithSize:15.0f];
    self.bookNameLabel.numberOfLines = 0;
    self.bookNameLabel.textColor = [UIColor textDefaultColor];
    
    // 第二行
    self.bpTitleLabel = [[UILabel alloc] init];
    self.bpTitleLabel.font = [UIFont defaultBoldFontWithSize:18.0f];
    self.bpTitleLabel.numberOfLines = 0;
    self.bpTitleLabel.textColor = [UIColor boldTextDefaultColor];
    
    // 第三行
    self.bpContentLabel = [[UILabel alloc] init];
    self.bpContentLabel.font = [UIFont defaultFontWithSize:16.0f];
    self.bpContentLabel.numberOfLines = 0;
    self.bpContentLabel.textColor = [UIColor textDefaultColor];
    
    // 第四行
    self.uploaderLabel = [[UILabel alloc] init];
    self.uploaderLabel.font = [UIFont defaultFontWithSize:15.0f];
    self.uploaderLabel.textAlignment = NSTextAlignmentRight;
    self.uploaderLabel.textColor = [UIColor lightTextDefaultColor];
    self.bpTimeLabel = [[UILabel alloc] init];
    self.bpTimeLabel.font = [UIFont defaultFontWithSize:15.0f];
    self.bpTimeLabel.textColor = [UIColor lightTextDefaultColor];
    
    // 第五行
    self.supportNumberLabel = [[UILabel alloc] init];
    self.supportNumberLabel.font = [UIFont defaultFontWithSize:13.0f];
    self.supportNumberLabel.textColor = [UIColor textDefaultColor];
    self.collectionNumberLabel = [[UILabel alloc] init];
    self.collectionNumberLabel.font = [UIFont defaultFontWithSize:13.0f];
    self.collectionNumberLabel.textColor = [UIColor textDefaultColor];
    self.replyNumberLabel = [[UILabel alloc] init];
    self.replyNumberLabel.font = [UIFont defaultFontWithSize:13.0f];
    self.replyNumberLabel.textColor = [UIColor textDefaultColor];
    
    self.supportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.supportButton setImageNameNormal:@"support_normal" Highlighted:@"support_selected" Selected:@"support_selected" Disabled:@"support_normal"];
    [self.supportButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.collectionButton setImageNameNormal:@"collection_normal" Highlighted:@"collection_selected" Selected:@"collection_selected" Disabled:@"collection_normal"];
    [self.collectionButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commentButton setOnlyImageName:@"comment_normal"];
    [self.commentButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.bpTitleLabel.backgroundColor = [UIColor clearColor];
    self.bpContentLabel.backgroundColor = [UIColor clearColor];
    self.bpTimeLabel.backgroundColor = [UIColor clearColor];
    self.uploaderLabel.backgroundColor = [UIColor clearColor];
    self.fieldLabel.backgroundColor = [UIColor clearColor];
    self.bookNameLabel.backgroundColor = [UIColor clearColor];
    self.supportNumberLabel.backgroundColor = [UIColor clearColor];
    self.collectionNumberLabel.backgroundColor = [UIColor clearColor];
    self.replyNumberLabel.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.bpTitleLabel];
    [self.contentView addSubview:self.bpContentLabel];
    [self.contentView addSubview:self.bpTimeLabel];
    [self.contentView addSubview:self.uploaderLabel];
    [self.contentView addSubview:self.fieldLabel];
    [self.contentView addSubview:self.bookNameLabel];
    [self.contentView addSubview:self.supportNumberLabel];
    [self.contentView addSubview:self.collectionNumberLabel];
    [self.contentView addSubview:self.replyNumberLabel];
    [self.contentView addSubview:self.commentButton];
    [self.contentView addSubview:self.supportButton];
    [self.contentView addSubview:self.collectionButton];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPBookpostDetailCellItem class]]) {
        self.item = (ZCPBookpostDetailCellItem *)object;
        
        // 设置属性
        self.delegate = self.item.delegate;
        self.bpTitleLabel.text = self.item.bookpostModel.bookpostTitle;
        self.bpContentLabel.text = self.item.bookpostModel.bookpostContent;
        self.uploaderLabel.text = self.item.bookpostModel.user.userName;
        self.fieldLabel.text = self.item.bookpostModel.field.fieldName;
        self.bookNameLabel.text = [NSString stringWithFormat:@"《%@》", self.item.bookpostModel.bookpostBookName];
        self.bpTimeLabel.text = [NSString stringWithFormat:@"发表于 %@", [self.item.bookpostModel.bookpostTime toString]];

        self.supportNumberLabel.text = [NSString stringWithFormat:@"%@ 人点赞", [NSString getFormateFromNumberOfPeople:self.item.bookpostModel.bookpostSupport]];
        self.collectionNumberLabel.text = [NSString stringWithFormat:@"%@ 人收藏", [NSString getFormateFromNumberOfPeople:self.item.bookpostModel.bookpostCollectNumber]];
        self.replyNumberLabel.text = [NSString stringWithFormat:@"%@ 人回复", [NSString getFormateFromNumberOfPeople:self.item.bookpostModel.bookpostReplyNumber]];
        self.supportButton.selected = (self.item.bookpostModel.supported == ZCPCurrUserHaveSupportBookpost)? YES: NO;
        self.collectionButton.selected = (self.item.bookpostModel.collected == ZCPCurrUserHaveCollectBook)? YES: NO;
        
        // 设置frame
        // 第一行
        self.fieldLabel.frame = CGRectMake(HorizontalMargin, VerticalMargin, FieldLabelWidth, LabelHeight);
        self.bookNameLabel.frame = CGRectMake(self.fieldLabel.right + UIMargin
                                              , VerticalMargin
                                              , CELLWIDTH_DEFAULT - HorizontalMargin * 2 - UIMargin - FieldLabelWidth
                                              , LabelHeight);
        
        // 第二行
        CGFloat bpTitleLabelHeight = [self.item.bookpostModel.bookpostTitle boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - HorizontalMargin * 2 , CGFLOAT_MAX)
                                                                           options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                                        attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:18.0f]}
                                                                           context:nil].size.height;
        self.bpTitleLabel.frame = CGRectMake(HorizontalMargin
                                             , self.bookNameLabel.bottom + UIMargin
                                             , CELLWIDTH_DEFAULT - HorizontalMargin * 2
                                             , bpTitleLabelHeight);
        
        // 第三行
        CGFloat bpContentLabelHeight = ({
            [self.item.bookpostModel.bookpostContent boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - HorizontalMargin * 2, CGFLOAT_MAX)
                                                    options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:16.0f]}
                                                    context:nil].size.height;
        });
        self.bpContentLabel.frame = CGRectMake(HorizontalMargin
                                               , self.bpTitleLabel.bottom + UIMargin
                                               , CELLWIDTH_DEFAULT - HorizontalMargin * 2
                                               , bpContentLabelHeight);
        
        // 第四行
        [self.uploaderLabel sizeToFit];
        self.uploaderLabel.frame = CGRectMake(HorizontalMargin, self.bpContentLabel.bottom + UIMargin * 2, self.uploaderLabel.width, LabelHeight);
        
        self.bpTimeLabel.frame = CGRectMake(self.uploaderLabel.right + UIMargin
                                            , self.bpContentLabel.bottom + UIMargin * 2
                                            , TimeLabelWidth
                                            , LabelHeight);
        
        // 第五行
        self.supportNumberLabel.frame = CGRectMake(HorizontalMargin
                                                   , self.uploaderLabel.bottom + UIMargin
                                                   , NumberLabelWidth
                                                   , NumberLabelHeight);
        self.collectionNumberLabel.frame = CGRectMake(self.supportNumberLabel.right + UIMargin
                                                 , self.uploaderLabel.bottom + UIMargin
                                                 , NumberLabelWidth
                                                 , NumberLabelHeight);
        self.replyNumberLabel.frame = CGRectMake(self.collectionNumberLabel.right + UIMargin
                                                      , self.uploaderLabel.bottom + UIMargin
                                                      , NumberLabelWidth
                                                      , NumberLabelHeight);
        self.supportButton.frame = CGRectMake(CELLWIDTH_DEFAULT - HorizontalMargin - ButtonSide
                                              , VerticalMargin
                                              , ButtonSide
                                              , ButtonSide);
        self.collectionButton.frame = CGRectMake(self.supportButton.left - UIMargin * 2 - ButtonSide
                                                 , VerticalMargin
                                                 , ButtonSide
                                                 , ButtonSide);
        self.commentButton.frame = CGRectMake(self.collectionButton.left - UIMargin * 2 - ButtonSide
                                              , VerticalMargin
                                              , ButtonSide
                                              , ButtonSide);
        
        self.item.cellHeight = [NSNumber numberWithFloat:self.supportNumberLabel.bottom + VerticalMargin];
    }
}

#pragma mark - cell height
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPBookpostDetailCellItem *item = (ZCPBookpostDetailCellItem *)object;
    
    // 第一行
    CGFloat rowHeight1 = LabelHeight;
    // 第二行
    CGFloat rowHeight2 = [item.bookpostModel.bookpostTitle boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - HorizontalMargin * 2
                                                                             , CGFLOAT_MAX)
                                                          options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:18.0f]}
                                                          context:nil].size.height;
    // 第三行
    CGFloat rowHeight3 = [item.bookpostModel.bookpostContent boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - HorizontalMargin * 2
                                                                               , CGFLOAT_MAX)
                                                            options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                         attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:16.0f]}
                                                            context:nil].size.height;
    // 第四行
    CGFloat rowHeight4 = LabelHeight;
    // 第五行
    CGFloat rowHeight5 = NumberLabelHeight;
    // cell高度
    CGFloat cellHeight = rowHeight1 + rowHeight2 + rowHeight3 + rowHeight4 + rowHeight5 + VerticalMargin * 2 + UIMargin * 5;
    
    return cellHeight;
}

#pragma mark - Button Click
/**
 *  按钮响应方法
 */
- (void)buttonClicked:(UIButton *)button {
    if (self.delegate) {
        if (button == self.supportButton && [self.delegate respondsToSelector:@selector(bookpostDetailCell:supportButtonClicked:)]) {
            [self.delegate bookpostDetailCell:self supportButtonClicked:button];
        }
        else if (button == self.collectionButton && [self.delegate respondsToSelector:@selector(bookpostDetailCell:collectButtonClicked:)]) {
            [self.delegate bookpostDetailCell:self collectButtonClicked:button];
        }
        else if (button == self.commentButton && [self.delegate respondsToSelector:@selector(bookpostDetailCell:commentButtonClicked:)]) {
            [self.delegate bookpostDetailCell:self commentButtonClicked:button];
        }
    }
}

@end

@implementation ZCPBookpostDetailCellItem

#pragma mark - synthesize
@synthesize delegate = _delegate;

#pragma mark - init
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPBookpostDetailCell class];
        self.cellType = [ZCPBookpostDetailCell cellIdentifier];
    }
    return self;
}

@end

