//
//  UIButton+ZHCategory.m
//  AppDemo
//
//  Created by 周海林 on 2023/4/10.
//

#import "UIButton+ZHCategory.h"
#import "NSString+ZHCategory.h"
#import "UIView+ZHCategory.h"
#import <objc/runtime.h>

@implementation UIButton (ZHCategory)

- (void)zh_addConfigurationWithLayout:(NSDirectionalRectEdge)edge margin:(CGFloat)margin{
    UIButtonConfiguration *config = [UIButtonConfiguration plainButtonConfiguration];
    config.imagePlacement = edge;
    config.imagePadding = margin;
    config.baseBackgroundColor = [UIColor clearColor];
    config.image = [self imageForState:self.state];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[self titleForState:self.state]];
    NSRange range = NSMakeRange(0, self.titleLabel.text.length);
    [str addAttribute:NSFontAttributeName value:self.titleLabel.font range:range];
    [str addAttribute:NSForegroundColorAttributeName value:self.titleLabel.textColor range:range];
    config.attributedTitle = str;
    [self setConfiguration:config];
}

- (void)zh_layoutWithType:(ZHButtonLayoutType)type margin:(CGFloat)margin{
    CGSize imgSize = [self imageForState:self.state].size;
    CGSize titleSize = [[self titleForState:self.state] zh_sizeWithFont:self.titleLabel.font];
    [self layoutIfNeeded];
    switch (type) {
        case ZHButtonLayoutTypeImgTop:{
            CGFloat halfMargin = margin/2;
            CGFloat imgTop = -(titleSize.height/2 + halfMargin);
            CGFloat imgLeft = titleSize.width/2;
            CGFloat titleTop = imgSize.height/2 + halfMargin;
            CGFloat titleLeft = -imgSize.width/2;
            self.imageEdgeInsets = UIEdgeInsetsMake(imgTop, imgLeft, -imgTop, -imgLeft);
            self.titleEdgeInsets = UIEdgeInsetsMake(titleTop, titleLeft + margin/2, -titleTop, -titleLeft);
        }
            break;
        case ZHButtonLayoutTypeImgLeft:{
            CGFloat spacing = margin/2; // 定义图片和标题之间的间距
               self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing, 0, spacing);
               self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, -spacing);
        }
            break;
        case ZHButtonLayoutTypeImgRight:{
            CGFloat imgLeft = titleSize.width + margin;
            CGFloat titleLeft = -imgSize.width - margin;
            self.imageEdgeInsets = UIEdgeInsetsMake(0, imgLeft, 0, -imgLeft);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, titleLeft, 0, -titleLeft);
        }
            break;
        case ZHButtonLayoutTypeImgBottom:{
            CGFloat halfMargin = margin / 2;
            CGFloat imgTop = titleSize.height/2 + halfMargin;
            CGFloat imgLeft = titleSize.width/2;
            CGFloat titleTop = -(imgSize.height/2 + halfMargin);
            CGFloat titleLeft = -imgSize.width/2;
            self.imageEdgeInsets = UIEdgeInsetsMake(imgTop, imgLeft, -imgTop, -imgLeft);
            self.titleEdgeInsets = UIEdgeInsetsMake(titleTop, titleLeft, -titleTop, -titleLeft);
        }
            break;
        default:
            break;
    }
}


- (UIFont *)zh_font{
    return self.titleLabel.font;
}

- (void)setZh_font:(UIFont *)font{
    self.titleLabel.font = font;
}

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;


- (void)zh_toucExpend:(CGFloat)size{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect
{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge)
    {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else
    {
        return self.bounds;
    }
}

- (UIView*)hitTest:(CGPoint) point withEvent:(UIEvent*) event
{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds))
    {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}
@end
