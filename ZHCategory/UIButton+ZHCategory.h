//
//  UIButton+ZHCategory.h
//  AppDemo
//
//  Created by 周海林 on 2023/4/10.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ZHButtonLayoutType){
    ZHButtonLayoutTypeImgTop,
    ZHButtonLayoutTypeImgLeft,
    ZHButtonLayoutTypeImgRight,
    ZHButtonLayoutTypeImgBottom,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (ZHCategory)

- (void)zh_addConfigurationWithLayout:(NSDirectionalRectEdge)edge margin:(CGFloat)margin;

- (void)zh_toucExpend:(CGFloat)size;

- (void)zh_layoutWithType:(ZHButtonLayoutType)type margin:(CGFloat)margin;

@end

NS_ASSUME_NONNULL_END
