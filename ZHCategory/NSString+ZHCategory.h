//
//  NSString+ZHCategory.h
//  AppDemo
//
//  Created by 周海林 on 2023/4/10.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZHCategory)

+ (BOOL)zh_isNull:(NSString *)str;

- (NSString *)zh_md5String;

- (CGSize)zh_sizeWithFont:(UIFont *)font;

- (CGSize)zh_sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

- (CGSize)zh_sizeWithAttributes:(NSDictionary *)dict maxWidth:(CGFloat)maxWidth;

- (NSInteger)zh_numberOfMixedChineseAndEnglishWords;

- (CGFloat)zh_fontPointSizeWithFrame:(CGSize)frameSize font:(UIFont *)font;

- (NSArray *)zh_inlineWithView:(UITextView *)view opt:(NSDictionary *)dict;

- (NSInteger)zh_lineOfWithAttributed:(NSDictionary *)dict maxWidth:(CGFloat)maxWidth;

+ (NSString *)zh_detectLanguageOfString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
