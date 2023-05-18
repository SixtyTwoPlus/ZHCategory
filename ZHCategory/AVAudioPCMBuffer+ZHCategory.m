//
//  AVAudioPCMBuffer+ZHCategory.m
//  ZHCategoryExample
//
//  Created by 周海林 on 2023/5/18.
//

#import "AVAudioPCMBuffer+ZHCategory.h"

@implementation AVAudioPCMBuffer (ZHCategory)

- (NSData *)zh_data{
    NSInteger nBytes = self.frameLength * self.format.streamDescription->mBytesPerFrame;
    NSRange range = NSMakeRange(0, nBytes);
    NSMutableData *data = [NSMutableData new];
    [data replaceBytesInRange:range withBytes:self.int16ChannelData[0]];
    return data;
}

- (NSTimeInterval)zh_duration{
    return self.format.sampleRate > 0 ? (self.frameLength / self.format.sampleRate) : 0;
}


@end
