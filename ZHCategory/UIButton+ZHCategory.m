//
//  UIButton+ZHCategory.m
//  AppDemo
//
//  Created by 周海林 on 2023/4/10.
//

#import "UIButton+ZHCategory.h"
#import <objc/runtime.h>

@implementation UIButton (ZHCategory)
- (void)zh_addConfigurationWithLayout:(NSDirectionalRectEdge)edge margin:(CGFloat)margin{
    UIButtonConfiguration *config = [UIButtonConfiguration plainButtonConfiguration];
    config.imagePlacement = edge;
    config.imagePadding = margin;
    config.baseBackgroundColor = [UIColor clearColor];
    config.image = self.imageView.image;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:self.titleLabel.text];
    NSRange range = NSMakeRange(0, self.titleLabel.text.length);
    [str addAttribute:NSFontAttributeName value:self.titleLabel.font range:range];
    [str addAttribute:NSForegroundColorAttributeName value:self.titleLabel.textColor range:range];
    config.attributedTitle = str;
    [self setConfiguration:config];
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
