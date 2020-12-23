//
//  SingleEngine.m
//  SimpleOCRunnerDemo
//
//  Created by Jiang on 2020/11/27.
//

#import "SingleEngine.h"
#import "ASTClasses.h"
AST *globalAst = nil;
NSString *parserError = nil;
@implementation SingleEngine
+ (AST *)parse: (NSString *)source{
    parserError = nil;
    globalAst = [AST new];
    typedef struct yy_buffer_state *YY_BUFFER_STATE;
    extern YY_BUFFER_STATE  yy_scan_string(const char *s);
    extern int yyparse(void);
    extern void yy_delete_buffer(YY_BUFFER_STATE buf);
    
    YY_BUFFER_STATE buf;
    buf = yy_scan_string([source cStringUsingEncoding:NSUTF8StringEncoding]);
    yyparse();
    yy_delete_buffer(buf);
    return globalAst;
}
+ (void)run:(NSString *)source{
//    AST *ast = [self parse:source];
}
@end
