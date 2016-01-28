//
//  ZCPSectionCell.m
//  Apartment
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPSectionCell.h"

#pragma mark - Section Cell
@implementation ZCPSectionCell

/**
 *  cell的初始化方法
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setCustomBackgroundColor:[UIColor clearColor]];
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _sectionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, APPLICATIONWIDTH - 20, 0)];
        _sectionTitleLabel.textColor = [UIColor blackColor];
        _sectionTitleLabel.backgroundColor = [UIColor clearColor];
        _sectionTitleLabel.numberOfLines = 1;
        [self.contentView addSubview:_sectionTitleLabel];
    }
    return self;
}

#pragma mark - getter / setter
- (void)setObject:(id)object {
    if ([object isKindOfClass:[ZCPSectionCellItem class]] && self.item != object) {
        
        [super setObject:object];
        
        self.item = (ZCPSectionCellItem *)object;
        ZCPSectionCellItem *item = (ZCPSectionCellItem *)object;
        
        // 更新数据
        if (![item.sectionAttrTitle length]) {
            _sectionTitleLabel.font = item.font;
            _sectionTitleLabel.text = item.sectionTitle;
            CGSize size = [item.sectionTitle boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size;
            _sectionTitleLabel.frame = CGRectMake(_sectionTitleLabel.frame.origin.x, _sectionTitleLabel.frame.origin.y, _sectionTitleLabel.frame.size.width, size.height);
        }
        else {
            _sectionTitleLabel.attributedText = item.sectionAttrTitle;
            CGSize size = [item.sectionAttrTitle boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            _sectionTitleLabel.frame = CGRectMake(_sectionTitleLabel.frame.origin.x, _sectionTitleLabel.frame.origin.y, _sectionTitleLabel.frame.size.width, size.height);
        }
        
    }
}
/**
 *  获取cell高度
 */
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    CGFloat height = 0;
    if ([object conformsToProtocol:@protocol(ZCPTableViewCellItemBasicProtocol)]
        && [object respondsToSelector:@selector(cellHeight)]) {
        if ([object cellHeight]) {
            height = [[object cellHeight] floatValue];
        }
        else {
            ZCPSectionCellItem *item = (ZCPSectionCellItem *)object;
            CGSize size = [item.sectionTitle boundingRectWithSize:CGSizeMake(APPLICATIONWIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size;
            return size.height + 20;
        }
    }
    return height;
}
#pragma mark - layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    UIEdgeInsets insets = [(ZCPSectionCellItem *)self.item titleEdgeInset];
    if (UIEdgeInsetsEqualToEdgeInsets(insets, UIEdgeInsetsZero)) {
        self.sectionTitleLabel.frame = CGRectMake(8, insets.top, self.frame.size.width - 8 * 2, self.frame.size.height - insets.top - insets.bottom);
    }
    else {
        self.sectionTitleLabel.frame = CGRectMake(insets.left, insets.top, self.frame.size.width - insets.left - insets.right, self.frame.size.height - insets.top - insets.bottom);
    }
}

@end

#pragma mark - Section CellItem
@implementation ZCPSectionCellItem

@synthesize sectionTitle = _sectionTitle;
@synthesize font = _font;


#pragma mark - init
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPSectionCell class];
        self.cellType = [ZCPSectionCell cellIdentifier];
        self.font = [UIFont systemFontOfSize:14.0f];
        self.titleEdgeInset = UIEdgeInsetsZero;
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPSectionCell class];
        self.cellType = [ZCPSectionCell cellIdentifier];
        self.font = [UIFont systemFontOfSize:14.0f];
        self.titleEdgeInset = UIEdgeInsetsZero;
        self.cellHeight = @20;
    }
    return self;
}
- (instancetype)copyWithZone:(NSZone *)zone {
    ZCPSectionCellItem *item = [[ZCPSectionCellItem alloc] init];
    item.cellClass = [self cellClass];
    item.cellHeight = [self cellHeight];
    item.cellType = [self cellType];
    item.sectionTitle = self.sectionTitle;
    item.titleEdgeInset = self.titleEdgeInset;
    item.font = self.font;
    return item;
}

@end