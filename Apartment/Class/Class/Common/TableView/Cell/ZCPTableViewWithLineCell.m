//
//  PATableViewWithLineCell.m
//  haofang
//
//  Created by shakespeare on 14-4-1.
//  Copyright (c) 2014年 平安好房. All rights reserved.
//

#import "ZCPTableViewWithLineCell.h"

@implementation ZCPTableViewWithLineCell

#pragma mark - synthesize
@synthesize lineUpper   = _lineUpper;
@synthesize lineLower   = _lineLower;

#pragma mark - instancetype
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.clipsToBounds = NO;
        self.contentView.clipsToBounds = NO;
        if ([self.contentView.superview isKindOfClass:[NSClassFromString(@"UITableViewCellScrollView") class]]) {
            self.contentView.superview.clipsToBounds = NO;
        }
        
        _lineUpper = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, -OnePoint, CELLWIDTH_DEFAULT, -OnePoint)];
        _lineUpper.backgroundColor = [UIColor colorFromHexRGB:@"dddddd"];
        [self addSubview:_lineUpper];
    
        _lineLower = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, self.height, CELLWIDTH_DEFAULT, -OnePoint)];
        _lineLower.backgroundColor = [UIColor colorFromHexRGB:@"dddddd"];
        [self addSubview:_lineLower];
    }

    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat line = OnePoint;
    
    CGFloat upperOffset = 0.0f;
    CGFloat lowerOffset = 0.0f;
    
    _lineUpper.frame = CGRectMake(upperOffset, 0, CELLWIDTH_DEFAULT - upperOffset, line);
    _lineLower.frame = CGRectMake(lowerOffset, self.height, CELLWIDTH_DEFAULT - lowerOffset, line);
    [self bringSubviewToFront:_lineUpper];
    [self bringSubviewToFront:_lineLower];
    self.selectedBackgroundView.frame = self.bounds;
}

@end
