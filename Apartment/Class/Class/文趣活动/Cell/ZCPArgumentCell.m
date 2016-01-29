//
//  ZCPArgumentCell.m
//  Apartment
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPArgumentCell.h"

#define IMG_WIDTH 25                // 图片宽度
#define IMG_HEIGHT 25               // 图片高度
#define NAMELABEL_HEIGHT 25         // 姓名标签高度
#define BUTTON_WIDTH 20             // 按钮宽度
#define BUTTON_HEIGHT 20            // 按钮高度
#define SUPPORTLABEL_WIDTH 80       // 点赞量标签宽度
#define SUPPORTLABEL_HEIGHT 15      // 点赞量标签高度

@implementation ZCPArgumentCell

@synthesize userHeadImgView = _userHeadImgView;
@synthesize userNameLabel = _userNameLabel;
@synthesize supportNumberLabel = _supportNumberLabel;
@synthesize supportButton = _supportButton;
@synthesize argumentContentLabel = _argumentContentLabel;
@synthesize timeLabel = _timeLabel;
@synthesize item = _item;

#pragma mark - Setup Cell
- (void)setupContentView {
    
    // 第一行
    self.userHeadImgView = [[UIImageView alloc] initWithFrame:CGRectMake(HorizontalMargin, VerticalMargin, IMG_WIDTH, IMG_HEIGHT)];

    self.supportNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CELLWIDTH_DEFAULT - HorizontalMargin - UIMargin - SUPPORTLABEL_WIDTH - BUTTON_WIDTH, VerticalMargin + 10, SUPPORTLABEL_WIDTH, SUPPORTLABEL_HEIGHT)];
    self.supportNumberLabel.textAlignment = NSTextAlignmentRight;
    self.supportNumberLabel.font = [UIFont systemFontOfSize:13.0f];
    
    self.supportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.supportButton.frame = CGRectMake(CELLWIDTH_DEFAULT - HorizontalMargin - BUTTON_WIDTH, VerticalMargin + 5, BUTTON_WIDTH, BUTTON_HEIGHT);
    
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userHeadImgView.right + UIMargin, VerticalMargin, CELLWIDTH_DEFAULT - HorizontalMargin * 2 - UIMargin * 3 - IMG_WIDTH - BUTTON_WIDTH - SUPPORTLABEL_WIDTH, NAMELABEL_HEIGHT)];
    self.userNameLabel.textAlignment = NSTextAlignmentLeft;
    self.userNameLabel.font = [UIFont systemFontOfSize:15.0f];
    
    // 第二行
    self.argumentContentLabel = [[UILabel alloc] init];
    self.argumentContentLabel.numberOfLines = 0;
    self.argumentContentLabel.textAlignment = NSTextAlignmentLeft;
    self.argumentContentLabel.font = [UIFont systemFontOfSize:17.0f weight:10.0f];
    
    // 第三行
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.font = [UIFont systemFontOfSize:13.0f];
    
    self.userHeadImgView.backgroundColor = [UIColor redColor];
    self.userNameLabel.backgroundColor = [UIColor redColor];
    self.supportButton.backgroundColor = [UIColor redColor];
    self.supportNumberLabel.backgroundColor = [UIColor redColor];
    self.argumentContentLabel.backgroundColor = [UIColor greenColor];
    self.timeLabel.backgroundColor = [UIColor yellowColor];
    
    [self.contentView addSubview:self.userHeadImgView];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.supportButton];
    [self.contentView addSubview:self.supportNumberLabel];
    [self.contentView addSubview:self.argumentContentLabel];
    [self.contentView addSubview:self.timeLabel];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPArgumentCellItem class]] && self.item != object) {
        self.item = (ZCPArgumentCellItem *)object;
        
        // 计算高度
        CGFloat contentHeight = [self.item.argumentContent boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - HorizontalMargin * 2, CGFLOAT_MAX)
                                                                        options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17.0f weight:10.0f]}
                                                                        context:nil].size.height;
        // 设置frame
        self.argumentContentLabel.frame = CGRectMake(HorizontalMargin, self.userHeadImgView.bottom + UIMargin, CELLWIDTH_DEFAULT - HorizontalMargin * 2, contentHeight);
        self.timeLabel.frame = CGRectMake(HorizontalMargin, self.argumentContentLabel.bottom + UIMargin, CELLWIDTH_DEFAULT - HorizontalMargin * 2, 20);
        
        // 设置内容
        self.userHeadImgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.item.userHeadImgURL]]];
        self.userNameLabel.text = self.item.userName;
        self.argumentContentLabel.text = self.item.argumentContent;
        self.timeLabel.text = [ZCPDataModel stringValueFromDateValue:self.item.time];
        
        // 设置cell高度
        self.item.cellHeight = [NSNumber numberWithFloat:self.timeLabel.bottom + VerticalMargin];
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPArgumentCellItem *item = (ZCPArgumentCellItem *)object;
    CGFloat contentHeight = [item.argumentContent boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - HorizontalMargin * 2, CGFLOAT_MAX)
                                                                    options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                                 attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17.0f weight:10.0f]}
                                                                    context:nil].size.height;
    return 25.0f + contentHeight + 20.0f + UIMargin * 2 + VerticalMargin * 2;
}

@end

@implementation ZCPArgumentCellItem

@synthesize userHeadImgURL = _userHeadImgURL;
@synthesize userName = _userName;
@synthesize argumentContent = _argumentContent;
@synthesize time = _time;
@synthesize supportNumber = _supportNumber;

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPArgumentCell class];
        self.cellType = [ZCPArgumentCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPArgumentCell class];
        self.cellType = [ZCPArgumentCell cellIdentifier];
    }
    return self;
}

@end