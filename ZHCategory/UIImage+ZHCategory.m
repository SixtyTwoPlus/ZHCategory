//
//  UIImage+ZHCategory.m
//  AppDemo
//
//  Created by 周海林 on 2023/4/10.
//

#import "UIImage+ZHCategory.h"

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

+ (instancetype)zh_imageCircle:(UIColor *)color radius:(NSInteger)radius{
    CGSize size = CGSizeMake(radius + 10, radius + 10);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextAddArc(context, size.width/2, size.height/2, radius, 0, 2 * M_PI, 1);
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
    UIGraphicsBeginImageContextWithOptions(newSize, NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();//释放上下文
    return newImage;
}

- (CGSize)zh_sizeScaleWith:(CGFloat)wh scaleType:(ZHScaleSizeType)type{
    CGSize imgSize = self.size;
    CGFloat imgProportion = imgSize.width/imgSize.height;
    CGSize size = CGSizeMake(wh, wh/imgProportion);
    if(type == ZHScaleSizeTypeHeight){
        size = CGSizeMake(wh * imgProportion, wh);
    }
    return size;
}

@end
