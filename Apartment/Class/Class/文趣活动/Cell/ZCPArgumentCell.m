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

#pragma mark - synthesize
@synthesize userHeadImgView         = _userHeadImgView;
@synthesize userNameLabel           = _userNameLabel;
@synthesize supportNumberLabel      = _supportNumberLabel;
@synthesize supportButton           = _supportButton;
@synthesize argumentContentLabel    = _argumentContentLabel;
@synthesize timeLabel               = _timeLabel;
@synthesize item                    = _item;
@synthesize delegate                = _delegate;

#pragma mark - Setup Cell
- (void)setupContentView {
    
    // 第一行
    self.userHeadImgView = [[UIImageView alloc] initWithFrame:CGRectMake(HorizontalMargin, VerticalMargin, IMG_WIDTH, IMG_HEIGHT)];

    self.supportNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CELLWIDTH_DEFAULT - HorizontalMargin - UIMargin - SUPPORTLABEL_WIDTH - BUTTON_WIDTH, VerticalMargin + 10, SUPPORTLABEL_WIDTH, SUPPORTLABEL_HEIGHT)];
    self.supportNumberLabel.textAlignment = NSTextAlignmentRight;
    self.supportNumberLabel.font = [UIFont defaultFontWithSize:13.0f];
    
    self.supportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.supportButton.frame = CGRectMake(CELLWIDTH_DEFAULT - HorizontalMargin - BUTTON_WIDTH, VerticalMargin + 5, BUTTON_WIDTH, BUTTON_HEIGHT);
    [self.supportButton setImageNameNormal:@"support_normal" Highlighted:@"support_selected" Selected:@"support_selected" Disabled:@"support_normal"];
    [self.supportButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.userHeadImgView.right + UIMargin, VerticalMargin, CELLWIDTH_DEFAULT - HorizontalMargin * 2 - UIMargin * 3 - IMG_WIDTH - BUTTON_WIDTH - SUPPORTLABEL_WIDTH, NAMELABEL_HEIGHT)];
    self.userNameLabel.textAlignment = NSTextAlignmentLeft;
    self.userNameLabel.font = [UIFont defaultFontWithSize:15.0f];
    
    // 第二行
    self.argumentContentLabel = [[UILabel alloc] init];
    self.argumentContentLabel.numberOfLines = 0;
    self.argumentContentLabel.textAlignment = NSTextAlignmentLeft;
    self.argumentContentLabel.font = [UIFont defaultBoldFontWithSize:18.0f];
    
    // 第三行
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.font = [UIFont defaultFontWithSize:13.0f];
    
    self.userHeadImgView.backgroundColor = [UIColor clearColor];
    self.userNameLabel.backgroundColor = [UIColor clearColor];
    self.supportButton.backgroundColor = [UIColor clearColor];
    self.supportNumberLabel.backgroundColor = [UIColor clearColor];
    self.argumentContentLabel.backgroundColor = [UIColor clearColor];
    self.timeLabel.backgroundColor = [UIColor clearColor];
    
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
        CGFloat contentHeight = [self.item.argumentModel.argumentContent boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - HorizontalMargin * 2, CGFLOAT_MAX)
                                                                        options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                                     attributes:@{NSFontAttributeName: [UIFont defaultBoldFontWithSize:18.0f]}
                                                                        context:nil].size.height;
        // 设置frame
        self.argumentContentLabel.frame = CGRectMake(HorizontalMargin, self.userHeadImgView.bottom + UIMargin, CELLWIDTH_DEFAULT - HorizontalMargin * 2, contentHeight);
        self.timeLabel.frame = CGRectMake(HorizontalMargin, self.argumentContentLabel.bottom + UIMargin, CELLWIDTH_DEFAULT - HorizontalMargin * 2, 20);
        
        // 设置内容
        self.delegate = self.item.delegate;
        self.supportButton.selected = (self.item.argumentModel.supported == ZCPCurrUserHaveSupportArgument)? YES: NO;
        [self.userHeadImgView sd_setImageWithURL:[NSURL URLWithString:self.item.argumentModel.user.userFaceURL] placeholderImage:[UIImage imageNamed:HEAD_IMAGE_NAME_DEFAULT]];
        self.userNameLabel.text = self.item.argumentModel.user.userName;
        self.supportNumberLabel.text = [NSString getFormateFromNumberOfPeople:self.item.argumentModel.argumentSupport];
        self.argumentContentLabel.text = self.item.argumentModel.argumentContent;
        self.timeLabel.text = [self.item.argumentModel.argumentTime toString];
        
        // 设置cell高度
        self.item.cellHeight = [NSNumber numberWithFloat:self.timeLabel.bottom + VerticalMargin];
        
        [self.userHeadImgView changeToRound];
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPArgumentCellItem *item = (ZCPArgumentCellItem *)object;
    
    // 第一行
    CGFloat rowHeight1 = 25.0f;
    // 第二行
    CGFloat rowHeight2 = [item.argumentModel.argumentContent boundingRectWithSize:CGSizeMake(CELLWIDTH_DEFAULT - HorizontalMargin * 2, CGFLOAT_MAX)
                                                            options:NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin
                                                         attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17.0f weight:10.0f]}
                                                            context:nil].size.height;
    // 第三行
    CGFloat rowHeight3 = 20.0f;
    // cell高度
    CGFloat cellHeight = rowHeight1 + rowHeight2 + rowHeight3 + VerticalMargin * 2 + UIMargin * 2;
    
    return cellHeight;
}

#pragma mark - Button Click
- (void)buttonClicked:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(argumentCell:supportButtonClicked:)]) {
        [self.delegate argumentCell:self supportButtonClicked:button];
    }
}

@end

@implementation ZCPArgumentCellItem

#pragma mark - synthesize
@synthesize argumentModel   = _argumentModel;
@synthesize delegate        = _delegate;

#pragma mark - instancetype
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPArgumentCell class];
        self.cellType = [ZCPArgumentCell cellIdentifier];
    }
    return self;
}

@end