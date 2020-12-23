//
//  ASTClasses.m
//  SimpleOCRunnerDemo
//
//  Created by Jiang on 2020/12/18.
//

#import "ASTClasses.h"

@implementation ASTNode

@end

@implementation AST
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nodes = [NSMutableArray array];
    }
    return self;
}
@end



@implementation ASTValueNode
+ (instancetype)nodeWithIdentifier:(NSString *)value{
    ASTValueNode *node = [ASTValueNode new];
    node.type = ASTValueNodeIdentifier;
    node->_value.pointerValue = (__bridge_retained  void *)value;
    return node;
}
+ (instancetype)nodeWithInt:(int64_t)value{
    ASTValueNode *node = [ASTValueNode new];
    node.type = ASTValueNodeInt;
    node->_value.intValue = value;
    return node;
}
+ (instancetype)nodeWithDouble:(int)value{
    ASTValueNode *node = [ASTValueNode new];
    node.type = ASTValueNodeDouble;
    node->_value.doubleValue = value;
    return node;
}


@end

@implementation ASTScopeNode
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nodes = [NSMutableArray array];
    }
    return self;
}
@end

@implementation ASTReturnNode

@end

@implementation ASTBinaryNode


@end


@implementation ASTSpecifierNode


@end

@implementation ASTDeclareNode



@end

@implementation ASTInitDeclareNode

@end

@implementation ASTFunctionDeclareNode



@end

@implementation ASTFunctionImpNode


@end

@implementation ASTFunctionCallNode


@end
