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
#define USER_NAME_HEIGHT      50

@implementation ZCPUserImageCell

#pragma mark - synthesize
@synthesize bgImageView         = _bgImageView;
@synthesize userHeadImageView   = _userHeadImageView;
@synthesize userNameLabel       = _userNameLabel;
@synthesize item                = _item;

#pragma mark - Setup Cell
- (void)setupContentView {
    
    self.bgImageView = [[UIImageView alloc] init];
    self.userHeadImageView = [[UIImageView alloc] init];
    self.userNameLabel = [[UILabel alloc] init];
    self.userNameLabel.numberOfLines = 1;
    self.userNameLabel.textAlignment = NSTextAlignmentCenter;
    self.userNameLabel.font = [UIFont defaultBoldFontWithSize:20.0f];
    
    self.bgImageView.backgroundColor = [UIColor clearColor];
    self.userHeadImageView.backgroundColor = [UIColor clearColor];
    self.userNameLabel.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.bgImageView];
    [self.contentView addSubview:self.userHeadImageView];
    [self.contentView addSubview:self.userNameLabel];
}
- (void)setObject:(NSObject *)object {
    if ([object isKindOfClass:[ZCPUserImageCellItem class]] && self.item != object) {
        
        self.item = (ZCPUserImageCellItem *)object;
        
        // 设置frame
        self.bgImageView.frame = CGRectMake(0, 0, CELLWIDTH_DEFAULT, [self.item.cellHeight floatValue]);
        self.userHeadImageView.frame = CGRectMake((CELLWIDTH_DEFAULT - USER_HEAD_WIDTH)/2, self.bgImageView.frame.size.height - USER_HEAD_HEIGHT - USER_NAME_HEIGHT, USER_HEAD_WIDTH, USER_HEAD_HEIGHT);
        self.userNameLabel.frame = CGRectMake(0, self.userHeadImageView.bottom, APPLICATIONWIDTH, USER_NAME_HEIGHT);
        
        // 设置属性
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
            
            // 毛玻璃
            [self.bgImageView setImage:loadImage];
            UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
            effectview.frame = CGRectMake(0, 0, self.bgImageView.width, self.bgImageView.height);
            [self.bgImageView addSubview:effectview];
            
            // 第三方
        }];
        
        self.userNameLabel.text = self.item.userName;
    }
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    ZCPUserImageCellItem *item = (ZCPUserImageCellItem *)object;
    return [item.cellHeight floatValue];
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