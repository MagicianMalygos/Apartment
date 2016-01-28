//
//  UILabel+Icon.m
//  haofang
//
//  Created by DengJinlong on 4/8/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)

+ (id)labelWithIndicator
{
    UILabel *indicator = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    indicator.font = [UIFont fontWithName:@"iconfont" size: 18];
//    indicator.text = PAICONFONT_E61F;
    indicator.textColor = [UIColor colorFromHexRGB:@"c7c7cc"];
    indicator.backgroundColor = [UIColor clearColor];
    return indicator;
}

//6.0及其以上系统调用 自定义行间距过大需要重新调整label高度
- (void)setLineSpace:(CGFloat)height{
    if (SYSTEM_VERSION < 6.0) {
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:height];//调整行间距
    
    NSMutableAttributedString *attributedString = nil;
    if (self.attributedText!=nil) {
        attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
        self.attributedText = attributedString;
        [self sizeToFit];
        return;
    }
//    if (self.text.trim.length>0) {
//        attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
//        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
//        self.attributedText = attributedString;
//        [self sizeToFit];
//    }
    
}

- (void)sizeToFitWithEdge:(UIEdgeInsets)edgeInsets
{
    [self sizeToFit];
    self.width = self.width + edgeInsets.right + edgeInsets.left;
    self.height = self.height + edgeInsets.top + edgeInsets.bottom;
}

@end
