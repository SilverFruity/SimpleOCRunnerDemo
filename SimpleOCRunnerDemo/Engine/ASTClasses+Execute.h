//
//  ASTClasses+Execute.h
//  SimpleOCRunnerDemo
//
//  Created by Jiang on 2020/12/24.
//
#import "ASTClasses.h"
#import "EvalScope.h"


NS_ASSUME_NONNULL_BEGIN

@protocol ASTExecute <NSObject>
- (ORValue *)execute:(EvalScope *)scope;
@end

@interface ASTNode (Execute) <ASTExecute>
- (ORValue *)execute:(EvalScope *)scope;
@end
NS_ASSUME_NONNULL_END
