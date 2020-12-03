%option noyywrap
%{
    #import <Foundation/Foundation.h>
    #include "y.tab.h"
%}
%%
"," { return ',';}
";" { return ';'; }
"(" { return '('; }
")" { return ')'; }
"{" { return '{'; }
"}" { return '}'; }
"=" { return '='; }
"+" { return '+'; }
"-" { return '-'; }
"int" { return INT_TYPE; }
"double" { return DOUBLE_TYPE; }
"return" { return  RETURN; }
[0-9]+\.[0-9]+ {
    yylval.doubleValue = atof(yytext);
    return DOUBLE_LITERAL;
}
[1-9][0-9]* {  yylval.intValue = (int)strtol(yytext, NULL, 10); return INTEGER_LITERAL; }
[A-Za-z_$][A-Za-z_$0-9]* { yylval.object = [NSString stringWithUTF8String:yytext]; return IDENTIFIER; }
%%


