//
//  ORValue.h
//  SimpleOCRunnerDemo
//
//  Created by Jiang on 2020/11/27.
//

#import <Foundation/Foundation.h>
#import "OCTypeEncode.h"
typedef union{
    int64_t intValue;
    double doubleValue;
}ORRealValue;
typedef enum {
    ORControlStateNormalEnd = 0,
    ORControlStateReturn
}ORControlState;
@interface ORValue: NSObject
{
    ORRealValue _realValue;
}
@property (nonatomic, assign, readonly)OCType type;
@property (nonatomic, assign)ORControlState controlState;
@property (nonatomic, assign)char *typeEncode;
@property (nonatomic, assign)void *pointer;
- (instancetype)initWithPointer:(void *)pointer typeEncode:(const char *)typeEncode;
+ (instancetype)voidValue;
- (BOOL)isNormalEnd;
@end



@interface ORValue(Value)
@property (nonatomic, assign, readonly)int64_t intValue;
@property (nonatomic, assign, readonly)double doubleValue;
@end
