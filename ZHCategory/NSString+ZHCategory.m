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
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
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

- (NSInteger)zh_numberOfMixedChineseAndEnglishWords{
    NSInteger j = -1;//记录英文单词位置
    NSInteger calculationCount = 0;//总数
    NSInteger strCount = self.length;//字符串长
    for(NSInteger i = 0; i < strCount ; i++){
        
        NSInteger a = [self characterAtIndex:i];
        
        if((a >= 'a' && a <= 'z' ) || (a >= 'A' && a <= 'Z' )){//扫描到英文
            j = i;//记录英文的位置
            if((i == strCount - 1) && (j == i)){//最后一位并且当前是英文
                calculationCount ++;
                j = -1;
            }
        }else if( (a >= 32 && a <= 47) || (a >= 58 && a <= 64) || (a >= 91 && a <= 96) || (a >= 123 && a < 127)){
            if(j == i - 1){//前一位是否是英文
                calculationCount ++;
                j = -1;
            }
        }else {//非中英文
            if(j == i - 1){//前一位是否是英文
                calculationCount ++;
                j = -1;
            }
            calculationCount ++;
        }
    }
    return calculationCount;
}

- (NSArray *)zh_inlineWithView:(UITextView *)view opt:(NSDictionary *)dict{
    UIFont *font = dict[NSFontAttributeName];
    NSNumber *wordSpacing = dict[NSKernAttributeName];
    CGRect rect = view.frame;
    CTFontRef myFont = CTFontCreateWithName((CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self attributes:dict];
    CFRelease(myFont);
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = (NSArray *)CTFrameGetLines(frame);
    
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)wordSpacing);
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)wordSpacing);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [self substringWithRange:range];
        [linesArray addObject:lineString];
    }
    CGPathRelease(path);
    CFRelease(frame);
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}

- (NSInteger)zh_lineOfWithAttributed:(NSDictionary *)dict maxWidth:(CGFloat)maxWidth{
    CGFloat height = [self zh_sizeWithAttributes:dict maxWidth:maxWidth].height;
    NSMutableParagraphStyle *style = dict[NSParagraphStyleAttributeName];
    UIFont *font = dict[NSFontAttributeName];
    if(!font){
        return 0;
    }
    if(!style){
        return height / font.pointSize;
    }
    return height / (font.pointSize + style.lineSpacing);
}


+ (NSString *)zh_detectLanguageOfString:(NSString *)string {
    NSString *language;
    @try {
        NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:[NSLinguisticTagger availableTagSchemesForLanguage:@"en"] options:0];
        [tagger setString:string];
        language = [tagger dominantLanguage];
    } @catch (NSException *exception) {
        NSLog(@"Failed to detect language: %@", exception.reason);
    }
    return language;
}

@end
