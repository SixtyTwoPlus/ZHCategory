//
//  NSString+ZHCategory.m
//  AppDemo
//
//  Created by 周海林 on 2023/4/10.
//

#import "NSString+ZHCategory.h"
#import <CommonCrypto/CommonDigest.h>
#import <CoreText/CoreText.h>

@implementation NSString (ZHCategory)

+ (BOOL)zh_isNull:(NSString *)str{
    if (str == nil || [str isEqual:[NSNull null]] || str.length == 0 || str == NULL) {
        return YES;
    }else {
        return NO;
    }
}

- (NSString *)zh_md5String {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH] = {0};
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
#pragma clang diagnostic pop
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for (int i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X", result[i]];
    }
    return ret;
}

- (CGFloat)zh_fontPointSizeWithFrame:(CGSize)frameSize font:(UIFont *)font{
    if([NSString zh_isNull:self] || CGSizeEqualToSize(frameSize, CGSizeZero)){
        return 0;
    }
    CGFloat minFontSize = 1.0;
    CGFloat maxFontSize = 200.0;
    CGFloat fontSize = 0.0;
    CGSize textSize;
    UIFont *currentFont;
    while (minFontSize <= maxFontSize) {
        fontSize = (minFontSize + maxFontSize) / 2.0;
        currentFont = [font fontWithSize:fontSize];
        textSize = [self zh_sizeWithFont:currentFont];
        if (textSize.width < frameSize.width && textSize.height < frameSize.height) {
            minFontSize = fontSize + 0.5;
        } else if (textSize.width > frameSize.width || textSize.height > frameSize.height) {
            maxFontSize = fontSize - 0.5;
        } else {
            break;
        }
    }
    return fontSize;
}

- (CGSize)zh_sizeWithFont:(UIFont *)font{
    NSDictionary *attrs = @{NSFontAttributeName:font};
    CGSize width = [self boundingRectWithSize:CGSizeZero options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return width;
}

- (CGSize)zh_sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth{
    CGSize size = CGSizeMake(maxWidth, CGFLOAT_MAX);
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    
    CGRect rect = [self boundingRectWithSize:size
                                     options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:NULL];
    CGSize resultSize = CGSizeMake(rect.size.width, rect.size.height);
    return resultSize;
}

- (CGSize)zh_sizeWithAttributes:(NSDictionary *)dict maxWidth:(CGFloat)maxWidth{
    CGSize size = CGSizeMake(maxWidth, CGFLOAT_MAX);
    CGRect rect = [self boundingRectWithSize:size
                                     options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                                  attributes:dict
                                     context:NULL];
    CGSize resultSize = CGSizeMake(rect.size.width, rect.size.height);
    return resultSize;
}

@end
