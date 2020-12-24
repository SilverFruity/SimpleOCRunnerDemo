//
//  ArgsStack.h
//  SimpleOCRunnerDemo
//
//  Created by Jiang on 2020/12/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ORValue;
@interface EvalArgsStack : NSObject
+ (void)push:(NSArray <ORValue *>*)args;
+ (NSArray <ORValue *>*)seek;
+ (void)pop;
+ (BOOL)isEmpty;
@end
NS_ASSUME_NONNULL_END
