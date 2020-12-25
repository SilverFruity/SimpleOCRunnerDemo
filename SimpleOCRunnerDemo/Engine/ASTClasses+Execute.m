//
//  ASTClasses+Execute.m
//  SimpleOCRunnerDemo
//
//  Created by Jiang on 2020/12/24.
//

#import "ASTClasses+Execute.h"
#import "ORValue.h"
#import "EvalArgsStack.h"
#import "GlobalFunctionTable.h"
#import "ASTDeclareNode+TypeEncode.h"
@implementation ASTValueNode (Execute)
- (ORValue *)execute:(EvalScope *)scope{
    switch (self.type) {
        case ASTValueNodeIdentifier:
        {
            NSString *identifier = (__bridge NSString *)self.value.pointerValue;
            return [scope recursiveGetValueWithIdentifier:identifier];
        }
        case ASTValueNodeDouble:
        {
            double value = self.value.doubleValue;
            return [[ORValue alloc] initWithPointer:&value typeEncode:OCTypeStringDouble];
        }
        case ASTValueNodeInt:
        {
            int64_t value = self.value.intValue;
            return [[ORValue alloc] initWithPointer:&value typeEncode:OCTypeStringLongLong];
        }
        default:
            break;
    }
    return [ORValue voidValue];
}
@end

@implementation ASTInitDeclareNode (Execute)
- (ORValue *)execute:(EvalScope *)scope{
    if (self.expression) {
        ORValue *result = [self.expression execute:scope];
        result.typeEncode = (char *)self.declare.typeEncode;
        [scope setValue:result identifier:self.declare.varname];
    }else{
        ORValue *result = [[ORValue alloc] initWithPointer:NULL typeEncode:self.declare.typeEncode];
        return result;
    }
    return [ORValue voidValue];
}
@end

@implementation ASTBinaryNode (Execute)
- (ORValue *)execute:(EvalScope *)scope{
    ORValue *left = [self.left execute:scope];
    ORValue *right = [self.right execute:scope];
    ORValue *result = [[ORValue alloc] initWithPointer:NULL typeEncode:left.typeEncode];
    switch (left.type) {
        case OCTypeLongLong:
        {
            int64_t value = left.intValue + right.intValue;
            result.pointer = &value;
            break;
        }
        case OCTypeDouble:
        {
            double value = left.doubleValue + right.doubleValue;
            result.pointer = &value;
            break;
        }
        default:
            break;
    }
    return result;
}
@end

@implementation ASTScopeNode (Execute)
- (ORValue *)execute:(EvalScope *)scope{
    //{ }
    for (id <ASTExecute>statement in self.nodes) {
        ORValue *result = [statement execute:scope];
        if (!result.isNormalEnd) {
            return result;
        }
    }
    return [ORValue voidValue];
}
@end

@implementation ASTFunctionImpNode (Execute)
- (ORValue *)execute:(EvalScope *)scope{
    if ([EvalArgsStack isEmpty]) {
        [GlobalFunctionTable registerFunctionImpNode:self];
        return [ORValue voidValue];
    }
    scope = [scope createSubScope];
    NSArray *args = [EvalArgsStack top];
    NSArray <ASTDeclareNode *>*argDeclares = self.declare.argDeclares;
    for (int i = 0; i < args.count; i++) {
        [scope setValue:args[i] identifier:argDeclares[i].varname];
    }
    return [self.scope execute:scope];
}
@end

@implementation ASTFunctionCallNode (Execute)
- (ORValue *)execute:(EvalScope *)scope{
    if ([self.caller isKindOfClass:[ASTValueNode class]]) {
        ASTValueNode *node = (ASTValueNode *)self.caller;
        ASTFunctionImpNode *impNode = [GlobalFunctionTable functionImpNodeForName:(__bridge NSString *)node.value.pointerValue];
        if (impNode) {
            NSMutableArray *args = [NSMutableArray array];
            for (ASTNode *exp in self.args) {
                [args addObject:[exp execute:scope]];
            }
            [EvalArgsStack push:args];
            ORValue *result = [impNode execute:scope];
            [EvalArgsStack pop];
            return result;
        }
    }
    return [ORValue voidValue];
}
@end


@implementation ASTReturnNode (Execute)
- (ORValue *)execute:(EvalScope *)scope{
    ORValue *result = [self.expression execute:scope];
    result.controlState = ORControlStateReturn;
    return result;
}
@end
