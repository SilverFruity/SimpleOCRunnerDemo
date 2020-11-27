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
    char *stringValue;
}
%token<stringValue> IDENTIFIER
%token<doubleValue> DOUBLE_LITERAL
%token<intValue>    INTETER_LITERAL

%token INT_TYPE
%token DOUBLE_TYPE
%token RETURN

%start door

%%

door: /*empty*/
;
%%


void yyerror(const char *s)
{
    
}
