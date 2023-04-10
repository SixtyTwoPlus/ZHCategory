//
//  UIButton+ZHCategory.h
//  AppDemo
//
//  Created by 周海林 on 2023/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (ZHCategory)

- (void)zh_addConfigurationWithLayout:(NSDirectionalRectEdge)edge margin:(CGFloat)margin;

- (void)zh_toucExpend:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
