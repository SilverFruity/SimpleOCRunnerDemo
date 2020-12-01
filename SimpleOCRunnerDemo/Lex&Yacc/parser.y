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
%token<intValue>    INTETER_LITERAL

%token INT_TYPE
%token DOUBLE_TYPE
%token RETURN

%type<object> statement_list
%type<object> statement
%type<object> specifier_type
%type<object> declaration


%type<object> primary_expression
%type<object> expression
%type<object> block_statements

%start door

%%

door:
statement_list
;

statement_list: /*empty*/
| statement
| statement_list statement
;

statement:
declaration ';'
| expression ';'
| RETURN expression ';'
| function_declaration
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

block_statements:
'{' statement_list '}'
;

function_declaration:
declaration block_statements
;

primary_expression:
IDENTIFIER
| INTETER_LITERAL
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
