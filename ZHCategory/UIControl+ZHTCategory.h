//
//  UIControl+ZHTCategory.h
//  AppDemo
//
//  Created by ZHL on 2023/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ZHControlActionBlock)(UIControl *control);

@interface UIControl (ZHTCategory)

- (void)zh_addBlock:(ZHControlActionBlock)block withControlEvents:(UIControlEvents)events;

@end

NS_ASSUME_NONNULL_END
