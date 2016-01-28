//
//  UIColor+Category.m
//  haofang
//
//  Created by PengFeiMeng on 3/26/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

+ (UIColor *)PADefaultBackgroundColor  {
     return [UIColor colorFromHexRGB:@"ececec"];
}

+ (UIColor *)PAGrayColor
{
    return [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
}

+ (UIColor *)PALightGrayColor
{
    return [UIColor colorFromHexRGB:@"dddddd"];
}

+ (UIColor *)PAOrangeColor
{
    return UIColorFromRGB(0xff9434);
}

+ (UIColor *)PABtnBgOrangeColor
{
    return UIColorFromRGB(0xff7800);
}

+ (UIColor *)PAOrangeHighlightColor
{
    return UIColorFromRGB(0xf78e6f);
}

+ (UIColor *)PAGreenColor
{
    return UIColorFromRGB(0x2eaf01);
}

+ (UIColor *)PAGreenHighlightColor{
    return UIColorFromRGB(0x5da03c);
}

+ (UIColor *)PABlackTextColor
{
    return [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
}

+ (UIColor *)PADimColor
{
    return [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
}

+ (UIColor *)PABlueColor
{
    return [UIColor colorFromHexRGB:@"1c71b9"];
}

+ (UIColor *)PARateGreenColor
{
    return [UIColor colorFromHexRGB:@"339900"];
}

+ (UIColor *)PANavigationBarBgColor{
    return [UIColor colorFromHexRGB:@"5a8ae2"];
}

+ (UIColor *)PAToolBarBgColor{
    return [UIColor colorFromHexRGB:@"fc8d2a"];
}

+ (UIColor *)PAYouHuiColor{
    return [UIColor colorFromHexRGB:@"ff5a75"];
}

+ (UIColor *)PAHFLoanColor{
    return [UIColor colorFromHexRGB:@"64b7ff"];
}

+ (UIColor *)PAPriceColor{
    return [UIColor colorFromHexRGB:@"fa5728"];
}

+ (UIColor *)PAPriceUnitColor{
    return [UIColor colorFromHexRGB:@"818181"];
}

+ (UIColor *)PATitleColor{
    return [UIColor colorFromHexRGB:@"494949"];
}

+ (UIColor *)PASubTitleColor{
    return [UIColor colorFromHexRGB:@"818181"];
}

/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    NSString *cString = [[inColorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
//    UIColor *result = nil;
//    unsigned int colorCode = 0;
//    unsigned char redByte, greenByte, blueByte;
//    
//    if (nil != inColorString)
//    {
//        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
//        (void) [scanner scanHexInt:&colorCode]; // ignore error
//    }
//    redByte = (unsigned char) (colorCode >> 16);
//    greenByte = (unsigned char) (colorCode >> 8);
//    blueByte = (unsigned char) (colorCode); // masks off high bits
//    result = [UIColor
//              colorWithRed: (float)redByte / 0xff
//              green: (float)greenByte/ 0xff
//              blue: (float)blueByte / 0xff
//              alpha:1.0];
//    return result;
}

+ (UIColor *)colorFromHex:(UInt32)color
{
    UIColor *result = nil;
    UInt8 alphaByte, redByte, greenByte, blueByte;
    
    alphaByte = ( color & 0xFF000000 ) >> 24;
    redByte = ( color & 0x00FF0000 ) >> 16;
    greenByte = ( color & 0x0000FF00 ) >> 8;
    blueByte = ( color & 0x000000FF );
    
    result = [UIColor colorWithRed:redByte/255.0 green:greenByte/255.0 blue:blueByte/255.0 alpha:alphaByte/255.0];
    return result;
}

+ (UIColor*) colorRGBonvertToHSB:(UIColor*)color withBrighnessDelta:(CGFloat)delta {
    CGFloat hue = 0.0f;
    CGFloat saturation = 0.0f;
    CGFloat brightness = 0.0f;
    CGFloat alpha = 0.0f;
    
    [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    brightness += delta;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}

+ (UIColor *)PACalRedColor
{
    return [UIColor colorWithRed:248.0f/255.0f green:80.0f/255.0f blue:32.0f/255.0f alpha:1.0f];
}

+ (UIColor *)PACalYellowColor
{
    return [UIColor colorWithRed:247.0f/255.0f green:192.0f/255.0f blue:1.0f/255.0f alpha:1.0f];
}

+ (UIColor *)PACalGreenColor
{
    return [UIColor colorWithRed:85.0f/255.0f green:177.0f/255.0f blue:53.0f/255.0f alpha:1.0f];
}

@end
