//
//  ZCPImageTextCell.m
//  Apartment
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPImageTextCell.h"

#pragma mark - Text Cell&Item
@implementation ZCPTextCell

#pragma mark - synthesize
@synthesize textLabel   = _textLabel;
@synthesize item        = _item;

#pragma mark - Setup Cell
/**
 *  初始化视图
 */
- (void)setupContentView {
    
    self.textLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.textLabel];
}
/**
 *  通过item进行设置
 */
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPTextCellItem class]] && self.item != object) {
        self.item = (ZCPTextCellItem *)object;
        ZCPTextCellItem *item = (ZCPTextCellItem *)object;
        
        self.accessoryType = item.accessoryType;
        CGFloat cellHeight = [item.cellHeight floatValue];
        
        self.textLabel.frame = CGRectMake(MARGIN_DEFAULT, MARGIN_DEFAULT, CELLWIDTH_DEFAULT - MARGIN_DEFAULT * 2 - RIGHT_WIDTH, cellHeight - MARGIN_DEFAULT * 2);
        
        [self.textLabel setAttributedText:item.text];
    }
}
/**
 *  设置cell的高度
 */
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPTextCellItem *item = (ZCPTextCellItem *)object;
    return [item.cellHeight floatValue];
}

@end

@implementation ZCPTextCellItem

#pragma mark - synthesize
@synthesize text            = _text;
@synthesize accessoryType   = _accessoryType;

#pragma mark - init
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPTextCell class];
        self.cellType = [ZCPTextCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super init]) {
        self.cellClass = [ZCPTextCell class];
        self.cellType = [ZCPTextCell cellIdentifier];
        self.cellHeight = @50;
    }
    return self;
}

@end

#pragma mark - Image Text Cell&Item
@implementation ZCPImageTextCell

#pragma mark - synthesize
@synthesize imgIcon     = _imgIcon;

/**
 *  初始化视图
 */
- (void)setupContentView {
    
    self.imgIcon = [[UIImageView alloc] init];
    self.textLabel = [[UILabel alloc] init];
    
    self.imgIcon.backgroundColor = [UIColor clearColor];
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.imgIcon];
    [self.contentView addSubview:self.textLabel];
}
/**
 *  通过item进行设置
 */
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPImageTextCellItem class]] && self.item != object) {
        self.item = (ZCPImageTextCellItem *)object;
        ZCPImageTextCellItem *item = (ZCPImageTextCellItem *)object;
        
        self.accessoryType = item.accessoryType;
        CGFloat cellHeight = [self.item.cellHeight floatValue];
        
        self.imgIcon.frame = CGRectMake(MARGIN_DEFAULT, MARGIN_DEFAULT, cellHeight - MARGIN_DEFAULT * 2, cellHeight - MARGIN_DEFAULT * 2);
        self.textLabel.frame = CGRectMake(self.imgIcon.x + self.imgIcon.width + MARGIN_IMG_TEXT, MARGIN_DEFAULT, CELLWIDTH_DEFAULT - self.imgIcon.width - MARGIN_IMG_TEXT - MARGIN_DEFAULT * 2 - RIGHT_WIDTH, cellHeight - MARGIN_DEFAULT * 2);
        
        if ([item.imageName is_url]) {
            [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:item.imageName] placeholderImage:[UIImage imageNamed:HEAD_IMAGE_NAME_DEFAULT]];
        } else {
            [self.imgIcon setImage:[UIImage imageNamed:item.imageName]];
        }
        [self.textLabel setAttributedText:item.text];
    }
}
/**
 *  设置cell的高度
 */
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPImageTextCellItem *item = (ZCPImageTextCellItem *)object;
    return [item.cellHeight floatValue];
}

@end
@implementation ZCPImageTextCellItem

#pragma mark - synthesize
@synthesize imageName   = _imageName;

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPImageTextCell class];
        self.cellType = [ZCPImageTextCell cellIdentifier];
    }
    return self;
}

- (instancetype)initWithDefault {
    if (self = [super init]) {
        self.cellClass = [ZCPImageTextCell class];
        self.cellType = [ZCPImageTextCell cellIdentifier];
        self.cellHeight = @50;
    }
    return self;
}

@end


#pragma mark - Image Text Switch Cell&Item
@implementation ZCPImageTextSwitchCell

#pragma mark - synthesize
@synthesize switchView  = _switchView;

/**
 *  初始化视图
 */
