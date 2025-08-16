//
//  UIView+ZHCategory.h
//  AppDemo
//
//  Created by ZHL on 2023/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ZHViewTagGestureBlock)(UITapGestureRecognizer *gesture);

@interface UIView (ZHCategory)

- (void)zh_setShadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity;

- (void)zh_setShadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius;

- (void)zh_addTagGestureWithActionBlock:(ZHViewTagGestureBlock)actionBlock;

- (CGFloat)zh_width;

- (void)setZh_width:(CGFloat)zh_width;

- (CGFloat)zh_height;

- (void)setZh_height:(CGFloat)zh_height;

- (CGFloat)zh_x;

- (void)setZh_x:(CGFloat)zh_x;

- (CGFloat)zh_y;

- (void)setZh_y:(CGFloat)zh_y;

- (CGSize)zh_size;

- (void)setZh_size:(CGSize)zh_size;

- (CGPoint)zh_origin;

- (void)setZh_origin:(CGPoint)zh_origin;

- (CGFloat)zh_widthHeightScale;

- (CGFloat)zh_center_x;

- (void)setZh_center_x:(CGFloat)zh_center_x;

- (CGFloat)zh_center_y;

- (void)setZh_center_y:(CGFloat)zh_center_y;

@end

NS_ASSUME_NONNULL_END
