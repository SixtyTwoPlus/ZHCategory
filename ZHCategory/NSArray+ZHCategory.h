//
//  NSArray+ZHCategory.h
//  ZHCategoryExample
//
//  Created by 周海林 on 2023/6/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray <ObjectType> (ZHCategory)

- (ObjectType)zh_objectWithKey:(NSString * _Nullable)key value:(id)value;

- (NSArray <ObjectType> *)zh_objectsWithKey:(NSString * _Nullable)key value:(id)value;

@end

NS_ASSUME_NONNULL_END