- (void)setupContentView {
    
    self.imgIcon = [[UIImageView alloc] init];
    self.textLabel = [[UILabel alloc] init];
    self.switchView = [[UISwitch alloc] init];
    self.switchView.onTintColor = [UIColor buttonDefaultColor];
    
    self.imgIcon.backgroundColor = [UIColor clearColor];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.switchView.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.imgIcon];
    [self.contentView addSubview:self.textLabel];
    [self.contentView addSubview:self.switchView];
}
/**
 *  通过item进行设置
 */
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPImageTextSwitchCellItem class]] && self.item != object) {
        
        self.item = (ZCPImageTextSwitchCellItem *)object;
        ZCPImageTextSwitchCellItem *item = (ZCPImageTextSwitchCellItem *)self.item;
        CGFloat cellHeight = [self.item.cellHeight floatValue];
        
        // 设置frame
        self.imgIcon.frame = CGRectMake(MARGIN_DEFAULT, VerticalMargin, cellHeight - MARGIN_DEFAULT * 2, cellHeight - MARGIN_DEFAULT * 2);
        self.textLabel.frame = CGRectMake(self.imgIcon.x + self.imgIcon.width + MARGIN_IMG_TEXT, VerticalMargin, CELLWIDTH_DEFAULT - self.imgIcon.width - MARGIN_IMG_TEXT - MARGIN_DEFAULT * 2 - RIGHT_WIDTH, cellHeight - MARGIN_DEFAULT * 2);
        self.switchView.frame = CGRectMake(CELLWIDTH_DEFAULT - MARGIN_DEFAULT - self.switchView.width, VerticalMargin, self.switchView.width, self.switchView.height);
        
        // 设置属性
        if ([item.imageName is_url]) {
            [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:item.imageName] placeholderImage:[UIImage imageNamed:HEAD_IMAGE_NAME_DEFAULT]];
        } else {
            [self.imgIcon setImage:[UIImage imageNamed:item.imageName]];
        }
        [self.textLabel setAttributedText:item.text];
        [self.switchView addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.switchView setOn:([[ZCPControlingCenter sharedInstance] appTheme] == LightTheme)?NO:YES];
    }
}
/**
 *  设置cell的高度
 */
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPImageTextSwitchCellItem *item = (ZCPImageTextSwitchCellItem *)object;
    return [item.cellHeight floatValue];
}

#pragma mark - Private Method
- (void)switchValueChanged:(UISwitch *)switchView {
    ZCPImageTextSwitchCellItem *item = (ZCPImageTextSwitchCellItem *)self.item;
    if (item.switchResponser && [item.switchResponser respondsToSelector:@selector(cell:switchValueChanged:)]) {
        [item.switchResponser cell:self switchValueChanged:switchView];
    }
}

@end

@implementation ZCPImageTextSwitchCellItem

#pragma mark - synthesize
@synthesize switchInitialValue  = _switchInitialValue;
@synthesize switchResponser     = _switchResponser;

#pragma mark - init
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPImageTextSwitchCell class];
        self.cellType = [ZCPImageTextSwitchCell cellIdentifier];
    }
    return self;
}

- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPImageTextSwitchCell class];
        self.cellType = [ZCPImageTextSwitchCell cellIdentifier];
        self.cellHeight = @50;
    }
    return self;
}

@end


#pragma mark - Image Text Button Cell&Item
@implementation ZCPImageTextButtonCell

#pragma mark - synthesize
@synthesize button  = _button;

/**
 *  初始化视图
 */
- (void)setupContentView {
    
    self.imgIcon = [[UIImageView alloc] init];
    self.textLabel = [[UILabel alloc] init];
    self.button = [[UIButton alloc] init];
    
    self.imgIcon.backgroundColor = [UIColor clearColor];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.button.backgroundColor = [UIColor clearColor];
    self.button.titleLabel.font = [UIFont defaultFontWithSize:13.0f];
    
    [self.contentView addSubview:self.imgIcon];
    [self.contentView addSubview:self.textLabel];
    [self.contentView addSubview:self.button];
}
/**
 *  通过item进行设置
 */
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPImageTextButtonCellItem class]] && self.item != object) {
        
        self.item = (ZCPImageTextButtonCellItem *)object;
        ZCPImageTextButtonCellItem *item = (ZCPImageTextButtonCellItem *)self.item;
        CGFloat cellHeight = [self.item.cellHeight floatValue];
        
        // 设置frame
        self.imgIcon.frame = CGRectMake(MARGIN_DEFAULT, VerticalMargin, cellHeight - MARGIN_DEFAULT * 2, cellHeight - MARGIN_DEFAULT * 2);
        self.textLabel.frame = CGRectMake(self.imgIcon.x + self.imgIcon.width + MARGIN_IMG_TEXT, VerticalMargin, CELLWIDTH_DEFAULT - self.imgIcon.width - MARGIN_IMG_TEXT - MARGIN_DEFAULT * 2 - RIGHT_WIDTH, cellHeight - MARGIN_DEFAULT * 2);
        self.button.frame = CGRectMake(CELLWIDTH_DEFAULT - MARGIN_DEFAULT - 70, VerticalMargin, 70, 30);
        
        // 设置属性
        if ([item.imageName is_url]) {
            [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:item.imageName] placeholderImage:[UIImage imageNamed:HEAD_IMAGE_NAME_DEFAULT]];
        } else {
            [self.imgIcon setImage:[UIImage imageNamed:item.imageName]];
        }
        [self.textLabel setAttributedText:item.text];
        [self.button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (item.buttonConfigBlock) {
            item.buttonConfigBlock(self.button);
        }
    }
}
/**
 *  设置cell的高度
 */
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPImageTextSwitchCellItem *item = (ZCPImageTextSwitchCellItem *)object;
    return [item.cellHeight floatValue];
}

#pragma mark - button clicked
- (void)buttonClicked:(UIButton *)button {
    ZCPImageTextButtonCellItem *item = (ZCPImageTextButtonCellItem *)self.item;
    if (item.delegate && [item.delegate respondsToSelector:@selector(cell:buttonClicked:)]) {
        [item.delegate cell:self buttonClicked:button];
    }
}

@end

@implementation ZCPImageTextButtonCellItem

#pragma mark - synthesize
@synthesize tagInfo             = _tagInfo;
@synthesize buttonConfigBlock   = _buttonConfigBlock;
@synthesize delegate            = _delegate;

#pragma mark - init
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPImageTextButtonCell class];
        self.cellType = [ZCPImageTextButtonCell cellIdentifier];
        self.cellHeight = @50;
    }
    return self;
}

@end
