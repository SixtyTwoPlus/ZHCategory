//
//  NSDate+ZHFormatter.h
//  ZHCategoryExample
//
//  Created by ZHL on 2025/8/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (ZHFormatter)

- (NSString *)prettyString;

- (NSString *)stringWithFormat:(NSString *)format;

- (NSString *)stringWithFormat:(NSString *)format locale:(NSString * _Nullable)localeID;

@end

NS_ASSUME_NONNULL_END
