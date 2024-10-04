//
//  NSFileManager+ZHCategory.h
//  ZHCategoryExample
//
//  Created by 周海林 on 2023/5/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (ZHCategory)

- (NSArray *)zh_documentFiles;

- (NSString *)zh_createDirWithName:(NSString *)name;

- (BOOL)zh_removeDirWithName:(NSString *)name;

- (CGFloat)zh_dirSizeWithPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
