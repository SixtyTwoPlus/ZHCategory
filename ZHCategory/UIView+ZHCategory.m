//
//  UIView+ZHCategory.m
//  AppDemo
//
//  Created by ZHL on 2023/4/10.
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
    self.userInteractionEnabled = YES;
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

#pragma mark - frame , center

- (CGFloat)zh_width{
    return self.frame.size.width;
}

- (void)setZh_width:(CGFloat)zh_width{
    self.frame = CGRectMake(self.zh_x, self.zh_y, zh_width, self.zh_height);
}

- (CGFloat)zh_height{
    return self.frame.size.height;
}

- (void)setZh_height:(CGFloat)zh_height{
    self.frame = CGRectMake(self.zh_x, self.zh_y, self.zh_width, zh_height);
}

- (CGFloat)zh_x{
    return self.frame.origin.x;
}

- (void)setZh_x:(CGFloat)zh_x{
    self.frame = CGRectMake(zh_x, self.zh_y, self.zh_width, self.zh_height);
}

- (CGFloat)zh_y{
    return self.frame.origin.y;
}

- (void)setZh_y:(CGFloat)zh_y{
    self.frame = CGRectMake(self.zh_x, zh_y, self.zh_width, self.zh_height);
}

- (CGSize)zh_size{
    return self.frame.size;
}

- (void)setZh_size:(CGSize)zh_size{
    self.frame = CGRectMake(self.zh_x, self.zh_y, zh_size.width, zh_size.height);
}

- (CGPoint)zh_origin{
    return self.frame.origin;
}

- (void)setZh_origin:(CGPoint)zh_origin{
    self.frame = CGRectMake(zh_origin.x, zh_origin.y, self.zh_width, self.zh_height);
}

- (CGFloat)zh_widthHeightScale{
    return self.frame.size.width / self.frame.size.height;
}

- (CGFloat)zh_center_x{
    return self.center.x;
}

- (void)setZh_center_x:(CGFloat)zh_center_x{
    self.center = CGPointMake(zh_center_x, self.zh_center_y);
}

- (CGFloat)zh_center_y{
    return self.center.y;
}

- (void)setZh_center_y:(CGFloat)zh_center_y{
    self.center = CGPointMake(self.zh_center_x, zh_center_y);
}

@end
