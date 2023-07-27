//
//  NSObject+ZHCategory.m
//  ZHCategoryExample
//
//  Created by ZHL on 2023/7/27.
//

#import "NSObject+ZHCategory.h"
@import ObjectiveC.runtime;

@implementation NSObject (ZHCategory)

+ (NSArray *)zh_getAllMethods{
    unsigned int methodCount =0;
    Method* methodList = class_copyMethodList(self,&methodCount);
    NSMutableArray *methodsArray = [NSMutableArray arrayWithCapacity:methodCount];
    for(int i = 0; i < methodCount; i++)
    {
        Method temp = methodList[i];
        SEL name_f = method_getName(temp);
        const char* name_s = sel_getName(name_f);
        int arguments = method_getNumberOfArguments(temp);
        const char* encoding = method_getTypeEncoding(temp);
        NSString *methodName = [NSString stringWithUTF8String:name_s];
        NSString *methodArgumentCount = [NSString stringWithFormat:@"%d",arguments];
        NSString *encodingStr = [NSString stringWithUTF8String:encoding];
        [methodsArray addObject:[NSString stringWithFormat:@"方法名：%@ 参数个数：%@ 编码方式：%@",methodName,methodArgumentCount,encodingStr]];
    }
    free(methodList);
    return methodsArray;
}

+ (NSArray *)zh_getAllProperties{
    u_int count;
    // 传递count的地址过去 &count
    objc_property_t *properties  = class_copyPropertyList(self, &count);
    //arrayWithCapacity的效率稍微高那么一丢丢
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        //此刻得到的propertyName为c语言的字符串
        const char* propertyName = property_getName(properties[i]);
        //此步骤把c语言的字符串转换为OC的NSString
        [propertiesArray addObject:[NSString stringWithUTF8String: propertyName]];
    }
    //class_copyPropertyList底层为C语言，所以我们一定要记得释放properties
    // You must free the array with free().
    free(properties);
    return propertiesArray;
}
@end
