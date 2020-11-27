//
//  ORValue.h
//  SimpleOCRunnerDemo
//
//  Created by Jiang on 2020/11/27.
//

#import <Foundation/Foundation.h>

typedef enum{
    OR_INT,
    OR_DOUBLE
}ORValueType;

typedef union{
    int64_t intValue;
    double doubleValue;
}ORRealValue;

typedef struct{
    ORValueType type;
    ORRealValue value;
}ORValue;

ORValue *makeValueWithType(ORValueType type);
