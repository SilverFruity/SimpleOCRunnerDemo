//
//  ASTDeclareNode+TypeEncode.m
//  SimpleOCRunnerDemo
//
//  Created by Jiang on 2020/12/24.
//

#import "ASTDeclareNode+TypeEncode.h"
#import "OCTypeEncode.h"
@implementation ASTDeclareNode (TypeEncode)
- (const char *)typeEncode{
    switch (self.type.type) {
        case ASTSpecifierTypeInt:
            return (const char *)OCTypeStringLongLong;
            break;
        case ASTSpecifierTypeDouble:
            return (const char *)OCTypeStringDouble;
        default:
            break;
    }
}
@end
