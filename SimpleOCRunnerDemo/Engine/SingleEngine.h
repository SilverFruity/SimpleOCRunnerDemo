//
//  SingleEngine.h
//  SimpleOCRunnerDemo
//
//  Created by Jiang on 2020/11/27.
//

#import <Foundation/Foundation.h>
#import "ASTClasses.h"
NS_ASSUME_NONNULL_BEGIN
extern NSString *parserError;
@interface SingleEngine : NSObject
+ (AST *)parse: (NSString *)source;
+ (void)run:(NSString *)source;
@end

NS_ASSUME_NONNULL_END
