//
//  NSDate+ZHFormatter.m
//  ZHCategoryExample
//
//  Created by ZHL on 2025/8/16.
//

#import "NSDate+ZHFormatter.h"
#import "NSString+ZHCategory.h"

@implementation NSDate (ZHFormatter)

- (NSString *)prettyString {
    // 获取系统首选语言
    NSString *language = [NSLocale preferredLanguages].firstObject;
    BOOL isChinese = [language hasPrefix:@"zh"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    
    // 计算年、月、日差
    NSDateComponents *components = [calendar components:
                                     (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                fromDate:self
                                                  toDate:now
                                                 options:0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = isChinese ? [NSLocale localeWithLocaleIdentifier:@"zh_CN"] :
                                    [NSLocale localeWithLocaleIdentifier:@"en_US"];
    
    // 中文格式
    if (isChinese) {
        formatter.AMSymbol = @"上午";
        formatter.PMSymbol = @"下午";
        
        if (components.year > 0) {
            [formatter setDateFormat:@"yyyy年M月d日 HH:mm"];
        } else if (components.day >= 7) {
            [formatter setDateFormat:@"M月d日 HH:mm"];
        } else if (components.day >= 2) {
            [formatter setDateFormat:@"EEEE HH:mm"];
        } else if (components.day == 1) {
            [formatter setDateFormat:@"昨天 HH:mm"];
            return [formatter stringFromDate:self];
        } else if (components.day == 0) {
            [formatter setDateFormat:@"HH:mm"];
        } else {
            [formatter setDateFormat:@"M月d日 HH:mm"];
        }
        return [formatter stringFromDate:self];
    }
    
    // 英文格式
    else {
        if (components.year > 0) {
            [formatter setDateFormat:@"MMM d, yyyy HH:mm"];
        } else if (components.day >= 7) {
            [formatter setDateFormat:@"MMM d HH:mm"];
        } else if (components.day >= 2) {
            [formatter setDateFormat:@"EEEE HH:mm"];
        } else if (components.day == 1) {
            NSString *timeStr = [self stringWithFormat:@"HH:mm" locale:@"en_US"];
            return [NSString stringWithFormat:@"Yesterday %@", timeStr];
        } else if (components.day == 0) {
            [formatter setDateFormat:@"HH:mm"];
        } else {
            [formatter setDateFormat:@"MMM d HH:mm"];
        }
        return [formatter stringFromDate:self];
    }
}

- (NSString *)stringWithFormat:(NSString *)format{
    return [self stringWithFormat:format locale:nil];
}

// 小工具方法：指定格式+语言输出
- (NSString *)stringWithFormat:(NSString *)format locale:(NSString *)localeID {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = format;
    if (![NSString zh_isNull:localeID]) {
        df.locale = [NSLocale localeWithLocaleIdentifier:localeID];
    }
    return [df stringFromDate:self];
}

- (NSDate *)dateWithString:(NSString *)dateStr format:(NSString *)format{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = format;
    return [df dateFromString:dateStr];
}

@end
