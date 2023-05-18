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

static char dirArrKey;

- (NSArray *)dirArray{
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


- (CGFloat)zh_dirSizeWithName:(NSString *)name{
    NSString *fullPath = [DOCMENTPATH stringByAppendingPathComponent:name];
    NSArray *arr = [self subpathsAtPath:fullPath];
    CGFloat size = 0;
    for (NSString *fileName in arr) {
        NSString *subPath = [fullPath stringByAppendingPathComponent:fileName];
        NSDictionary *dict = [self attributesOfItemAtPath:subPath error:nil];
        CGFloat f = [dict[NSFileSize] floatValue] / 1024 / 1024;
        size += f;
    }
    return size;
}

- (BOOL)zh_copyItemAtPath:(NSString *)srcPath toDir:(NSString *)dirName{
    NSString *path = [[self zh_createDirWithName:dirName] stringByAppendingPathComponent:srcPath.lastPathComponent];
    return [self copyItemAtPath:srcPath toPath:path error:nil];
}

- (BOOL)zh_moveItemAtPath:(NSString *)srcPath toDir:(NSString *)dirName{
    NSString *path = [[self zh_createDirWithName:dirName] stringByAppendingPathComponent:srcPath.lastPathComponent];
    return [self moveItemAtPath:srcPath toPath:path error:nil];
}

@end
