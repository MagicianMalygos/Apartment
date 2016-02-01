//
//  ZCPBookCell.m
//  Apartment
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPBookCell.h"

#define CELL_HEIGHT             150.0f  // 高度
#define LABEL_HEIGHT            15.0f   // 标签高度
#define NAMELABEL_HEIGHT        42.0f   // 书名标签高度
#define TIMELABEL_WIDTH         130.0f  // 事件标签宽度
#define NUMBERLABEL_WIDTH       60.0f   // 计数标签宽度

#pragma mark - ZCPBookCell
@implementation ZCPBookCell

@synthesize coverImageView = _coverImageView;
@synthesize nameLabel = _nameLabel;
@synthesize authorLabel = _authorLabel;
@synthesize publisherLabel = _publisherLabel;
@synthesize fieldLabel = _fieldLabel;
@synthesize publishTimeLabel = _publishTimeLabel;
@synthesize contributorLabel = _contributorLabel;
@synthesize collectNumberLabel = _collectNumberLabel;
@synthesize commentCountLabel = _commentCountLabel;
@synthesize item = _item;

#pragma mark - Setup Cell
- (void)setupContentView {
    
    // 图片
    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(HorizontalMargin
                                                                        , VerticalMargin
                                                                        , (CELL_HEIGHT - VerticalMargin * 2) * 0.618/*黄金矩形宽高比*/
                                                                        , CELL_HEIGHT - VerticalMargin * 2)];
    // 第一行
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.coverImageView.right + UIMargin
                                                               , VerticalMargin
                                                               , CELLWIDTH_DEFAULT - HorizontalMargin * 2 - UIMargin - self.coverImageView.width
                                                               , NAMELABEL_HEIGHT)];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont systemFontOfSize:15.0f];
    self.nameLabel.numberOfLines = 0;
    
    // 第二行
    self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.coverImageView.right + UIMargin
                                                                 , self.nameLabel.bottom + UIMargin
                                                                 , CELLWIDTH_DEFAULT - HorizontalMargin * 2 - UIMargin - self.coverImageView.width
                                                                 , LABEL_HEIGHT)];
    self.authorLabel.textAlignment = NSTextAlignmentLeft;
    self.authorLabel.font = [UIFont systemFontOfSize:12.0f];
    
    // 第三行
    self.publisherLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.coverImageView.right + UIMargin
                                                                    , self.authorLabel.bottom + UIMargin
                                                                    , CELLWIDTH_DEFAULT - HorizontalMargin * 2 - UIMargin - self.coverImageView.width
                                                                    , LABEL_HEIGHT)];
    self.publisherLabel.textAlignment = NSTextAlignmentLeft;
    self.publisherLabel.font = [UIFont systemFontOfSize:12.0f];
    
    // 第四行
    self.publishTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.coverImageView.right + UIMargin
                                                                      , self.publisherLabel.bottom + UIMargin
                                                                      , TIMELABEL_WIDTH
                                                                      , LABEL_HEIGHT)];
    self.publishTimeLabel.textAlignment = NSTextAlignmentLeft;
    self.publishTimeLabel.font = [UIFont systemFontOfSize:12.0f];
    
    self.fieldLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.publishTimeLabel.right + UIMargin
                                                                , self.publisherLabel.bottom + UIMargin
                                                                , CELLWIDTH_DEFAULT - HorizontalMargin * 2 - UIMargin * 2 - self.coverImageView.width - TIMELABEL_WIDTH
                                                                , LABEL_HEIGHT)];
    self.fieldLabel.textAlignment = NSTextAlignmentCenter;
    self.fieldLabel.font = [UIFont systemFontOfSize:12.0f];
    
    // 第五行
    self.contributorLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.coverImageView.right + UIMargin
                                                                , self.coverImageView.bottom - LABEL_HEIGHT
                                                                , CELLWIDTH_DEFAULT - HorizontalMargin * 2 - UIMargin * 3 - self.coverImageView.width - NUMBERLABEL_WIDTH * 2
                                                                , LABEL_HEIGHT)];
    self.contributorLabel.textAlignment = NSTextAlignmentLeft;
    self.contributorLabel.font = [UIFont systemFontOfSize:10.0f];
    
    self.collectNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CELLWIDTH_DEFAULT - HorizontalMargin - UIMargin - NUMBERLABEL_WIDTH * 2
                                                                        , self.coverImageView.bottom - LABEL_HEIGHT
                                                                        , NUMBERLABEL_WIDTH
                                                                        , LABEL_HEIGHT)];
    self.collectNumberLabel.textAlignment = NSTextAlignmentRight;
    self.collectNumberLabel.font = [UIFont systemFontOfSize:10.0f];
    
    self.commentCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CELLWIDTH_DEFAULT - HorizontalMargin - NUMBERLABEL_WIDTH
                                                                       , self.coverImageView.bottom - LABEL_HEIGHT
                                                                       , NUMBERLABEL_WIDTH, LABEL_HEIGHT)];
    self.commentCountLabel.textAlignment = NSTextAlignmentRight;
    self.commentCountLabel.font = [UIFont systemFontOfSize:10.0f];
    
    self.coverImageView.backgroundColor = [UIColor redColor];
    self.nameLabel.backgroundColor = [UIColor redColor];
    self.authorLabel.backgroundColor = [UIColor redColor];
    self.publisherLabel.backgroundColor = [UIColor redColor];
    self.publishTimeLabel.backgroundColor = [UIColor redColor];
    self.fieldLabel.backgroundColor = [UIColor redColor];
    self.contributorLabel.backgroundColor = [UIColor redColor];
    self.collectNumberLabel.backgroundColor = [UIColor redColor];
    self.commentCountLabel.backgroundColor = [UIColor redColor];
    
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
        self.nameLabel.text = self.item.bookName;
        self.authorLabel.text = self.item.bookAuthor;
        self.publisherLabel.text = self.item.bookPublisher;
        
        for (NSString *f in self.item.field) {
            self.fieldLabel.text = [self.fieldLabel.text stringByAppendingString:f];
        }
        self.publishTimeLabel.text = [NSString stringWithFormat:@"出版日期：%@", [self.item.bookPublishTime toString]];
        self.contributorLabel.text = [NSString stringWithFormat:@"贡献者：%@", self.item.contributor];
        self.collectNumberLabel.text = [NSString stringWithFormat:@"%lu 人点赞", self.item.bookCollectNumber];
        self.commentCountLabel.text = [NSString stringWithFormat:@"%lu 人评论", self.item.bookCommentCount];
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPBookCellItem *item = (ZCPBookCellItem *)object;
    return [item.cellHeight floatValue];
}

