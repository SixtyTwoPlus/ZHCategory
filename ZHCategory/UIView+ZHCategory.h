//
//  UIView+ZHCategory.h
//  AppDemo
//
//  Created by 周海林 on 2023/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ZHViewTagGestureBlock)(UITapGestureRecognizer *gesture);

@interface UIView (ZHCategory)

- (void)zh_setShadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity;

- (void)zh_addTagGestureWithActionBlock:(ZHViewTagGestureBlock)actionBlock;

- (CGFloat)zh_width;

- (CGFloat)zh_height;

- (CGFloat)zh_x;

- (CGFloat)zh_y;

- (CGSize)zh_size;

- (CGPoint)zh_origin;

- (CGFloat)zh_widthHeightScale;

@end

NS_ASSUME_NONNULL_END
