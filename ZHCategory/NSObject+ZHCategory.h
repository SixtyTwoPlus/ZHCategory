//
//  NSObject+ZHCategory.h
//  ZHCategoryExample
//
//  Created by ZHL on 2023/7/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ZHCategory)

+ (NSArray *)zh_getAllMethods;

+ (NSArray *)zh_getAllProperties;

@end

NS_ASSUME_NONNULL_END
