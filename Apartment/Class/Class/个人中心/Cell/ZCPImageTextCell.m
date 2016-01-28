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

@synthesize textLabel = _textLabel;
@synthesize item = _item;

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
        
        self.textLabel.frame = CGRectMake(MARGIN_DEFAULT, MARGIN_DEFAULT, APPLICATIONWIDTH - MARGIN_DEFAULT * 2 - RIGHT_WIDTH, cellHeight - MARGIN_DEFAULT * 2);
        
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

@synthesize text = _text;
@synthesize accessoryType = _accessoryType;

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

@synthesize imgIcon = _imgIcon;

/**
 *  初始化视图
 */
- (void)setupContentView {
    
    self.imgIcon = [[UIImageView alloc] init];
    self.textLabel = [[UILabel alloc] init];
    
    self.imgIcon.backgroundColor = [UIColor redColor];
    //    self.textLabel.backgroundColor = [UIColor yellowColor];
    
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
        self.textLabel.frame = CGRectMake(self.imgIcon.frame.origin.x + self.imgIcon.frame.size.width + MARGIN_IMG_TEXT, MARGIN_DEFAULT, APPLICATIONWIDTH - self.imgIcon.frame.size.width - MARGIN_IMG_TEXT - MARGIN_DEFAULT * 2 - RIGHT_WIDTH, cellHeight - MARGIN_DEFAULT * 2);
        [self.imgIcon setImage:[UIImage imageNamed:item.imageURL]];
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

@synthesize imageURL = _imageURL;

#pragma mark - init
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

@synthesize switchView = _switchView;

/**
 *  初始化视图
 */
- (void)setupContentView {
    
    self.imgIcon = [[UIImageView alloc] init];
    self.textLabel = [[UILabel alloc] init];
    self.switchView = [[UISwitch alloc] init];
    
    self.imgIcon.backgroundColor = [UIColor redColor];
    //    self.textLabel.backgroundColor = [UIColor yellowColor];
    //    self.switchView.backgroundColor = [UIColor blueColor];
    
    [self.contentView addSubview:self.imgIcon];
    [self.contentView addSubview:self.textLabel];
    [self.contentView addSubview:self.switchView];
}
/**
 *  通过item进行设置
 */
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPImageTextSwitchCellItem class]] && self.item != object) {
        [super setObject:object];
        
        self.item = (ZCPImageTextSwitchCellItem *)object;
        ZCPImageTextSwitchCellItem *item = (ZCPImageTextSwitchCellItem *)self.item;
        CGFloat cellHeight = [self.item.cellHeight floatValue];
        
        self.imgIcon.frame = CGRectMake(MARGIN_DEFAULT, VerticalMargin, cellHeight - MARGIN_DEFAULT * 2, cellHeight - MARGIN_DEFAULT * 2);
        self.textLabel.frame = CGRectMake(self.imgIcon.frame.origin.x + self.imgIcon.frame.size.width + MARGIN_IMG_TEXT, VerticalMargin, APPLICATIONWIDTH - self.imgIcon.frame.size.width - MARGIN_IMG_TEXT - MARGIN_DEFAULT * 2 - RIGHT_WIDTH, cellHeight - MARGIN_DEFAULT * 2);
        self.switchView.frame = CGRectMake(APPLICATIONWIDTH - MARGIN_DEFAULT - self.switchView.frame.size.width, VerticalMargin, self.switchView.frame.size.width, self.switchView.frame.size.height);
        
        [self.imgIcon setImage:[UIImage imageNamed:item.imageURL]];
        [self.textLabel setAttributedText:item.text];
        [self.switchView addTarget:item.switchResponser action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
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

@end

@implementation ZCPImageTextSwitchCellItem

@synthesize switchInitialValue = _switchInitialValue;
@synthesize switchResponser = _switchResponser;

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
