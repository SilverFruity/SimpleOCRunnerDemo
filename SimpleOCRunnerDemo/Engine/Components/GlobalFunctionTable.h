//
//  GlobalFunctionTable.h
//  SimpleOCRunnerDemo
//
//  Created by Jiang on 2020/12/24.
//

#import <Foundation/Foundation.h>
#import "ASTClasses.h"
NS_ASSUME_NONNULL_BEGIN

@interface GlobalFunctionTable : NSObject
+ (void)registerFunctionImpNode:(ASTFunctionImpNode *)node;
+ (nullable ASTFunctionImpNode *)functionImpNodeForName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
