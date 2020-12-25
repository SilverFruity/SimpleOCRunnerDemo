//
//  EvalScope.m
//  SimpleOCRunnerDemo
//
//  Created by Jiang on 2020/12/24.
//

#import "EvalScope.h"
#import "ORValue.h"
@implementation EvalScope
- (instancetype)init{
    self = [super init];
    if (self) {
        self.vars = [NSMutableDictionary dictionary];
    }
    return self;
}
+ (instancetype)topScope{
    static dispatch_once_t onceToken;
    static EvalScope * _instance = nil;
    dispatch_once(&onceToken, ^{
        _instance = [EvalScope new];
    });
    return _instance;
}
- (EvalScope *)createSubScope{
    EvalScope *scope = [EvalScope new];
    scope.next = self;
    return scope;
}
- (nullable ORValue *)recursiveGetValueWithIdentifier:(NSString *)identifier{
    EvalScope *scope = self;
    while (scope != nil) {
        ORValue *result = [scope getValueWithIdentifier:identifier];
        if (result) {
            return result;
        }
        scope = scope.next;
    }
    return [ORValue voidValue];
}
- (nullable ORValue *)getValueWithIdentifier:(NSString *)identifier{
    return self.vars[identifier];
}
- (void)setValue:(ORValue *)value identifier:(NSString *)identifier{
    self.vars[identifier] = value;
}
- (void)assignValue:(ORValue *)value identifier:(NSString *)identifier{
    EvalScope *scope = self;
    while (scope != nil) {
        if ([scope getValueWithIdentifier:identifier]) {
            [scope setValue:value identifier:identifier];
        }
        scope = scope.next;
    }
}
@end
