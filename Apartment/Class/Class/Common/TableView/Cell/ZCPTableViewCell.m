//
//  ZCPTableViewCell.m
//  Apartment
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPTableViewCell.h"

@implementation ZCPTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupContentView];
    }
    return self;
}
- (void)setupContentView {
    self.backgroundColor = [UIColor clearColor];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setObject:(NSObject *)object {
    _object = object;
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 44.0f;
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

@end
