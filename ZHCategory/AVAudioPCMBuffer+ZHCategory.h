//
//  AVAudioPCMBuffer+ZHCategory.h
//  ZHCategoryExample
//
//  Created by 周海林 on 2023/5/18.
//


#import <AVFAudio/AVFAudio.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVAudioPCMBuffer (ZHCategory)

- (NSData *)zh_data;

- (NSTimeInterval)zh_duration;

@end

NS_ASSUME_NONNULL_END
