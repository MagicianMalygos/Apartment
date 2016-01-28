//
//  ZCPButtonCell.m
//  Apartment
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPButtonCell.h"



@implementation ZCPButtonCell

@synthesize button = _button;
@synthesize item = _item;
@synthesize delegate = _delegate;

- (void)layoutSubviews {
    [super layoutSubviews];
    _button.frame = CGRectMake(8, 0, APPLICATIONWIDTH - 16, self.height);
}

- (void)setupContentView {
    [self setCustomBackgroundColor:[UIColor clearColor]];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    self.button.layer.borderColor = COLOR_FONT_ORANGE.CGColor;
//    self.button.layer.borderWidth = 0.5;
    [self.contentView addSubview:self.button];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPButtonCellItem class]] && self.item != object) {
        [super setObject:object];
        self.item = (ZCPButtonCellItem *)object;
        ZCPButtonCellItem *item = (ZCPButtonCellItem *)object;
        
        self.delegate = item.delegate;
        self.button.tag = item.tag;
        
        self.button.titleLabel.text = item.buttonTitle;
        
        if (item.buttonBackgroundColor) {
            self.button.backgroundColor = item.buttonBackgroundColor;
        }
        if (item.buttonBackgroundImageNormal) {
            [self.button setBackgroundImage:item.buttonBackgroundImageNormal forState:UIControlStateNormal];
        }
        if (item.buttonBackgroundImageHighlighted) {
            [self.button setBackgroundImage:item.buttonBackgroundImageHighlighted forState:UIControlStateHighlighted];
        }
        if (item.buttonBackgroundImageDisabled) {
            [self.button setBackgroundImage:item.buttonBackgroundImageDisabled forState:UIControlStateDisabled];
        }
        if (item.titleColorNormal) {
            [self.button setTitleColor:item.titleColorNormal forState:UIControlStateNormal];
        }
        if (item.titleColorHighlighted) {
            [self.button setTitleColor:self.item.titleColorHighlighted forState:UIControlStateHighlighted];
        }
        if (item.titleFontNormal) {
            [self.button.titleLabel setFont:item.titleFontNormal];
        }
        if (item.state == ZCPButtonInitStateDisabled) {
            self.button.enabled = NO;
        }
        else if(item.state == ZCPButtonInitStateNormal) {
            // 设置圆角与默认的颜色
            [self.button configureDefault];
            self.button.enabled = YES;
        }
        [self.button setTitle:item.buttonTitle forState:UIControlStateNormal];
        if (item.buttonConfigBlock) {
            self.item.buttonConfigBlock(self.button);
        }
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPButtonCellItem *item = (ZCPButtonCellItem *)object;
    return [item.cellHeight floatValue];
}
+ (NSNumber *)cellHeight {
    return @45.0f;
}

#pragma mark - Btn Click
- (void)buttonClicked:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cell:buttonClicked:)]) {
        [self.delegate cell:self buttonClicked:button];
    }
}

@end


@implementation ZCPButtonCellItem

@synthesize buttonTitle = _buttonTitle;
@synthesize titleColorNormal = _titleColorNormal;
@synthesize titleColorHighlighted = _titleColorHighlighted;
@synthesize titleFontNormal = _titleFontNormal;
@synthesize buttonBackgroundColor = _buttonBackgroundColor;
@synthesize buttonBackgroundImageNormal = _buttonBackgroundImageNormal;
@synthesize buttonBackgroundImageHighlighted = _buttonBackgroundImageHighlighted;
@synthesize buttonBackgroundImageDisabled = _buttonBackgroundImageDisabled;
@synthesize tag = _tag;
@synthesize state = _state;
@synthesize delegate = _delegate;

+ (instancetype)buttonCellItem {
    ZCPButtonCellItem *buttonItem = [[ZCPButtonCellItem alloc] initWithDefault];
    buttonItem.buttonConfigBlock = ^(UIButton *button) {
        [button setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xeeeeee)] forState:UIControlStateDisabled];
        [button setBackgroundImage:nil forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    };
    return buttonItem;
}
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPButtonCell class];
        self.cellHeight = [ZCPButtonCell cellHeight];
        self.cellType = [ZCPButtonCell cellIdentifier];
        self.state = ZCPButtonInitStateNormal;
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPButtonCell class];
        self.cellHeight = [ZCPButtonCell cellHeight];
        self.cellType = [ZCPButtonCell cellIdentifier];
        
        self.titleColorNormal = [UIColor blackColor];
        self.state = ZCPButtonInitStateNormal;
    }
    return self;
}

@end