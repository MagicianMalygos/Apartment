//
//  ZCPHeadImageCell.m
//  Apartment
//
//  Created by apple on 16/1/20.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPHeadImageCell.h"

@implementation ZCPHeadImageCell

@synthesize bigButton = _bigButton;
@synthesize middleButton = _middleButton;
@synthesize smallButton = _smallButton;
@synthesize bgImageView = _bgImageView;
@synthesize item = _item;
@synthesize delegate = _delegate;

#pragma mark - Setup Cell
- (void)setupContentView {
    
    self.bigButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.smallButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bgImageView = [[UIImageView alloc] init];
    
    [self.bigButton setBackgroundColor:[UIColor clearColor]];
    [self.middleButton setBackgroundColor:[UIColor clearColor]];
    [self.smallButton setBackgroundColor:[UIColor clearColor]];
    [self.bgImageView setBackgroundColor:[UIColor clearColor]];
    
    [self.contentView addSubview:self.bigButton];
    [self.contentView addSubview:self.middleButton];
    [self.contentView addSubview:self.smallButton];
    [self.contentView addSubview:self.bgImageView];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPHeadImageCellItem class]] && self.item != object) {
        self.item = (ZCPHeadImageCellItem *)object;
        self.delegate = self.item.delegate;
        
        ZCPHeadImageCellItem *item = (ZCPHeadImageCellItem *)object;
        CGFloat cellHeight = [item.cellHeight floatValue];
        
        CGFloat marginTop = 16;
        CGFloat buttonSide = (cellHeight - marginTop * 2) / 5;
        CGFloat marginLeft = (CELLWIDTH_DEFAULT - buttonSide * 12) / 4;
        
        // 设置frame
        self.bigButton.frame = CGRectMake(marginLeft, marginTop, 5 * buttonSide, 5 * buttonSide);
        self.middleButton.frame = CGRectMake(marginLeft * 2 + buttonSide * 5
                                             , marginTop + buttonSide * 0.5
                                             , buttonSide * 4
                                             , buttonSide * 4);
        self.smallButton.frame = CGRectMake(marginLeft * 3 + buttonSide * 9
                                            , marginTop + buttonSide
                                            , buttonSide * 3
                                            , buttonSide * 3);
        self.bgImageView.frame = CGRectMake(0, 0, CELLWIDTH_DEFAULT, cellHeight);
        [self.contentView sendSubviewToBack:self.bgImageView];
        
        // 设置图片
        WEAK_SELF;
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:self.item.headImageURL] placeholderImage:[UIImage imageNamed:HEAD_DEFAULT] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            // 设置大中小头像
            [weakSelf.bigButton setOnlyImage:weakSelf.bgImageView.image];
            [weakSelf.middleButton setOnlyImage:weakSelf.bgImageView.image];
            [weakSelf.smallButton setOnlyImage:weakSelf.bgImageView.image];
            
            // 毛玻璃
            UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
            effectview.frame = CGRectMake(0, 0, weakSelf.bgImageView.width, weakSelf.bgImageView.height);
            [weakSelf.bgImageView addSubview:effectview];
        }];
        
        // 添加头像按钮点击事件
        [self.bigButton addTarget:self action:@selector(headImageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.middleButton addTarget:self action:@selector(headImageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.smallButton addTarget:self action:@selector(headImageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPHeadImageCellItem *item = (ZCPHeadImageCellItem *)object;
    return [item.cellHeight floatValue];
}

#pragma mark - Btn Click
- (void)headImageButtonClicked:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cell:headImageButtonClicked:)]) {
        [self.delegate cell:self headImageButtonClicked:button];
    }
}

@end

@implementation ZCPHeadImageCellItem

@synthesize headImageURL = _headImageURL;

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPHeadImageCell class];
        self.cellType = [ZCPHeadImageCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPHeadImageCell class];
        self.cellType = [ZCPHeadImageCell cellIdentifier];
        self.cellHeight = @150;
    }
    return self;
}

@end
