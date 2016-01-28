//
//  ZCPTextViewCell.m
//  Apartment
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTextViewCell.h"

@implementation ZCPTextViewCell

- (void)setupContentView {
    [super setupContentView];
    
    self.textView = [[UITextView alloc] init];
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
    [self.contentView addSubview:self.textView];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPTextViewCellItem class]] && self.item != object) {
        [super setObject:object];
        self.item = (ZCPTextViewCellItem *)object;
        
        [self.textView setHeight:[self.item.cellHeight floatValue]];
        self.textView.frame = CGRectMake(self.item.textEdgeInset.left
                                         , self.item.textEdgeInset.top
                                         , APPLICATIONWIDTH - self.item.textEdgeInset.left - self.item.textEdgeInset.right
                                         , [self.item.cellHeight floatValue] - self.item.textEdgeInset.top - self.item.textEdgeInset.bottom);
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPTextViewCellItem *item = (ZCPTextViewCellItem *)object;
    return [item.cellHeight floatValue];
}

@end

@implementation ZCPTextViewCellItem

#pragma mark - init
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPTextViewCell class];
        self.cellType = [ZCPTextViewCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPTextViewCell class];
        self.cellType = [ZCPTextViewCell cellIdentifier];
        self.cellHeight = @80;
        self.textEdgeInset = UIEdgeInsetsMake(4, 4, 4, 4);
    }
    return self;
}

@end
