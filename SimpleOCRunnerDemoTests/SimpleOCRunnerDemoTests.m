//
//  SimpleOCRunnerDemoTests.m
//  SimpleOCRunnerDemoTests
//
//  Created by Jiang on 2020/11/19.
//

#import <XCTest/XCTest.h>
#import "SingleEngine.h"
@interface SimpleOCRunnerDemoTests : XCTestCase

@end

@implementation SimpleOCRunnerDemoTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    NSString *source =
    @"int a = 1;"
    "double b = 1.0;";
    AST *ast = [SingleEngine parse:source];
    XCTAssert(parserError == nil, @"error: %@", parserError);
    ASTInitDeclareNode *node1 = (ASTInitDeclareNode *)ast.nodes.firstObject;
    XCTAssert([node1 isKindOfClass:[ASTInitDeclareNode class]]);
    XCTAssert([node1.declare.varname isEqual:@"a"]);
    XCTAssert(node1.declare.type != nil);
    XCTAssert(node1.declare.type.type == ASTSpecifierTypeInt);
    XCTAssert([node1.expression isKindOfClass:[ASTValueNode class]]);
    XCTAssert([(ASTValueNode *)node1.expression value].intValue == 1);
    
    ASTInitDeclareNode *node2 = (ASTInitDeclareNode *)ast.nodes.lastObject;
    XCTAssert([node2 isKindOfClass:[ASTInitDeclareNode class]]);
    XCTAssert([node2.declare.varname isEqual:@"b"]);
    XCTAssert(node2.declare.type != nil);
    XCTAssert(node2.declare.type.type == ASTSpecifierTypeDouble);
    XCTAssert([node2.expression isKindOfClass:[ASTValueNode class]]);
    XCTAssert([(ASTValueNode *)node2.expression value].doubleValue == 1.0);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
