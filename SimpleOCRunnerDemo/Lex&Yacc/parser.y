%{
#import <Foundation/Foundation.h>
#import "ASTClasses.h"
#define YYDEBUG 1
#define YYERROR_VERBOSE
extern int yylex (void);
extern void yyerror(const char *s);
extern AST *globalAst;
%}
%union{
    int64_t intValue;
    double doubleValue;
    __unsafe_unretained id object;
    char *stringValue;
}
%token<object> IDENTIFIER
%token<doubleValue> DOUBLE_LITERAL
%token<intValue>    INTEGER_LITERAL

%token INT_TYPE
%token DOUBLE_TYPE
%token RETURN

%type<object> statement_list
%type<object> statement
%type<object> specifier_type
%type<object> declaration


%type<object> primary_expression
%type<object> expression
%type<object> scope_statements
%type<object> expression_list
%type<object> declaration_list

%start door

%%

door:
statement_list
{
    globalAst.nodes = $1;
}
;

statement_list:
{
    __autoreleasing id value = [NSMutableArray array];
    $$ = value;
}
| statement_list statement
{
    [$1 addObject: $2];
    $$ = $1;
}
;

statement:
declaration ';'
| expression ';'
| RETURN expression ';'
{
    __autoreleasing ASTReturnNode *node = [ASTReturnNode new];
    node.expression = $2;
    $$ = node;
}
| declaration scope_statements
{
    __autoreleasing ASTFunctionImpNode *node = [ASTFunctionImpNode new];
    node.declare = $1;
    node.scope = $2;
    $$ = node;
}
;

specifier_type:
INT_TYPE
{
    __autoreleasing ASTSpecifierNode *node = [ASTSpecifierNode new];
    node.type = ASTSpecifierTypeInt;
    $$ = node;
}
| DOUBLE_TYPE
{
    __autoreleasing ASTSpecifierNode *node = [ASTSpecifierNode new];
    node.type = ASTSpecifierTypeDouble;
    $$ = node;
}
;

declaration:
specifier_type IDENTIFIER
{
    __autoreleasing ASTDeclareNode *node = [ASTDeclareNode new];
    node.type = $1;
    node.varname = $2;
    $$ = node;
}
| declaration '=' expression
{
    __autoreleasing ASTInitDeclareNode *node = [ASTInitDeclareNode new];
    node.declare = $1;
    node.expression = $3;
    $$ = node;
}
| declaration '(' declaration_list ')'
{
    __autoreleasing ASTFunctionDeclareNode *node = [ASTFunctionDeclareNode new];
    node.declare = $1;
    node.argDeclares = $3;
    $$ = node;
}
;

scope_statements:
'{' statement_list '}'
{
   __autoreleasing ASTScopeNode *node = [ASTScopeNode new];
   node.nodes = $2;
   $$ = node;
}
;

primary_expression:
IDENTIFIER
{
    __autoreleasing id value = [ASTValueNode nodeWithIdentifier: $1];
    $$ = value;
}
| INTEGER_LITERAL
{
    __autoreleasing id value = [ASTValueNode nodeWithInt: $1];
    $$ = value;
}
| DOUBLE_LITERAL
{
    __autoreleasing id value = [ASTValueNode nodeWithDouble: $1];
    $$ = value;
}
;

expression:
primary_expression
| expression '+' expression
{
    __autoreleasing ASTBinaryNode *node = [ASTBinaryNode new];
    node.left = $1;
    node.operator = ASTBinaryNodeOperatorAdd;
    node.right = $3;
    $$ = node;
}
| expression '(' expression_list ')'
{
    __autoreleasing ASTFunctionCallNode *node = [ASTFunctionCallNode new];
    node.caller =  $1;
    node.args = $3;
    $$ = node;
}
;

declaration_list:
declaration
{
    __autoreleasing id value = [@[$1] mutableCopy];
    $$ = value;
}
| declaration_list ',' declaration
{
    [$1 addObject: $3];
    $$ = $1;
}
;

expression_list:
{
    __autoreleasing id value = [NSMutableArray array];
    $$ = value;
}
| expression_list expression
{
    [$1 addObject: $2];
    $$ = $1;
}
| expression_list ',' expression
{
    [$1 addObject: $3];
    $$ = $1;
}
;



%%


void yyerror(const char *s)
{
    extern NSString *parserError;
    parserError = [NSString stringWithFormat:@"\n------yyerror------\n %s \n-------------------\n",s];
    NSLog(@"yyerror: %s", s);
    
}