@end

@implementation ZCPBookCellItem

@synthesize bookCoverURL = _bookCoverURL;
@synthesize bookName = _bookName;
@synthesize bookAuthor = _bookAuthor;
@synthesize bookPublisher = _bookPublisher;
@synthesize field = _field;
@synthesize bookPublishTime = _bookPublishTime;
@synthesize contributor = _contributor;
@synthesize bookCollectNumber = _bookCollectNumber;
@synthesize bookCommentCount = _bookCommentCount;

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

#pragma mark - Setup Cell
- (void)setupContentView {
    [super setupContentView];
    
    self.supportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.supportButton.frame = CGRectMake(HorizontalMargin, self.coverImageView.bottom + UIMargin, 20, 20);
    
    self.collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectionButton.frame = CGRectMake(self.supportButton.right + UIMargin, self.coverImageView.bottom + UIMargin, 20, 20);
    
    self.bookpostSearchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bookpostSearchButton.frame = CGRectMake(CELLWIDTH_DEFAULT - HorizontalMargin - UIMargin - NUMBERLABEL_WIDTH * 2, self.coverImageView.bottom + UIMargin, NUMBERLABEL_WIDTH, 20);
    
    self.webSearchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.webSearchButton.frame = CGRectMake(CELLWIDTH_DEFAULT - HorizontalMargin - NUMBERLABEL_WIDTH, self.coverImageView.bottom + UIMargin, NUMBERLABEL_WIDTH, 20);
    
    self.supportButton.backgroundColor  = [UIColor redColor];
    self.collectionButton.backgroundColor = [UIColor redColor];
    self.bookpostSearchButton.backgroundColor = [UIColor redColor];
    self.webSearchButton.backgroundColor = [UIColor redColor];
    
    [self.contentView addSubview:self.supportButton];
    [self.contentView addSubview:self.collectionButton];
    [self.contentView addSubview:self.bookpostSearchButton];
    [self.contentView addSubview:self.webSearchButton];
}

- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPBookDetailCellItem class]]) {
        [super setObject:object];
        self.item = (ZCPBookDetailCellItem *)object;
        ZCPBookDetailCellItem *item = (ZCPBookDetailCellItem *)object;
        
        self.bookpostSearchButton.titleLabel.text = item.bookpostSearchButtonTitle;
        self.webSearchButton.titleLabel.text = item.webSearchButtonTitle;
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPBookDetailCellItem *item = (ZCPBookDetailCellItem *)object;
    return [item.cellHeight floatValue];
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
        self.cellHeight = @178;
    }
    return self;
}

@end