//
//  ZCPThesisCell.m
//  Apartment
//
//  Created by apple on 16/2/2.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPThesisCell.h"

@implementation ZCPThesisCell

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
