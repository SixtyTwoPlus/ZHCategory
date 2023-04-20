//
//  UIView+ZHCategory.m
//  AppDemo
//
//  Created by 周海林 on 2023/4/10.
//

#import "UIView+ZHCategory.h"
#import <objc/runtime.h>

@implementation UIView (ZHCategory)


- (void)zh_setShadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity{
    if(self.layer.masksToBounds){
        self.layer.masksToBounds = NO;
    }
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = self.layer.cornerRadius;
}

- (void)zh_setShadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius{
    if(self.layer.masksToBounds){
        self.layer.masksToBounds = NO;
    }
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
}

static ZHViewTagGestureBlock block;

- (void)zh_addTagGestureWithActionBlock:(ZHViewTagGestureBlock)actionBlock{
    objc_setAssociatedObject(self, &block, actionBlock, OBJC_ASSOCIATION_COPY);
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapgestureAction:)];
    [ges setNumberOfTapsRequired:1];
    [self addGestureRecognizer:ges];
}

- (void)tapgestureAction:(UITapGestureRecognizer *)ges{
    ZHViewTagGestureBlock actionBlock = [self getBlock];
    if(actionBlock){
        actionBlock(ges);
    }
}

- (ZHViewTagGestureBlock)getBlock{
    return objc_getAssociatedObject(self, &block);
}

- (CGFloat)zh_width{
    return self.frame.size.width;
}

- (CGFloat)zh_height{
    return self.frame.size.height;
}

- (CGFloat)zh_x{
    return self.frame.origin.x;
}

- (CGFloat)zh_y{
    return self.frame.origin.y;
}

- (CGSize)zh_size{
    return self.frame.size;
}

- (CGPoint)zh_origin{
    return self.frame.origin;
}

- (CGFloat)zh_widthHeightScale{
    return self.frame.size.width / self.frame.size.height;
}

@end
