//
//  UIApplication+ZHCategory.h
//  AppDemo
//
//  Created by ZHL on 2023/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (ZHCategory)

- (NSString *)zh_appBundleName;

- (NSString *)zh_appBundleID;

- (NSString *)zh_appVersion;

- (NSString *)zh_appBuildVersion;

@end

NS_ASSUME_NONNULL_END
