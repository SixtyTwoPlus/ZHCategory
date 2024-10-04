//
//  UIButton+ZHCategory.h
//  AppDemo
//
//  Created by 周海林 on 2023/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (ZHCategory)

- (void)zh_toucExpend:(CGFloat)size;

- (UIFont *)zh_font;

- (void)zh_setFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
