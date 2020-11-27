//
//  ORValue.m
//  SimpleOCRunnerDemo
//
//  Created by Jiang on 2020/11/27.
//

#import "ORValue.h"

ORValue *makeValueWithType(ORValueType type){
    ORValue *value = malloc(sizeof(ORValue));
    value->type = type;
    return value;
}
