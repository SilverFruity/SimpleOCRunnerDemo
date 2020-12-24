//
//  ArgsStack.m
//  SimpleOCRunnerDemo
//
//  Created by Jiang on 2020/12/24.
//

#import "EvalArgsStack.h"
@interface EvalArgsStack()
@property (nonatomic, strong)NSMutableArray *stack;
@end
@implementation EvalArgsStack
+ (instancetype)threadStack{
    //每一个线程拥有一个独立的参数栈
    NSMutableDictionary *threadInfo = [[NSThread currentThread] threadDictionary];
    EvalArgsStack *stack = threadInfo[@"argsStack"];
    if (!stack) {
        stack = [[EvalArgsStack alloc] init];
        threadInfo[@"argsStack"] = stack;
    }
    return stack;
}
- (instancetype)init{
    if (self = [super init]) {
        self.stack = [NSMutableArray array];
    }
    return self;
}
+ (void)push:(NSArray <ORValue *> *)args{
    [[EvalArgsStack threadStack].stack addObject:args];
}
+ (NSArray <ORValue *>*)seek{
    return [EvalArgsStack threadStack].stack.lastObject;
}
+ (void)pop{
    [[EvalArgsStack threadStack].stack removeLastObject];
}
+ (BOOL)isEmpty{
    return [[EvalArgsStack threadStack].stack count] == 0;
}

@end
