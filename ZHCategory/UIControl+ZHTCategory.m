//
//  UIControl+ZHTCategory.m
//  AppDemo
//
//  Created by ZHL on 2023/4/10.
//

#import "UIControl+ZHTCategory.h"
#import <objc/runtime.h>

static ZHControlActionBlock actionBlock;

@implementation UIControl (ZHTCategory)

- (void)zh_addBlock:(ZHControlActionBlock)block withControlEvents:(UIControlEvents)events{
    [self addTarget:self action:@selector(controllAction:) forControlEvents:events];
    objc_setAssociatedObject(self, &actionBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)controllAction:(UIControl *)sender{
    [self getActionBlock](sender);
}

- (ZHControlActionBlock)getActionBlock{
    return objc_getAssociatedObject(self, &actionBlock);
}

@end
