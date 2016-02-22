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

@synthesize bpTitleLabel = _bpTitleLabel;
@synthesize bpContentLabel = _bpContentLabel;
@synthesize bpTimeLabel = _bpTimeLabel;
@synthesize uploaderLabel = _uploaderLabel;
@synthesize fieldLabel = _fieldLabel;
@synthesize bookNameLabel = _bookNameLabel;
@synthesize supportNumberLabel = _supportNumberLabel;
@synthesize collectionNumberLabel = _collectionNumberLabel;
@synthesize replyNumberLabel = _replyNumberLabel;
@synthesize item = _item;

#pragma mark - Setup Cell
- (void)setupContentView {
    
    // 第一行
    self.bookNameLabel = [[UILabel alloc] init];
    self.bookNameLabel.font = [UIFont defaultFontWithSize:15.0f];
    self.bookNameLabel.numberOfLines = 0;
    self.fieldLabel = [[UILabel alloc] init];
    self.fieldLabel.font = [UIFont defaultFontWithSize:15.0f];
    self.fieldLabel.alpha = 0.6f;
    
    // 第二行
    self.bpTitleLabel = [[UILabel alloc] init];
    self.bpTitleLabel.font = [UIFont defaultBoldFontWithSize:18.0f];
    self.bpTitleLabel.numberOfLines = 0;
    // 第三行
    self.bpContentLabel = [[UILabel alloc] init];
    self.bpContentLabel.font = [UIFont defaultFontWithSize:16.0f];
    self.bpContentLabel.numberOfLines = 0;
    
    // 第四行
    self.supportNumberLabel = [[UILabel alloc] init];
    self.supportNumberLabel.font = [UIFont defaultFontWithSize:13.0f];
    self.replyNumberLabel = [[UILabel alloc] init];
    self.replyNumberLabel.font = [UIFont defaultFontWithSize:13.0f];
    self.collectionNumberLabel = [[UILabel alloc] init];
    self.collectionNumberLabel.font = [UIFont defaultFontWithSize:13.0f];
    
    // 第五行
    self.uploaderLabel = [[UILabel alloc] init];
    self.uploaderLabel.font = [UIFont defaultFontWithSize:15.0f];
    self.uploaderLabel.textAlignment = NSTextAlignmentRight;
    self.uploaderLabel.alpha = 0.6f;
    self.bpTimeLabel = [[UILabel alloc] init];
    self.bpTimeLabel.font = [UIFont defaultFontWithSize:15.0f];
    self.bpTimeLabel.alpha = 0.6f;
    
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
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPBookPostCellItem class]]) {
        self.item = (ZCPBookPostCellItem *)object;
        
        // 设置属性
        self.bpTitleLabel.text = self.item.bpTitle;
        self.bpContentLabel.text = self.item.bpContent;
        self.uploaderLabel.text = self.item.uploader;
        self.fieldLabel.text = self.item.field;
        
        self.bookNameLabel.text = self.item.bookName;
        self.bpTimeLabel.text = [NSString stringWithFormat:@"发表于 %@", [self.item.bpTime toString]];
        
        self.supportNumberLabel.text = [NSString stringWithFormat:@"%lu 人点赞", self.item.supportNumber];
        self.replyNumberLabel.text = [NSString stringWithFormat:@"%lu 人回复", self.item.replyNumber];
        self.collectionNumberLabel.text = [NSString stringWithFormat:@"%lu 人收藏", self.item.collectionNumber];
        
        // 设置frame
        [self.bookNameLabel sizeToFit];
        self.bookNameLabel.frame = CGRectMake(HorizontalMargin
                                              , VerticalMargin
                                              , self.bookNameLabel.width
                                              , LabelHeight);
        self.fieldLabel.frame = CGRectMake(self.bookNameLabel.right + UIMargin, VerticalMargin, FieldLabelWidth, LabelHeight);
        
        CGFloat bpTitleLabelHeight = [self.item.bpTitle boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - HorizontalMargin * 2
                                                                                        , CGFLOAT_MAX)
                                                                     options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                                  attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:18.0f]}
                                                                     context:nil].size.height;
        self.bpTitleLabel.frame = CGRectMake(HorizontalMargin
                                             , self.bookNameLabel.bottom + UIMargin
                                             , CELLWIDTH_DEFAULT - HorizontalMargin * 2
                                             , bpTitleLabelHeight);
        
        CGFloat bpContentLabelHeight = [self.item.bpContent boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - HorizontalMargin * 2
                                                                                            , CGFLOAT_MAX)
                                                                         options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                                      attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:16.0f]}
                                                                         context:nil].size.height;
        self.bpContentLabel.frame = CGRectMake(HorizontalMargin
                                               , self.bpTitleLabel.bottom + UIMargin
                                               , CELLWIDTH_DEFAULT - HorizontalMargin * 2
                                               , bpContentLabelHeight);
        
        [self.uploaderLabel sizeToFit];
        self.uploaderLabel.frame = CGRectMake(HorizontalMargin, self.bpContentLabel.bottom + UIMargin * 2, self.uploaderLabel.width, LabelHeight);
        
        self.bpTimeLabel.frame = CGRectMake(self.uploaderLabel.right + UIMargin
                                            , self.bpContentLabel.bottom + UIMargin * 2
                                            , TimeLabelWidth
                                            , LabelHeight);
        
        
        self.supportNumberLabel.frame = CGRectMake(HorizontalMargin
                                                   , self.uploaderLabel.bottom + UIMargin
                                                   , NumberLabelWidth
                                                   , NumberLabelHeight);
        self.replyNumberLabel.frame = CGRectMake(self.supportNumberLabel.right + UIMargin
                                                 , self.uploaderLabel.bottom + UIMargin
                                                 , NumberLabelWidth
                                                 , NumberLabelHeight);
        self.collectionNumberLabel.frame = CGRectMake(self.replyNumberLabel.right + UIMargin
                                                      , self.uploaderLabel.bottom + UIMargin
                                                      , NumberLabelWidth
                                                      , NumberLabelHeight);
        
        self.item.cellHeight = [NSNumber numberWithFloat:self.supportNumberLabel.bottom + VerticalMargin];
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPBookPostCellItem *item = (ZCPBookPostCellItem *)object;
    return [item.cellHeight floatValue];
}

@end

@implementation ZCPBookPostCellItem

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPBookPostCell class];
        self.cellType = [ZCPBookPostCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPBookPostCell class];
        self.cellType = [ZCPBookPostCell cellIdentifier];
    }
    return self;
}

@end