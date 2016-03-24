//
//  ZCPBookCell.m
//  Apartment
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookCell.h"

#define COVER_HEIGHT            130                                         // 封面高度
#define COVER_RATE              0.707f                                      // 封面宽高比
#define COVER_WIDTH             (COVER_HEIGHT * COVER_RATE)                 // 封面宽度
#define LABEL_HEIGHT            20.0f                                       // 标签高度
#define TIMELABEL_WIDTH         160.0f                                      // 时间标签宽度
#define NUMBERLABEL_WIDTH       80.0f                                       // 计数标签宽度

#define CELL_HEIGHT             (COVER_HEIGHT + UIMargin + LABEL_HEIGHT + VerticalMargin * 2)    // cell高度

#pragma mark - ZCPBookCell
@implementation ZCPBookCell

#pragma mark - synthesize
@synthesize coverImageView      = _coverImageView;
@synthesize nameLabel           = _nameLabel;
@synthesize authorLabel         = _authorLabel;
@synthesize publisherLabel      = _publisherLabel;
@synthesize fieldLabel          = _fieldLabel;
@synthesize publishTimeLabel    = _publishTimeLabel;
@synthesize contributorLabel    = _contributorLabel;
@synthesize collectNumberLabel  = _collectNumberLabel;
@synthesize commentCountLabel   = _commentCountLabel;
@synthesize item                = _item;

