%{
#import <Foundation/Foundation.h>
#define YYDEBUG 1
#define YYERROR_VERBOSE
extern int yylex (void);
extern void yyerror(const char *s);
%}
%union{
    uint64_t intValue;
    double doubleValue;
    __unsafe_unretained id object;
    char *stringValue;
}
%token<stringValue> IDENTIFIER
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
;

statement_list:
| statement_list statement
;

statement:
declaration ';'
| expression ';'
| RETURN expression ';'
| declaration scope_statements
;

specifier_type:
INT_TYPE
| DOUBLE_TYPE
;

declaration:
specifier_type IDENTIFIER
| declaration '=' expression
| declaration '(' declaration_list ')'
;

scope_statements:
'{' statement_list '}'
;

primary_expression:
IDENTIFIER
| INTEGER_LITERAL
| DOUBLE_LITERAL
;

expression:
primary_expression
| expression '+' primary_expression
| expression '(' expression_list ')'
;

declaration_list:
declaration
| declaration_list ',' declaration
;

expression_list:
| expression
| expression_list ',' expression
;



%%


void yyerror(const char *s)
{
    NSLog(@"yyerror: %s", s);
}
