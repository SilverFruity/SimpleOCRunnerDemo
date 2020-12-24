//
//  GlobalFunctionTable.m
//  SimpleOCRunnerDemo
//
//  Created by Jiang on 2020/12/24.
//

#import "GlobalFunctionTable.h"
@interface GlobalFunctionTable()
@property (nonatomic, strong)NSMutableDictionary <NSString *, ASTFunctionImpNode *>*table;
@end
@implementation GlobalFunctionTable
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.table = [NSMutableDictionary dictionary];
    }
    return self;
}
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static GlobalFunctionTable * _globalFunctionTable = nil;
    dispatch_once(&onceToken, ^{
        _globalFunctionTable = [GlobalFunctionTable new];
    });
    return _globalFunctionTable;
}
+ (void)registerFunctionImpNode:(ASTFunctionImpNode *)node{
    if (node.declare.declare.varname) {
        [GlobalFunctionTable sharedInstance].table[node.declare.declare.varname] = node;
    }
}
+ (nullable ASTFunctionImpNode *)functionImpNodeForName:(NSString *)name{
    return [GlobalFunctionTable sharedInstance].table[name];
}
@end