#pragma mark - Setup Cell
- (void)setupContentView {
    
    // 图片
    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(HorizontalMargin
                                                                        , VerticalMargin
                                                                        , COVER_WIDTH
                                                                        , COVER_HEIGHT)];
    // 第一行
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.coverImageView.right + UIMargin
                                                               , VerticalMargin
                                                               , CELLWIDTH_DEFAULT - HorizontalMargin * 2 - UIMargin - self.coverImageView.width
                                                               , COVER_HEIGHT - LABEL_HEIGHT * 3 - UIMargin * 3)];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont defaultFontWithSize:18.0f];
    self.nameLabel.numberOfLines = 2;
    
    // 第二行
    self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.coverImageView.right + UIMargin
                                                                 , self.nameLabel.bottom + UIMargin
                                                                 , CELLWIDTH_DEFAULT - HorizontalMargin * 2 - UIMargin - self.coverImageView.width
                                                                 , LABEL_HEIGHT)];
    self.authorLabel.textAlignment = NSTextAlignmentLeft;
    self.authorLabel.font = [UIFont defaultFontWithSize:15.0f];
    
    // 第三行
    self.publisherLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.coverImageView.right + UIMargin
                                                                    , self.authorLabel.bottom + UIMargin
                                                                    , CELLWIDTH_DEFAULT - HorizontalMargin * 2 - UIMargin - self.coverImageView.width
                                                                    , LABEL_HEIGHT)];
    self.publisherLabel.textAlignment = NSTextAlignmentLeft;
    self.publisherLabel.font = [UIFont defaultFontWithSize:15.0f];
    
    // 第四行
    self.publishTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.coverImageView.right + UIMargin
                                                                      , self.publisherLabel.bottom + UIMargin
                                                                      , TIMELABEL_WIDTH
                                                                      , LABEL_HEIGHT)];
    self.publishTimeLabel.textAlignment = NSTextAlignmentLeft;
    self.publishTimeLabel.font = [UIFont defaultFontWithSize:15.0f];
    
    self.fieldLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.publishTimeLabel.right + UIMargin
                                                                , self.publisherLabel.bottom + UIMargin
                                                                , CELLWIDTH_DEFAULT - HorizontalMargin * 2 - UIMargin * 2 - self.coverImageView.width - TIMELABEL_WIDTH
                                                                , LABEL_HEIGHT)];
    self.fieldLabel.textAlignment = NSTextAlignmentCenter;
    self.fieldLabel.font = [UIFont defaultFontWithSize:15.0f];
    
    // 贡献者，计数
    self.contributorLabel = [[UILabel alloc] initWithFrame:CGRectMake(HorizontalMargin
                                                                , self.coverImageView.bottom + UIMargin
                                                                , CELLWIDTH_DEFAULT - HorizontalMargin * 2 - UIMargin * 2 - NUMBERLABEL_WIDTH * 2
                                                                , LABEL_HEIGHT)];
    self.contributorLabel.textAlignment = NSTextAlignmentLeft;
    self.contributorLabel.font = [UIFont defaultFontWithSize:13.0f];
    
    self.collectNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CELLWIDTH_DEFAULT - HorizontalMargin - UIMargin - NUMBERLABEL_WIDTH * 2
                                                                        , self.coverImageView.bottom + UIMargin
                                                                        , NUMBERLABEL_WIDTH
                                                                        , LABEL_HEIGHT)];
    self.collectNumberLabel.textAlignment = NSTextAlignmentRight;
    self.collectNumberLabel.font = [UIFont defaultFontWithSize:13.0f];
    
    self.commentCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CELLWIDTH_DEFAULT - HorizontalMargin - NUMBERLABEL_WIDTH
                                                                       , self.coverImageView.bottom + UIMargin
                                                                       , NUMBERLABEL_WIDTH
                                                                       , LABEL_HEIGHT)];
    self.commentCountLabel.textAlignment = NSTextAlignmentRight;
    self.commentCountLabel.font = [UIFont defaultFontWithSize:13.0f];
    
    self.coverImageView.backgroundColor = [UIColor clearColor];
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.authorLabel.backgroundColor = [UIColor clearColor];
    self.publisherLabel.backgroundColor = [UIColor clearColor];
    self.publishTimeLabel.backgroundColor = [UIColor clearColor];
    self.fieldLabel.backgroundColor = [UIColor clearColor];
    self.contributorLabel.backgroundColor = [UIColor clearColor];
    self.collectNumberLabel.backgroundColor = [UIColor clearColor];
    self.commentCountLabel.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.authorLabel];
    [self.contentView addSubview:self.publisherLabel];
    [self.contentView addSubview:self.fieldLabel];
    [self.contentView addSubview:self.publishTimeLabel];
    [self.contentView addSubview:self.contributorLabel];
    [self.contentView addSubview:self.collectNumberLabel];
    [self.contentView addSubview:self.commentCountLabel];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPBookCellItem class]]) {
        self.item = (ZCPBookCellItem *)object;
    
        // 设置属性
        self.coverImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.item.bookCoverURL]]];
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:coverImageGetURL(self.item.bookCoverURL)] placeholderImage:[UIImage imageNamed:@"cover_default"]];
        
        self.nameLabel.text = [NSString stringWithFormat:@"《%@》", self.item.bookName];
        self.authorLabel.text = [NSString stringWithFormat:@"作者：%@", self.item.bookAuthor];
        self.publisherLabel.text = [NSString stringWithFormat:@"出版社：%@", self.item.bookPublisher];
        
        NSString *fieldStr = @"";
        for (NSString *f in self.item.field) {
            fieldStr = [fieldStr stringByAppendingString:f];
        }
        self.fieldLabel.text = fieldStr;
        self.publishTimeLabel.text = [NSString stringWithFormat:@"出版日期：%@", [self.item.bookPublishTime toString]];
        self.contributorLabel.text = [NSString stringWithFormat:@"贡献者：%@", self.item.contributor];
        self.collectNumberLabel.text = [NSString stringWithFormat:@"%lu 人收藏", self.item.bookCollectNumber];
        self.commentCountLabel.text = [NSString stringWithFormat:@"%lu 人评论", self.item.bookCommentCount];
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    // 此处的cellHeight已经过计算，cell高度为定值
    ZCPBookCellItem *item = (ZCPBookCellItem *)object;
    return [item.cellHeight floatValue];
}

@end

@implementation ZCPBookCellItem

#pragma mark - synthesize
@synthesize bookCoverURL        = _bookCoverURL;
@synthesize bookName            = _bookName;
@synthesize bookAuthor          = _bookAuthor;
@synthesize bookPublisher       = _bookPublisher;
@synthesize field               = _field;
@synthesize bookPublishTime     = _bookPublishTime;
@synthesize contributor         = _contributor;
@synthesize bookCollectNumber   = _bookCollectNumber;
@synthesize bookCommentCount    = _bookCommentCount;

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPBookCell class];
        self.cellType = [ZCPBookCell cellIdentifier];
        self.cellHeight = @CELL_HEIGHT;
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPBookCell class];
        self.cellType = [ZCPBookCell cellIdentifier];
        self.cellHeight = @CELL_HEIGHT;
    }
    return self;
}

@end



#pragma mark - ZCPBookDetailCell
@implementation ZCPBookDetailCell

#pragma mark - synthesize
@synthesize collectionButton = _collectionButton;

