//
//  ZCPTableViewCell.h
//  Apartment
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MARGIN_DEFAULT      8

@interface ZCPTableViewCell : UITableViewCell

@property (nonatomic, strong) NSObject *object;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setupContentView;
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object;

+ (NSString *)cellIdentifier;

@end
