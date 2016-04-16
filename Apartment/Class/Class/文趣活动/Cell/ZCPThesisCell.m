//
//  ZCPThesisCell.m
//  Apartment
//
//  Created by apple on 16/2/2.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPThesisCell.h"

@implementation ZCPThesisCell

#pragma mark - synthesize
@synthesize thesisView  = _thesisView;
@synthesize item        = _item;

#pragma mark - Setup Cell
- (void)setupContentView {
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPThesisCellItem class]]) {
        self.item = (ZCPThesisCellItem *)object;
        // 创建thesisView
        self.thesisView = [[ZCPThesisView alloc] initWithFrame:CGRectMake(0, 0, CELLWIDTH_DEFAULT, 0) thesis:self.item.thesisModel];
        [self addSubview:self.thesisView];
        self.thesisView.delegate = self.item.delegate;
        
        self.item.cellHeight = [NSNumber numberWithFloat:self.thesisView.height];
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPThesisCellItem *item = (ZCPThesisCellItem *)object;
    CGFloat cellHeight = [ZCPThesisView viewHeightWithThesisModel:item.thesisModel];
    return cellHeight;
}

@end

@implementation ZCPThesisCellItem

#pragma mark - synthesize
@synthesize thesisModel     = _thesisModel;
@synthesize delegate        = _delegate;

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPThesisCell class];
        self.cellType = [ZCPThesisCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPThesisCell class];
        self.cellType = [ZCPThesisCell cellIdentifier];
    }
    return self;
}

@end


// 辩题展示cell
@implementation ZCPThesisShowCell

#pragma mark - synthesize
@synthesize thesisContentLabel      = _thesisContentLabel;
@synthesize thesisProsLabel         = _thesisProsLabel;
@synthesize thesisConsLabel         = _thesisConsLabel;
@synthesize replyNumberLabel        = _replyNumberLabel;
@synthesize collectionNumberLabel   = _collectionNumberLabel;
@synthesize item                    = _item;

#pragma mark - Setup Cell
- (void)setupContentView {
    // 初始化控件
    self.thesisContentLabel = [[UILabel alloc] init];
    self.thesisContentLabel.numberOfLines = 0;
    self.thesisContentLabel.textAlignment = NSTextAlignmentCenter;
    self.thesisContentLabel.font = [UIFont defaultFontWithSize:18.0f];
    self.thesisContentLabel.textColor = [UIColor boldTextDefaultColor];
    
    self.thesisProsLabel = [[UILabel alloc] init];
    self.thesisProsLabel.numberOfLines = 0;
    self.thesisProsLabel.font = [UIFont defaultFontWithSize:15.0f];
    self.thesisProsLabel.textColor = [UIColor boldTextDefaultColor];
    
    self.thesisConsLabel = [[UILabel alloc] init];
    self.thesisConsLabel.numberOfLines = 0;
    self.thesisConsLabel.font = [UIFont defaultFontWithSize:15.0f];
    self.thesisConsLabel.textColor = [UIColor boldTextDefaultColor];
    
    self.replyNumberLabel = [[UILabel alloc] init];
    self.replyNumberLabel.font = [UIFont defaultFontWithSize:13.0f];
    self.replyNumberLabel.textColor = [UIColor textDefaultColor];
    
    self.collectionNumberLabel = [[UILabel alloc] init];
    self.collectionNumberLabel.font = [UIFont defaultFontWithSize:13.0f];
    self.collectionNumberLabel.textColor = [UIColor textDefaultColor];
    
    // 设置背景颜色
    self.thesisContentLabel.backgroundColor = [UIColor clearColor];
    self.thesisProsLabel.backgroundColor = [UIColor clearColor];
    self.thesisConsLabel.backgroundColor = [UIColor clearColor];
    self.replyNumberLabel.backgroundColor = [UIColor clearColor];
    self.collectionNumberLabel.backgroundColor = [UIColor clearColor];
    
    // add
    [self.contentView addSubview:self.thesisContentLabel];
    [self.contentView addSubview:self.thesisProsLabel];
    [self.contentView addSubview:self.thesisConsLabel];
    [self.contentView addSubview:self.replyNumberLabel];
    [self.contentView addSubview:self.collectionNumberLabel];
}
- (void)setObject:(NSObject *)object {
    if (object && self.item != object) {
        self.item = (ZCPThesisModel *)object;
        // 设置属性
        self.thesisContentLabel.text = self.item.thesisContent;
        self.thesisProsLabel.text = [NSString stringWithFormat:@"正方：%@", self.item.thesisPros];
        self.thesisConsLabel.text = [NSString stringWithFormat:@"反方：%@", self.item.thesisCons];
        self.replyNumberLabel.text = [NSString stringWithFormat:@"%@ 人回复", [NSString getFormateFromNumberOfPeople:self.item.thesisProsReplyNumber + self.item.thesisConsReplyNumber]];
        self.collectionNumberLabel.text = [NSString stringWithFormat:@"%@ 人收藏", [NSString getFormateFromNumberOfPeople:self.item.thesisCollectNumber]];
        
        // 设置frame
        CGFloat contentHeight = [self.thesisContentLabel.text boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 2, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:18.0f]} context:nil].size.height;
        CGFloat prosHeight = [self.thesisProsLabel.text boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 2, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:18.0f]} context:nil].size.height;
        CGFloat consHeight = [self.thesisConsLabel.text boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 2, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:18.0f]} context:nil].size.height;
        self.thesisContentLabel.frame = CGRectMake(HorizontalMargin, VerticalMargin, APPLICATIONWIDTH - HorizontalMargin * 2, contentHeight);
        self.thesisProsLabel.frame = CGRectMake(HorizontalMargin, self.thesisContentLabel.bottom + UIMargin, APPLICATIONWIDTH - HorizontalMargin * 2, prosHeight);
        self.thesisConsLabel.frame = CGRectMake(HorizontalMargin, self.thesisProsLabel.bottom + UIMargin, APPLICATIONWIDTH - HorizontalMargin * 2, consHeight);
        self.replyNumberLabel.frame = CGRectMake(HorizontalMargin, self.thesisConsLabel.bottom + UIMargin, 90, 20);
        self.collectionNumberLabel.frame = CGRectMake(self.replyNumberLabel.right +  UIMargin, self.thesisConsLabel.bottom + UIMargin, 90, 20);
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPThesisModel *model = (ZCPThesisModel *)object;
    
    NSString *content = model.thesisContent;
    NSString *pros = [NSString stringWithFormat:@"正方：%@", model.thesisPros];
    NSString *cons = [NSString stringWithFormat:@"反方：%@", model.thesisCons];
    
    CGFloat contentHeight = [content boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 2, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:18.0f]} context:nil].size.height;
    CGFloat prosHeight = [pros boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 2, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:18.0f]} context:nil].size.height;
    CGFloat consHeight = [cons boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 2, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:18.0f]} context:nil].size.height;
    
    return contentHeight + prosHeight + consHeight + 20 + VerticalMargin * 2 + UIMargin * 3;
}

@end