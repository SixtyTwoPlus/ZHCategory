//
//  NSFileManager+ZHCategory.m
//  ZHCategoryExample
//
//  Created by 周海林 on 2023/5/18.
//

#import "NSFileManager+ZHCategory.h"
#import <objc/runtime.h>

#define DOCMENTPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject]

@implementation NSFileManager (ZHCategory)

- (NSArray *)zh_documentFiles{
    return [self subpathsAtPath:DOCMENTPATH];
}

- (NSString *)zh_createDirWithName:(NSString *)name{
    NSString *fullPath = [DOCMENTPATH stringByAppendingPathComponent:name];
    if(![self fileExistsAtPath:fullPath]){
        [self createDirectoryAtPath:fullPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return fullPath;
}

- (BOOL)zh_removeDirWithName:(NSString *)name{
    NSString *fullPath = [self zh_createDirWithName:name];
    return [self removeItemAtPath:fullPath error:nil];
}

- (CGFloat)zh_dirSizeWithPath:(NSString *)path{
    NSDictionary *dict = [self attributesOfItemAtPath:path error:nil];
    CGFloat size = [dict[NSFileSize] floatValue] / 1024 / 1024;
    return size;
}

@end
