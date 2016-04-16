//
//  ZCPBookPostCell.m
//  Apartment
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookPostCell.h"

#define BookNameLabelWidth      200  // 书名label宽度
#define FieldLabelWidth         50   // 类型label宽度
#define NumberLabelWidth        80   // 数字相关的label宽度
#define NumberLabelHeight       15   // 数字相关的label高度
#define TimeLabelWidth          150  // 时间相关的label宽度
#define LabelHeight             20   // label高度

@implementation ZCPBookPostCell

#pragma mark - synthesize
@synthesize bpTitleLabel            = _bpTitleLabel;
@synthesize fieldLabel              = _fieldLabel;
@synthesize bookNameLabel           = _bookNameLabel;
@synthesize supportNumberLabel      = _supportNumberLabel;
@synthesize collectionNumberLabel   = _collectionNumberLabel;
@synthesize replyNumberLabel        = _replyNumberLabel;
@synthesize item                    = _item;

#pragma mark - Setup Cell
- (void)setupContentView {
    
    // 第一行
    self.fieldLabel = [[UILabel alloc] init];
    self.fieldLabel.font = [UIFont defaultFontWithSize:15.0f];
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
    self.supportNumberLabel = [[UILabel alloc] init];
    self.supportNumberLabel.font = [UIFont defaultFontWithSize:13.0f];
    self.supportNumberLabel.textColor = [UIColor textDefaultColor];
    self.collectionNumberLabel = [[UILabel alloc] init];
    self.collectionNumberLabel.font = [UIFont defaultFontWithSize:13.0f];
    self.collectionNumberLabel.textColor = [UIColor textDefaultColor];
    self.replyNumberLabel = [[UILabel alloc] init];
    self.replyNumberLabel.font = [UIFont defaultFontWithSize:13.0f];
    self.replyNumberLabel.textColor = [UIColor textDefaultColor];
    
    self.bpTitleLabel.backgroundColor = [UIColor clearColor];
    self.fieldLabel.backgroundColor = [UIColor clearColor];
    self.bookNameLabel.backgroundColor = [UIColor clearColor];
    self.supportNumberLabel.backgroundColor = [UIColor clearColor];
    self.collectionNumberLabel.backgroundColor = [UIColor clearColor];
    self.replyNumberLabel.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.bpTitleLabel];
    [self.contentView addSubview:self.fieldLabel];
    [self.contentView addSubview:self.bookNameLabel];
    [self.contentView addSubview:self.supportNumberLabel];
    [self.contentView addSubview:self.collectionNumberLabel];
    [self.contentView addSubview:self.replyNumberLabel];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPBookPostModel class]]) {
        self.item = (ZCPBookPostModel *)object;
        
        // 设置属性
        self.bpTitleLabel.text = self.item.bookpostTitle;
        self.fieldLabel.text = self.item.field.fieldName;
        self.bookNameLabel.text = [NSString stringWithFormat:@"《%@》", self.item.bookpostBookName];
        
        self.supportNumberLabel.text = [NSString stringWithFormat:@"%@ 人点赞", [NSString getFormateFromNumberOfPeople:self.item.bookpostSupport]];
        self.collectionNumberLabel.text = [NSString stringWithFormat:@"%@ 人收藏", [NSString getFormateFromNumberOfPeople:self.item.bookpostCollectNumber]];
        self.replyNumberLabel.text = [NSString stringWithFormat:@"%@ 人回复", [NSString getFormateFromNumberOfPeople:self.item.bookpostReplyNumber]];
        // 设置frame
        self.fieldLabel.frame = CGRectMake(HorizontalMargin, VerticalMargin, FieldLabelWidth, LabelHeight);
        self.bookNameLabel.frame = CGRectMake(self.fieldLabel.right + UIMargin
                                              , VerticalMargin
                                              , CELLWIDTH_DEFAULT - HorizontalMargin * 2 - UIMargin - FieldLabelWidth
                                              , LabelHeight);
        
        CGFloat bpTitleLabelHeight = [self.item.bookpostTitle boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - HorizontalMargin * 2 , CGFLOAT_MAX)
                                                                     options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                                  attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:18.0f]}
                                                                     context:nil].size.height;
        self.bpTitleLabel.frame = CGRectMake(HorizontalMargin
                                             , self.bookNameLabel.bottom + UIMargin
                                             , CELLWIDTH_DEFAULT - HorizontalMargin * 2
                                             , bpTitleLabelHeight);
        
        self.supportNumberLabel.frame = CGRectMake(HorizontalMargin
                                                   , self.bpTitleLabel.bottom + UIMargin
                                                   , NumberLabelWidth
                                                   , NumberLabelHeight);
        self.collectionNumberLabel.frame = CGRectMake(self.supportNumberLabel.right + UIMargin
                                                 , self.bpTitleLabel.bottom + UIMargin
                                                 , NumberLabelWidth
                                                 , NumberLabelHeight);
        self.replyNumberLabel.frame = CGRectMake(self.collectionNumberLabel.right + UIMargin
                                                      , self.bpTitleLabel.bottom + UIMargin
                                                      , NumberLabelWidth
                                                      , NumberLabelHeight);
        
        self.item.cellHeight = [NSNumber numberWithFloat:self.supportNumberLabel.bottom + VerticalMargin];
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPBookPostModel *item = (ZCPBookPostModel *)object;
    
    // 第一行
    CGFloat rowHeight1 = LabelHeight;
    // 第二行
    CGFloat rowHeight2 = [item.bookpostTitle boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - HorizontalMargin * 2
                                                                       , CGFLOAT_MAX)
                                                    options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:18.0f]}
                                                    context:nil].size.height;
    // 第五行
    CGFloat rowHeight3 = NumberLabelHeight;
    // cell高度
    CGFloat cellHeight = rowHeight1 + rowHeight2 + rowHeight3 + VerticalMargin * 2 + UIMargin * 2;
    
    return cellHeight;
}

@end