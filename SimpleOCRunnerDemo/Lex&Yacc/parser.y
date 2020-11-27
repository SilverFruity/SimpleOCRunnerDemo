%{
#import <Foundation/Foundation.h>
#import "ORValue.h"
#define YYDEBUG 1
#define YYERROR_VERBOSE
extern int yylex (void);
extern void yyerror(const char *s);
%}
%union{
    int64_t intValue;
    double doubleValue;
    __unsafe_unretained id object;
    char *stringValue;
    void *anyValue;
}
%token<object> IDENTIFIER
%token<doubleValue> DOUBLE_LITERAL
%token<intValue>    INTETER_LITERAL

%token INT_TYPE
%token DOUBLE_TYPE
%token RETURN

%type<object> statements
%type<object> expression
%type<object> assign_exp
%type<anyValue> binary_exp
%type<anyValue> primary_exp

%start door

%%
door:
/*empty*/
| statements;
;

statements:
expression ';'
| statements expression ';'
;

expression:
assign_exp
| binary_exp
;

assign_exp:
IDENTIFIER '=' binary_exp
{
    ORValue *result = $3;
    switch (result->type){
      case OR_INT:
      NSLog(@"%@ = %lld",$1,result->value.intValue);
      break;
      case OR_DOUBLE:
      NSLog(@"%@ = %f",$1,result->value.doubleValue);
      break;
    }
}
;

binary_exp:
primary_exp
| binary_exp '+' binary_exp
{
    ORValue *left = $1;
    ORValue *right = $3;
    ORValue *result = makeValueWithType(left->type);
    switch (left->type){
      case OR_INT:
      result->value.intValue = left->value.intValue + right->value.intValue;
      break;
      case OR_DOUBLE:
      result->value.doubleValue = left->value.doubleValue + right->value.doubleValue;
      break;
    }
    free(left); free(right);
    $$ = result;
}
| binary_exp '-' binary_exp
{
    ORValue *left = $1;
    ORValue *right = $3;
    
    ORValue *result = makeValueWithType(left->type);
    switch (left->type){
      case OR_INT:
      result->value.intValue = left->value.intValue - right->value.intValue;
      break;
      case OR_DOUBLE:
      result->value.doubleValue = left->value.doubleValue - right->value.doubleValue;
      break;
    }
    free(left); free(right);
    $$ = result;
}
;

primary_exp:
INTETER_LITERAL
{
    ORValue *value = makeValueWithType(OR_INT);
    value->value.intValue = $1;
    $$ = value;
}
| DOUBLE_LITERAL
{
    ORValue *value = makeValueWithType(OR_DOUBLE);
    value->value.doubleValue = $1;
    $$ = value;
}
;
%%


void yyerror(const char *s)
{
    fflush(stdout);
    NSLog(@"yyerror: %s", s);
}
