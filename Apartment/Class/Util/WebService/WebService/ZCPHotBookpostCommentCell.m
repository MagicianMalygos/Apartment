//
//  ZCPHotBookpostCommentCell.m
//  Apartment
//
//  Created by apple on 16/4/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPHotBookpostCommentCell.h"

@implementation ZCPHotBookpostCommentCell

#pragma mark - synthesize
@synthesize bpView                  = _bpView;
@synthesize bookpostTitleLabel      = _bookpostTitleLabel;
@synthesize lineView                = _lineView;
@synthesize bpcView                 = _bpcView;
@synthesize bpcUserHeadImageView    = _bpcUserHeadImageView;
@synthesize supportNumberLabel      = _supportNumberLabel;
@synthesize bpcContentLabel         = _bpcContentLabel;

#pragma mark - setup cell
- (void)setupContentView {
    [super setupContentView];
    
    // 图书贴区
    self.bpView = [[UIView alloc] init];
    [self.bpcView clipsToBounds];
    WEAK_SELF;
    [self.bpView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        ZCPHotBookpostCommentCellItem *item = (ZCPHotBookpostCommentCellItem *)weakSelf.item;
        if (item.delegate && [item.delegate respondsToSelector:@selector(hotBookpostCommentCell:bpViewClicked:)]) {
            [item.delegate hotBookpostCommentCell:weakSelf bpViewClicked:item.bpcModel.bookpost];
        }
    }]];
    
    self.bookpostTitleLabel = [[UILabel alloc] init];
    self.bookpostTitleLabel.font = [UIFont defaultFontWithSize:17.0f];
    self.bookpostTitleLabel.numberOfLines = 2;
    
    // 分割线
    self.lineView = [[UIView alloc] init];
    
    // 图书贴评论区域
    self.bpcView = [[UIView alloc] init];
    [self.bpcView clipsToBounds];
    [self.bpcView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        ZCPHotBookpostCommentCellItem *item = (ZCPHotBookpostCommentCellItem *)weakSelf.item;
        if (item.delegate && [item.delegate respondsToSelector:@selector(hotBookpostCommentCell:bpcViewClicked:)]) {
            [item.delegate hotBookpostCommentCell:weakSelf bpcViewClicked:item.bpcModel];
        }
    }]];
    
    self.bpcUserHeadImageView = [[UIImageView alloc] init];
    self.supportNumberLabel = [[UILabel alloc] init];
    self.supportNumberLabel.font = [UIFont defaultFontWithSize:13.0f];
    self.supportNumberLabel.textColor = [UIColor whiteColor];
    self.supportNumberLabel.textAlignment = NSTextAlignmentCenter;
    
    self.bpcContentLabel = [[UILabel alloc] init];
    self.bpcContentLabel.font = [UIFont defaultFontWithSize:14.0f];
    self.bpcContentLabel.numberOfLines = 3;
    
    self.bpView.backgroundColor = [UIColor clearColor];
    self.bookpostTitleLabel.backgroundColor = [UIColor clearColor];
    self.lineView.backgroundColor = [UIColor colorFromHexRGB:@"dddddd"];
    self.bpcView.backgroundColor = [UIColor clearColor];
    self.bpcUserHeadImageView.backgroundColor = [UIColor clearColor];
    self.supportNumberLabel.backgroundColor = [UIColor blueColor];
    self.bpcContentLabel.backgroundColor = [UIColor clearColor];
    
    [self.bpView addSubview:self.bookpostTitleLabel];
    [self.bpcView addSubview:self.bpcUserHeadImageView];
    [self.bpcView addSubview:self.supportNumberLabel];
    [self.bpcView addSubview:self.bpcContentLabel];
    [self.roundContentView addSubview:self.bpView];
    [self.roundContentView addSubview:self.lineView];
    [self.roundContentView addSubview:self.bpcView];
}
- (void)setObject:(NSObject *)object {
    if (object) {
        [super setObject:object];
        
        ZCPHotBookpostCommentCellItem *item = (ZCPHotBookpostCommentCellItem *)object;
        
        // 设置属性
        self.bookpostTitleLabel.text = item.bpcModel.bookpost.bookpostTitle;
        [self.bpcUserHeadImageView sd_setImageWithURL:[NSURL URLWithString:item.bpcModel.user.userFaceURL] placeholderImage:[UIImage imageNamed:HEAD_IMAGE_NAME_DEFAULT]];
        self.supportNumberLabel.text = [NSString stringWithFormat:@"%li", item.bpcModel.commentSupport];
        self.bpcContentLabel.text = item.bpcModel.commentContent;
        
        if (item.headImageViewConfigBlock) {
            item.headImageViewConfigBlock(self.bpcUserHeadImageView);
        }
        
        // 设置item的cellHeight
        CGFloat bpTitleHeight = [item.bpcModel.bookpost.bookpostTitle boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 4, 40) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:17.0f]} context:nil].size.height;
        CGFloat leftInfoHeight = 25 + 16 + UIMargin;
        self.item.cellHeight = @(bpTitleHeight + VerticalMargin * 2 + OnePoint + leftInfoHeight + VerticalMargin * 2 + VerticalMargin * 2);
    }
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPHotBookpostCommentCellItem *item = (ZCPHotBookpostCommentCellItem *)object;
    return [item.cellHeight floatValue];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    ZCPHotBookpostCommentCellItem *item = (ZCPHotBookpostCommentCellItem *)self.item;
    
    // 计算可变高度
    CGFloat bpTitleHeight = [item.bpcModel.bookpost.bookpostTitle boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - HorizontalMargin * 4, 40) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:17.0f]} context:nil].size.height;
    CGFloat bpcContentHeight = [item.bpcModel.commentContent boundingRectWithSize:CGSizeMake(self.bpcView.width - HorizontalMargin * 2 - 25 - UIMargin, 25 + 16 + UIMargin) options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont defaultFontWithSize:14.0f]} context:nil].size.height;
    CGFloat leftInfoHeight = 25 + 16 + UIMargin;
    
    // 设置frame
    self.bpView.frame = CGRectMake(0, 0, self.roundContentView.width, bpTitleHeight + VerticalMargin * 2);
    self.bookpostTitleLabel.frame = CGRectMake(HorizontalMargin, VerticalMargin, self.bpView.width - HorizontalMargin * 2, bpTitleHeight);
    self.lineView.frame = CGRectMake(0, self.bpView.bottom, self.roundContentView.width, OnePoint);
    self.bpcView.frame = CGRectMake(0, self.lineView.bottom, self.roundContentView.width, leftInfoHeight + VerticalMargin * 2);
    self.bpcUserHeadImageView.frame = CGRectMake(HorizontalMargin, VerticalMargin, 25, 25);
    self.supportNumberLabel.frame = CGRectMake(HorizontalMargin, self.bpcUserHeadImageView.bottom + UIMargin, 25, 16);
    self.bpcContentLabel.frame = CGRectMake(self.bpcUserHeadImageView.right + UIMargin, VerticalMargin, self.bpcView.width - HorizontalMargin * 2 - 25 - UIMargin, bpcContentHeight);
    
    // 设置用户头像为圆形
    [self.bpcUserHeadImageView changeToRound];
}

@end

@implementation ZCPHotBookpostCommentCellItem

#pragma mark - synthesize
@synthesize bpcModel = _bpcModel;

#pragma mark - init
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPHotBookpostCommentCell class];
        self.cellType = [ZCPHotBookpostCommentCell cellIdentifier];
    }
    return self;
}

@end
