//
//  ZCPTextViewCell.m
//  Apartment
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTextViewCell.h"

@implementation ZCPTextViewCell

@synthesize textView = _textView;
@synthesize item = _item;

#pragma mark - Setup Cell
- (void)setupContentView {
    
    self.textView = [[ZCPTextView alloc] init];
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
    [self.contentView addSubview:self.textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:nil];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPTextViewCellItem class]] && self.item != object) {
        self.item = (ZCPTextViewCellItem *)object;
        
        // 设置frame
        [self.textView setHeight:[self.item.cellHeight floatValue]];
        self.textView.frame = CGRectMake(self.item.textEdgeInset.left
                                         , self.item.textEdgeInset.top
                                         , CELLWIDTH_DEFAULT - self.item.textEdgeInset.left - self.item.textEdgeInset.right
                                         , [self.item.cellHeight floatValue] - self.item.textEdgeInset.top - self.item.textEdgeInset.bottom);
        
        // 设置属性
        self.textView.placeholder = self.item.placeholder;
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPTextViewCellItem *item = (ZCPTextViewCellItem *)object;
    return [item.cellHeight floatValue];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
}
#pragma mark - Notification
- (void)textDidChange:(NSNotification *)notification {
    self.item.textInputValue = self.textView.text;
}
@end

@implementation ZCPTextViewCellItem

@synthesize placeholder = _placeholder;
@synthesize textEdgeInset = _textEdgeInset;

#pragma mark - instancetype
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
