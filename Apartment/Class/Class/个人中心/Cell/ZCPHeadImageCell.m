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

- (void)setupContentView {
    
    self.bigButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.smallButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bgImageView = [[UIImageView alloc] init];
    
    [self.bigButton setBackgroundColor:[UIColor redColor]];
    [self.middleButton setBackgroundColor:[UIColor greenColor]];
    [self.smallButton setBackgroundColor:[UIColor blueColor]];
    [self.bgImageView setBackgroundColor:[UIColor lightGrayColor]];
    
    [self.contentView addSubview:self.bigButton];
    [self.contentView addSubview:self.middleButton];
    [self.contentView addSubview:self.smallButton];
    [self.contentView addSubview:self.bgImageView];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPHeadImageCellItem class]] && self.item != object) {
        [super setObject:object];
        self.item = (ZCPHeadImageCellItem *)object;
        self.delegate = self.item.delegate;
        
        ZCPHeadImageCellItem *item = (ZCPHeadImageCellItem *)object;
        CGFloat cellHeight = [item.cellHeight floatValue];
        
        CGFloat marginTop = 16;
        CGFloat buttonSide = (cellHeight - marginTop * 2) / 5;
        CGFloat marginLeft = (APPLICATIONWIDTH - 12*buttonSide) / 4;
        
        self.bigButton.frame = CGRectMake(marginLeft, marginTop, 5*buttonSide, 5*buttonSide);
        self.middleButton.frame = CGRectMake(marginLeft*2 + buttonSide*5, marginTop + 0.5*buttonSide, 4*buttonSide, 4*buttonSide);
        self.smallButton.frame = CGRectMake(marginLeft*3 + buttonSide*9, marginTop + buttonSide, 3*buttonSide, 3*buttonSide);
        self.bgImageView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, cellHeight);
        [self.contentView sendSubviewToBack:self.bgImageView];
        
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
