//
//  UIColor+ZHCategory.m
//  AppDemo
//
//  Created by ZHL on 2023/4/10.
//

#import "UIColor+ZHCategory.h"

@implementation UIColor (ZHCategory)

- (NSString *)zh_hexStr{
    if (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)) != kCGColorSpaceModelRGB)
    {
        if ([self isEqual:[UIColor clearColor]]) {
            return @"0x000000FF";
        }
        else if ([self isEqual:[UIColor whiteColor]]){
            return @"0xFFFFFF";
        }else{
            return @"000000";
        }
        return [NSString stringWithFormat:@"0xFFFFFF"];
    }
    
    if (CGColorGetNumberOfComponents(self.CGColor) < 4)
    {
        NSLog(@"CGColorGetNumberOfComponents < 4");
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        CGFloat r = components[0];//红色
        CGFloat g = components[1];//绿色
        CGFloat b = components[2];//蓝色
        return [NSString stringWithFormat:@"0x%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255)];
        
    }
    
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    CGFloat a = components[3];
    if (a==1) {
        return [NSString stringWithFormat:@"0x%02lX%02lX%02lX",
                lroundf(r * 255),
                lroundf(g * 255),
                lroundf(b * 255)] ;
    }
    return [NSString stringWithFormat:@"0x%02lX%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255),
            lroundf(a * 255)];
}

+ (instancetype)zh_colorWithHexStr:(NSString *)hexStr{
    CGFloat r,g,b,a;
    if(hexStrToRGBA(hexStr, &r, &g, &b, &a)){
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
    }
    return nil;
}

static BOOL hexStrToRGBA(NSString *str,
                         CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a) {
    if([str containsString:@" "] || [str containsString:@"\n"]){
        return NO;
    }
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0X"] || [str hasPrefix:@"0x"]) {
        str = [str substringFromIndex:2];
    }
    
    NSUInteger length = [str length];
    //         RGB            RGBA          RRGGBB        RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return NO;
    }
    
    //RGB,RGBA,RRGGBB,RRGGBBAA
    if (length < 5) {
        *r = hexStrToInt([str substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        *g = hexStrToInt([str substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        *b = hexStrToInt([str substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
        if (length == 4)  *a = hexStrToInt([str substringWithRange:NSMakeRange(3, 1)]) / 255.0f;
        else *a = 1;
    } else {
        *r = hexStrToInt([str substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        *g = hexStrToInt([str substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        *b = hexStrToInt([str substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
        if (length == 8) *a = hexStrToInt([str substringWithRange:NSMakeRange(6, 2)]) / 255.0f;
        else *a = 1;
    }
    return YES;
}

static inline NSUInteger hexStrToInt(NSString *str) {
    uint32_t result = 0;
    sscanf([str UTF8String], "%X", &result);
    return result;
}


@end
