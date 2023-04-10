//
//  UIApplication+ZHCategory.m
//  AppDemo
//
//  Created by 周海林 on 2023/4/10.
//

#import "UIApplication+ZHCategory.h"

@implementation UIApplication (ZHCategory)

- (NSString *)zh_appBundleName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

- (NSString *)zh_appBundleID {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

- (NSString *)zh_appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

- (NSString *)zh_appBuildVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

@end
