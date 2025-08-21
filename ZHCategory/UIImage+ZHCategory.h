//
//  UIImage+ZHCategory.h
//  AppDemo
//
//  Created by ZHL on 2023/4/10.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ZHScaleSizeType){
    ZHScaleSizeTypeWidth,
    ZHScaleSizeTypeHeight,
};

// A ----- B
// |       |
// C ----- D

typedef NS_ENUM(NSInteger,ZHGradientDirection){
    ZHGradientDirectionVertical,  //AB - CD
    ZHGradientDirectionHorizontal, // AC - BD
    ZHGradientDirectionLeftStart, // A - D
    ZHGradientDirectionRightStart, // B - D
};

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZHCategory)

+ (instancetype)zh_imageFromColor:(UIColor *)color;

+ (instancetype)zh_imageFromColor:(UIColor *)color size:(CGSize)size;

+ (instancetype)zh_imageCircle:(UIColor *)color radius:(CGFloat)radius;

+ (instancetype)zh_mergeImageWithTopImage:(UIImage *)topImage bottomImage:(UIImage *)bottomImg rect:(CGRect)rect;

- (instancetype)zh_rotateImagWithDegress:(CGFloat)degrees;

- (instancetype)zh_scaleToSize:(CGSize)newSize;

- (instancetype)zh_sizeScaleWith:(CGFloat)wh scaleType:(ZHScaleSizeType)type;

- (instancetype)zh_cropImageWith:(CGRect)rect;

+ (UIImage *)zh_gradientImage:(NSArray <UIColor *> *)colors directionType:(ZHGradientDirection)directionType;

+ (UIImage *)zh_gradientImage:(NSArray <UIColor *> *)colors directionType:(ZHGradientDirection)directionType option:(CGSize)size;

@end

@interface UIColor(GradientColor)

+ (UIColor *)zh_colorWithColors:(NSArray <UIColor *> *)colors directionType:(ZHGradientDirection)directionType;

+ (UIColor *)zh_colorWithColors:(NSArray <UIColor *> *)colors directionType:(ZHGradientDirection)directionType option:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
