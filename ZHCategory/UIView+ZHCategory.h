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

- (void)zh_setShadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius;

- (void)zh_addTagGestureWithActionBlock:(ZHViewTagGestureBlock)actionBlock;

@property (nonatomic,assign) CGFloat zh_width;
@property (nonatomic,assign) CGFloat zh_height;
@property (nonatomic,assign) CGFloat zh_x;
@property (nonatomic,assign) CGFloat zh_y;

@property (nonatomic,assign) CGFloat zh_center_x;
@property (nonatomic,assign) CGFloat zh_center_y;

@property (nonatomic,assign) CGSize zh_size;
@property (nonatomic,assign) CGPoint zh_origin;
@property (nonatomic,assign,readonly) CGFloat zh_widthHeightScale;

@end

NS_ASSUME_NONNULL_END
