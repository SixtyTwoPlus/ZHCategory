//
//  UIImage+ZHCategory.m
//  AppDemo
//
//  Created by ZHL on 2023/4/10.
//

#import "UIImage+ZHCategory.h"

#define kDefaultWidth 200
#define kDefaultHeight 200

@implementation UIImage (ZHCategory)

+ (instancetype)zh_imageFromColor:(UIColor *)color{
    return [self zh_imageFromColor:color size:CGSizeMake(1, 1)];
}

+ (instancetype)zh_imageFromColor:(UIColor *)color size:(CGSize)size{
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();//释放上下文
    return theImage;
}

+ (instancetype)zh_imageCircle:(UIColor *)color radius:(CGFloat)radius{
    UIGraphicsBeginImageContext(CGSizeMake(radius * 2, radius * 2));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextAddArc(context, radius, radius, radius, 0, 2 * M_PI, 1);
    CGContextDrawPath(context, kCGPathFill);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();//释放上下文
    return theImage;
}

+ (instancetype)zh_mergeImageWithTopImage:(UIImage *)topImage bottomImage:(UIImage *)bottomImg rect:(CGRect)rect{
    CGFloat w = topImage.size.width;
    CGFloat h = topImage.size.height;
    //底图
    CGFloat w1 = bottomImg.size.width;
    CGFloat h1 = bottomImg.size.height;
    //以底图大小为画布创建上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(w1, h1), NO, [[UIScreen mainScreen] scale]);
    [bottomImg drawInRect:CGRectMake(0, 0, w1, h1)];//先把1.png 画到上下文中
    if(rect.size.width != 0 && rect.size.height != 0){
        [topImage drawInRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];//再把小图放在上下文中
    }else{
        [topImage drawInRect:CGRectMake(rect.origin.x, rect.origin.y, w, h)];//再把小图放在上下文中
    }
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();//从当前上下文中获得最终图片
    UIGraphicsEndImageContext();//关闭上下文
    return resultImg;
}

- (instancetype)zh_rotateImagWithDegress:(CGFloat)degrees {
    // 将UIImage转换为CIImage
    CIImage* inputImage = [CIImage imageWithCGImage:self.CGImage];
    // 创建一个CIAffineTransform滤镜
    CIFilter* filter = [CIFilter filterWithName:@"CIAffineTransform"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    // 计算弧度值
    CGFloat radians = degrees * M_PI / 180.0;
    // 创建旋转变换矩阵
    CGAffineTransform transform = CGAffineTransformMakeRotation(radians);
    [filter setValue:[NSValue valueWithCGAffineTransform:transform] forKey:kCIInputTransformKey];
    // 应用滤镜
    CIImage* outputImage = filter.outputImage;
    // 创建上下文
    CIContext* context = [CIContext contextWithOptions:nil];
    // 将CIImage转换回UIImage
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:outputImage.extent];
    UIImage* rotatedImage = [UIImage imageWithCGImage:cgImage scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(cgImage);
    return rotatedImage;
}

- (instancetype)zh_scaleToSize:(CGSize)newSize{
    CGFloat scaleX = newSize.width / self.size.width;
    CGFloat scaleY = newSize.height / self.size.height;
    CIImage *ciimage = [[CIImage alloc]initWithCGImage:self.CGImage];
    CIImage *scaledImage = [ciimage imageByApplyingTransform:CGAffineTransformMakeScale(scaleX, scaleY) highQualityDownsample:YES];
    CGImageRef cgimageRef = [[CIContext new] createCGImage:scaledImage fromRect:scaledImage.extent];
    UIImage *resultImage = [UIImage imageWithCGImage:cgimageRef];
    CGImageRelease(cgimageRef);
    return resultImage;
}

- (instancetype)zh_sizeScaleWith:(CGFloat)wh scaleType:(ZHScaleSizeType)type{
    CGSize imgSize = self.size;
    CGFloat imgProportion = imgSize.width/imgSize.height;
    CGSize size = CGSizeMake(wh, wh/imgProportion);
    if(type == ZHScaleSizeTypeHeight){
        size = CGSizeMake(wh * imgProportion, wh);
    }
    return [self zh_scaleToSize:size];
}

- (instancetype)zh_cropImageWith:(CGRect)rect {
    // 将UIImage转换为CIImage
    CIImage* inputImage = [CIImage imageWithCGImage:self.CGImage];
    if (!inputImage) {
        return self;
    }
    
    // 计算缩放因子并转换坐标系
    CGFloat scale = inputImage.extent.size.width / self.size.width;
    CGRect ciRect = CGRectMake(rect.origin.x * scale,
                               inputImage.extent.size.height - rect.origin.y * scale - rect.size.height * scale,
                               rect.size.width * scale,
                               rect.size.height * scale);
                               
    // 裁剪图像
    CIImage *cropedImg = [inputImage imageByCroppingToRect:ciRect];
    
    // 将CIImage转换为UIImage
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:cropedImg fromRect:[cropedImg extent]];
    
    UIImage *result = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return result;
}

+ (UIImage *)zh_gradientImage:(NSArray <UIColor *> *)colors directionType:(ZHGradientDirection)directionType{
    return [self zh_gradientImage:colors directionType:directionType option:CGSizeMake(kDefaultWidth, kDefaultHeight)];
}

+ (UIImage *)zh_gradientImage:(NSArray <UIColor *> *)colors directionType:(ZHGradientDirection)directionType option:(CGSize)size
{
    NSMutableArray *cgcolors = [NSMutableArray array];
    NSMutableArray *locations = [NSMutableArray array];
    
    for (NSInteger i = 0; i < colors.count; i++) {
        [cgcolors addObject:((__bridge id)colors[i].CGColor)];
        
        CGFloat locationValue = (CGFloat)i / (colors.count - 1);
        [locations addObject:@(locationValue)];
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = cgcolors;
    gradientLayer.locations = locations;
    
    if (directionType == ZHGradientDirectionHorizontal) {
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
    }else if (directionType == ZHGradientDirectionVertical){
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
    }else if (directionType == ZHGradientDirectionLeftStart){
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 1);
    }else if (directionType == ZHGradientDirectionRightStart){
        gradientLayer.startPoint = CGPointMake(0, 1);
        gradientLayer.endPoint = CGPointMake(1, 0);
    }
    
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, NO, 0);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return gradientImage;
}

@end


@implementation UIColor (GradientColor)

+ (UIColor *)zh_colorWithColors:(NSArray<UIColor *> *)colors directionType:(ZHGradientDirection)directionType{
    UIImage *image = [UIImage zh_gradientImage:colors directionType:directionType];
    return [self colorWithPatternImage:image];
}

+ (UIColor *)zh_colorWithColors:(NSArray<UIColor *> *)colors directionType:(ZHGradientDirection)directionType option:(CGSize)size{
    UIImage *image = [UIImage zh_gradientImage:colors directionType:directionType option:size];
    return [self colorWithPatternImage:image];
}

@end