#pragma mark - Setup Cell
- (void)setupContentView {
    [super setupContentView];
    
    self.bookpostSearchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bookpostSearchButton.frame = CGRectMake(HorizontalMargin
                                                 , self.contributorLabel.bottom + UIMargin
                                                 , NUMBERLABEL_WIDTH
                                                 , 20);
    [self.bookpostSearchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.bookpostSearchButton.titleLabel.font = [UIFont defaultFontWithSize:13.0f];
    [self.bookpostSearchButton changeToRound];
    [self.bookpostSearchButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.webSearchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.webSearchButton.frame = CGRectMake(self.bookpostSearchButton.right + UIMargin
                                            , self.contributorLabel.bottom + UIMargin
                                            , NUMBERLABEL_WIDTH
                                            , 20);
    [self.webSearchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.webSearchButton.titleLabel.font = [UIFont defaultFontWithSize:13.0f];
    [self.webSearchButton changeToRound];
    [self.webSearchButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectionButton.frame = CGRectMake(APPLICATIONWIDTH - HorizontalMargin - UIMargin * 2 - 20 * 2
                                             , self.contributorLabel.bottom + UIMargin
                                             , 20
                                             , 20);
    [self.collectionButton setImageNameNormal:@"collection_normal" Highlighted:@"collection_selected" Selected:@"collection_selected" Disabled:@"collection_normal"];
    [self.collectionButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentButton.frame = CGRectMake(APPLICATIONWIDTH - HorizontalMargin - 20
                                          , self.contributorLabel.bottom + UIMargin
                                          , 20
                                          , 20);
    [self.commentButton setOnlyImageName:@"comment_normal"];
    [self.commentButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.bookpostSearchButton.backgroundColor = [UIColor buttonDefaultColor];
    self.webSearchButton.backgroundColor = [UIColor buttonDefaultColor];
    self.commentButton.backgroundColor  = [UIColor clearColor];
    self.collectionButton.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.commentButton];
    [self.contentView addSubview:self.collectionButton];
    [self.contentView addSubview:self.bookpostSearchButton];
    [self.contentView addSubview:self.webSearchButton];
}

- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPBookDetailCellItem class]]) {
        [super setObject:object];
        self.item = (ZCPBookDetailCellItem *)object;
        ZCPBookDetailCellItem *item = (ZCPBookDetailCellItem *)object;
        
        // 设置属性
        self.delegate = item.delegate;
        self.collectionButton.selected = (item.bookCollected == ZCPCurrUserHaveCollectBook)? YES: NO;
        [self.bookpostSearchButton setTitle:item.bookpostSearchButtonTitle forState:UIControlStateNormal];
        [self.webSearchButton setTitle:item.webSearchButtonTitle forState:UIControlStateNormal];
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    // 此处的cellHeight已经过计算，cell高度为定值
    ZCPBookDetailCellItem *item = (ZCPBookDetailCellItem *)object;
    return [item.cellHeight floatValue];
}

#pragma mark - Button Click
/**
 *  按钮响应方法
 */
- (void)buttonClicked:(UIButton *)button {
    if (self.delegate) {
        if (button == self.bookpostSearchButton && [self.delegate respondsToSelector:@selector(bookDetailCell:bookpostSearchButtonClick:)]) {
            [self.delegate bookDetailCell:self bookpostSearchButtonClick:button];
        }
        else if (button == self.webSearchButton && [self.delegate respondsToSelector:@selector(bookDetailCell:webSearchButtonClick:)]) {
            [self.delegate bookDetailCell:self webSearchButtonClick:button];
        }
        else if (button == self.collectionButton && [self.delegate respondsToSelector:@selector(bookDetailCell:collectionButtonClick:)]) {
            [self.delegate bookDetailCell:self collectionButtonClick:button];
        }
        else if (button == self.commentButton && [self.delegate respondsToSelector:@selector(bookDetailCell:commentButtonClick:)]) {
            [self.delegate bookDetailCell:self commentButtonClick:button];
        }
    }
}

@end

@implementation ZCPBookDetailCellItem

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPBookDetailCell class];
        self.cellType = [ZCPBookDetailCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPBookDetailCell class];
        self.cellType = [ZCPBookDetailCell cellIdentifier];
        self.cellHeight = @(CELL_HEIGHT + 20 + UIMargin);
    }
    return self;
}

@end