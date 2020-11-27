//
//  Lexer.h
//  SimpleOCRunnerDemo
//
//  Created by Jiang on 2020/11/19.
//

#import <UIKit/UIKit.h>

typedef enum {
    NONE,
    HEADER,
    // 122
    INT,
    // 0.11
    DOUBLE,
    // return
    RETURN_STATE,
    IDENTIFIER,
    // ( ) ; { } , = +
    SYMBOL
}TOKEN_TYPE;

typedef union{
    char *stringBuffer;
    double doubleValue;
    int64_t intValue;
}TOKEN_VALUE;

typedef struct TOKEN{
    TOKEN_TYPE type;
    TOKEN_VALUE value;
    struct TOKEN *next;
}TOKEN;

TOKEN* LexerStartAnalyze(const char *source);


