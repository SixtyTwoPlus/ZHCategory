//
//  NSArray+ZHCategory.m
//  ZHCategoryExample
//
//  Created by 周海林 on 2023/6/21.
//

#import "NSArray+ZHCategory.h"
#import "NSString+ZHCategory.h"

@implementation NSArray (ZHCategory)

- (id)zh_objectWithKey:(NSString *)key value:(id)value{
    NSArray *arr = [self zh_objectsWithKey:key value:value];
    if(!arr){
        return nil;
    }
    return arr.firstObject;
}

- (NSArray *)zh_objectsWithKey:(NSString *)key value:(id)value{
    __weak typeof(self) weakSelf = self;
    if([NSString zh_isNull:key] || [self.firstObject isKindOfClass:NSString.class] || [self.firstObject isKindOfClass:NSNumber.class]){
        NSMutableArray *arr = [NSMutableArray array];
        for (id obj in self) {
            if([obj isEqual:value]){
                [arr addObject:obj];
            }
        }
        return arr;
    }
    NSDictionary *dict = [self convertObjectToDicionary:self.firstObject];
    if(!dict){
        return nil;
    }
    BOOL container = [dict.allKeys containsObject:key];
    if(!container){
        return nil;
    }
    NSMutableArray *mutableArr = [NSMutableArray array];
    for (id obj in self) {
        NSDictionary *itemDict = [weakSelf convertObjectToDicionary:obj];
        if([itemDict[key] isEqual:value]){
            [mutableArr addObject:obj];
        }
    }
    return mutableArr;
}

- (NSDictionary *)convertObjectToDicionary:(id)obj{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        return nil;
    }
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error || ![dictionary isKindOfClass:NSDictionary.class]){
        return nil;
    }
    return dictionary;
}

@end
