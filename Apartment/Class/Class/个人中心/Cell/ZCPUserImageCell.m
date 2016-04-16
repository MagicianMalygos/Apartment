//
//  ZCPUserImageCell.m
//  Apartment
//
//  Created by apple on 16/1/15.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "ZCPUserImageCell.h"

// 用户头像宽度
#define USER_HEAD_WIDTH       100
#define USER_HEAD_HEIGHT      100
#define USER_NAME_HEIGHT      30

@implementation ZCPUserImageCell

#pragma mark - synthesize
@synthesize bgImageView         = _bgImageView;
@synthesize userHeadImageView   = _userHeadImageView;
@synthesize userNameLabel       = _userNameLabel;
@synthesize userNameBgView      = _userNameBgView;
@synthesize item                = _item;

#pragma mark - Setup Cell
- (void)setupContentView {
    
    self.bgImageView = [[UIImageView alloc] init];
    self.userHeadImageView = [[UIImageView alloc] init];
    
    self.userNameLabel = [[UILabel alloc] init];
    self.userNameLabel.numberOfLines = 1;
    self.userNameLabel.textAlignment = NSTextAlignmentCenter;
    self.userNameLabel.font = [UIFont defaultBoldFontWithSize:20.0f];
    
    self.userNameBgView = [[UIView alloc] init];
    self.userNameBgView.alpha = 0.4f;
    self.userNameBgView.layer.masksToBounds = YES;
    self.userNameBgView.layer.cornerRadius = 5.0;
    
    self.bgImageView.backgroundColor = [UIColor clearColor];
    self.userHeadImageView.backgroundColor = [UIColor clearColor];
    self.userNameLabel.backgroundColor = [UIColor clearColor];
    self.userNameBgView.backgroundColor = [UIColor blackColor];
    
    [self.contentView addSubview:self.bgImageView];
    [self.contentView addSubview:self.userHeadImageView];
    [self.contentView addSubview:self.userNameBgView];
    [self.contentView addSubview:self.userNameLabel];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPUserImageCellItem class]] && self.item != object) {
        
        self.item = (ZCPUserImageCellItem *)object;
    
        // 设置属性
        WEAK_SELF;
        [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:self.item.bgImageURL] placeholderImage:[UIImage imageNamed:HEAD_IMAGE_NAME_DEFAULT] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            UIImage *loadImage = [UIImage imageNamed:HEAD_IMAGE_NAME_DEFAULT];
            if (image != nil) {
                loadImage = image;
            }
            
            // 高斯模糊（图片变小了）
//            CIContext *context = [CIContext contextWithOptions:nil];
//            CIImage *ciImage = [CIImage imageWithCGImage:loadImage.CGImage];
//            CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
//            [filter setValue:ciImage forKey:kCIInputImageKey];
//            [filter setValue:@20.0f forKey:@"inputRadius"];
//            CIImage *result = [filter valueForKey:kCIOutputImageKey];
//            CGImageRef imageRef = [context createCGImage:result fromRect:[result extent]];
//            UIImage *blurImage = [UIImage imageWithCGImage:imageRef];
//            [self.bgImageView setImage:blurImage];
            
            // 毛玻璃，效果很差劲
//            [self.bgImageView setImage:loadImage];
//            UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//            UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
//            effectview.frame = CGRectMake(0, 0, self.bgImageView.width, self.bgImageView.height);
//            [self.bgImageView addSubview:effectview];
            
            if ([ZCPControlingCenter sharedInstance].appTheme == LightTheme) {
                // 第三方实现模糊
                UIImage *blurImage = [loadImage imageByBlurRadius:20 tintColor:nil tintMode:0 saturation:1 maskImage:nil];
                [weakSelf.bgImageView setImage:blurImage];
            } else if ([ZCPControlingCenter sharedInstance].appTheme == DarkTheme) {
                weakSelf.bgImageView.image = nil;
                weakSelf.bgImageView.backgroundColor = NIGHT_CELL_BG_COLOR;
            }
        }];
        
        // 设置属性
        self.userNameLabel.text = self.item.userName;
        if ([ZCPControlingCenter sharedInstance].appTheme == LightTheme) {
            self.userNameLabel.textColor = [UIColor colorFromHexRGB:@"f8f8f8"];
        } else if ([ZCPControlingCenter sharedInstance].appTheme == DarkTheme) {
            self.userNameLabel.textColor = [UIColor colorFromHexRGB:@"dbdbdb"];
        }
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPUserImageCellItem *item = (ZCPUserImageCellItem *)object;
    return [item.cellHeight floatValue];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置frame
    self.bgImageView.frame = CGRectMake(0, 0, CELLWIDTH_DEFAULT, [self.item.cellHeight floatValue]);
    self.userHeadImageView.frame = CGRectMake(self.contentView.center.x - USER_HEAD_WIDTH / 2, self.contentView.center.y - USER_HEAD_HEIGHT / 2 - 15, USER_HEAD_WIDTH, USER_HEAD_HEIGHT);
    [self.userNameLabel sizeToFit];
    self.userNameLabel.frame = CGRectMake(self.contentView.center.x - self.userNameLabel.width / 2, self.contentView.height - UIMargin * 2 - USER_NAME_HEIGHT, self.userNameLabel.width, USER_NAME_HEIGHT);
    
    self.userNameBgView.frame = CGRectMake(self.userNameLabel.left - UIMargin, self.userNameLabel.top - UIMargin, self.userNameLabel.width + UIMargin * 2, USER_NAME_HEIGHT + UIMargin * 2);
    
    // 设置头像为圆形
    [self.userHeadImageView changeToRound];
}

@end

@implementation ZCPUserImageCellItem

#pragma mark - synthesize
@synthesize bgImageURL      = _bgImageURL;
@synthesize userHeadURL     = _userHeadURL;
@synthesize userName        = _userName;

#pragma mark - instancetype
- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [ZCPUserImageCell class];
        self.cellType = [ZCPUserImageCell cellIdentifier];
    }
    return self;
}
- (instancetype)initWithDefault {
    if (self = [super initWithDefault]) {
        self.cellClass = [ZCPUserImageCell class];
        self.cellType = [ZCPUserImageCell cellIdentifier];
        self.cellHeight = @200;
    }
    return self;
}

@end