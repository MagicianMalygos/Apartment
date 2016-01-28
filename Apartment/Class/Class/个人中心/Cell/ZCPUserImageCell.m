//
//  ZCPUserImageCell.m
//  Apartment
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPUserImageCell.h"

// 用户头像宽度
#define USER_HEADER_WIDTH       100
#define USER_HEADER_HEIGHT      100

@implementation ZCPUserImageCell

@synthesize bgImageView = _bgImageView;
@synthesize userHeadButton = _userHeadButton;
@synthesize item = _item;

- (void)setupContentView {
    
    self.bgImageView = [[UIImageView alloc] init];
    self.userHeadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.bgImageView.backgroundColor = [UIColor magentaColor];
    self.userHeadButton.backgroundColor = [UIColor cyanColor];
    
    [self.contentView addSubview:self.bgImageView];
    [self.contentView addSubview:self.userHeadButton];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPUserImageCellItem class]] && self.item != object) {
        [super setObject:object];
        
        self.item = (ZCPUserImageCellItem *)object;
        ZCPUserImageCellItem *item = (ZCPUserImageCellItem *)object;
        
        self.bgImageView.frame = CGRectMake(0, 0, APPLICATIONWIDTH, [item.cellHeight floatValue]);
        self.userHeadButton.frame = CGRectMake((APPLICATIONWIDTH - USER_HEADER_WIDTH)/2, self.bgImageView.frame.size.height - USER_HEADER_HEIGHT, USER_HEADER_WIDTH, USER_HEADER_HEIGHT);
        
        [self.bgImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.bgImageURL]]]];
        [self.userHeadButton setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.bgImageURL]]] forState:UIControlStateNormal];
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPUserImageCellItem *item = (ZCPUserImageCellItem *)object;
    return [item.cellHeight floatValue];
}

@end

@implementation ZCPUserImageCellItem

@synthesize bgImageURL = _bgImageURL;
@synthesize userHeadURL = _userHeadURL;

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPUserImageCell class];
        self.cellType = [ZCPUserImageCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPUserImageCell class];
        self.cellType = [ZCPUserImageCell cellIdentifier];
        self.cellHeight = @200;
    }
    return self;
}

@end