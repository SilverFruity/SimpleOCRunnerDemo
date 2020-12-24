//
//  ASTClasses+Execute.m
//  SimpleOCRunnerDemo
//
//  Created by Jiang on 2020/12/24.
//

#import "ASTClasses+Execute.h"
#import "ORValue.h"
@implementation ASTDeclareNode (Execute)
- (ORValue *)execute:(EvalScope *)scope{
    return [ORValue voidValue];
}
@end
@implementation ASTValueNode (Execute)
- (ORValue *)execute:(EvalScope *)scope{
    return [ORValue voidValue];
}
@end

@implementation ASTInitDeclareNode (Execute)
- (ORValue *)execute:(EvalScope *)scope{
    return [ORValue voidValue];
}
@end
@implementation ASTBinaryNode (Execute)
- (ORValue *)execute:(EvalScope *)scope{
    return [ORValue voidValue];
}
@end

@implementation ASTScopeNode (Execute)
- (ORValue *)execute:(EvalScope *)scope{
    return [ORValue voidValue];
}
@end

@implementation ASTFunctionDeclareNode (Execute)
- (ORValue *)execute:(EvalScope *)scope{
    return [ORValue voidValue];
}
@end

@implementation ASTFunctionImpNode (Execute)
- (ORValue *)execute:(EvalScope *)scope{
    return [ORValue voidValue];
}
@end

@implementation ASTFunctionCallNode (Execute)
- (ORValue *)execute:(EvalScope *)scope{
    return [ORValue voidValue];
}
@end


@implementation ASTReturnNode (Execute)
- (ORValue *)execute:(EvalScope *)scope{
    return [ORValue voidValue];
}
@end
