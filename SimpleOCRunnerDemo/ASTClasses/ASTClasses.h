//
//  ASTClasses.h
//  SimpleOCRunnerDemo
//
//  Created by Jiang on 2020/12/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface ASTNode: NSObject

@end

@interface AST: NSObject
@property (nonatomic, strong)NSMutableArray <ASTNode *>*nodes;
@end

typedef enum{
    ASTSpecifierTypeInt = 0,
    ASTSpecifierTypeDouble
}ASTSpecifierType;

@interface ASTSpecifierNode: ASTNode
@property (nonatomic, assign) ASTSpecifierType type;
@property (nonatomic, strong) NSString *typeName;
@end

@interface ASTDeclareNode: ASTNode
@property (nonatomic, strong) ASTSpecifierNode *type;
@property (nonatomic, strong) NSString *varname;
@end

typedef enum{
    ASTValueNodeIdentifier,
    ASTValueNodeInt,
    ASTValueNodeDouble
}ASTValueNodeType;

typedef union {
    void *pointerValue;
    int64_t intValue;
    double doubleValue;
}ASTValueNodeValue;

@interface ASTValueNode: ASTNode
@property (nonatomic, assign) ASTValueNodeType type;
@property (nonatomic, assign) ASTValueNodeValue value;
+ (instancetype)nodeWithIdentifier:(NSString *)value;
+ (instancetype)nodeWithInt:(int64_t)value;
+ (instancetype)nodeWithDouble:(int)value;
@end

@interface ASTInitDeclareNode: ASTNode
@property (nonatomic, strong) ASTDeclareNode *declare;
@property (nonatomic, strong) ASTNode *expression;
@end

typedef enum {
    ASTBinaryNodeOperatorAdd
}ASTBinaryNodeOperator;

@interface ASTBinaryNode: ASTNode
@property (nonatomic, assign) ASTBinaryNodeOperator operator;
@property (nonatomic, strong) ASTNode *left;
@property (nonatomic, strong) ASTNode *right;
@end

@interface ASTScopeNode : ASTNode
@property (nonatomic, strong) NSMutableArray *nodes;
@end

@interface ASTFunctionDeclareNode: ASTNode
@property (nonatomic, strong) ASTDeclareNode *declare;
@property (nonatomic, strong) NSMutableArray <ASTDeclareNode *>*argDeclares;
@end

@interface ASTFunctionImpNode: ASTNode
@property (nonatomic, strong) ASTFunctionDeclareNode *declare;
@property (nonatomic, strong) ASTScopeNode *scope;
@end

@interface ASTFunctionCallNode: ASTNode
@property (nonatomic, strong) ASTNode *caller;
@property (nonatomic, strong) NSMutableArray *args;
@end


@interface ASTReturnNode : ASTNode
@property (nonatomic, strong) ASTNode *expression;
@end


NS_ASSUME_NONNULL_END
