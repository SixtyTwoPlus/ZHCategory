//
//  NSFileManager+ZHCategory.h
//  ZHCategoryExample
//
//  Created by 周海林 on 2023/5/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (ZHCategory)

- (NSArray *)dirArray;

- (BOOL)zh_copyItemAtPath:(NSString *)srcPath toDir:(NSString *)dirName;

- (BOOL)zh_moveItemAtPath:(NSString *)srcPath toDir:(NSString *)dirName;

- (CGFloat)zh_dirSizeWithName:(NSString *)name;

- (BOOL)zh_removeDirWithName:(NSString *)name;

- (NSString *)zh_createDirWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
