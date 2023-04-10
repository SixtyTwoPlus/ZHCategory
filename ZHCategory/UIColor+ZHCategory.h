//
//  UIColor+ZHCategory.h
//  AppDemo
//
//  Created by 周海林 on 2023/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ZHCategory)

- (NSString *)zh_hexStr;

+ (instancetype)zh_colorWithHexStr:(NSString *)hexStr;

@end

NS_ASSUME_NONNULL_END
