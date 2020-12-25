//
//  ORValue.m
//  SimpleOCRunnerDemo
//
//  Created by Jiang on 2020/11/27.
//

#import "ORValue.h"

@implementation ORValue
- (instancetype)initWithPointer:(void *)pointer typeEncode:(const char *)typeEncode{
    self = [super init];
    if (self) {
        self.typeEncode = (char *)typeEncode;
        self.pointer = pointer;
    }
    return self;
}
-(OCType)type{
    return *_typeEncode;
}
- (void)setTypeEncode:(char *)typeEncode{
    if (typeEncode == NULL) {
        typeEncode = strdup(OCTypeStringLongLong);
    }
    if (_typeEncode != NULL) {
        free(_typeEncode);
    }
    _typeEncode = strdup(typeEncode);
}
- (void)setPointer:(void *)pointer{
    void *replace = NULL;
    if (pointer == NULL) {
        pointer = &replace;
    }
    switch (*_typeEncode) {
        case OCTypeDouble:
            _realValue.doubleValue = *(double *)pointer;
            _pointer = &_realValue;
            break;
        case OCTypeLongLong:
            _realValue.intValue = *(int64_t *)pointer;
            _pointer = &_realValue;
        default:
            break;
    }
}
- (void)dealloc{
    free(_typeEncode);
}
+ (instancetype)voidValue{
    return [[self alloc] initWithPointer:NULL typeEncode:OCTypeStringVoid];
}
- (BOOL)isNormalEnd{
    return self.controlState == ORControlStateNormalEnd;
}
@end


@implementation ORValue(Value)
- (int64_t)intValue{
    switch (self.type) {
        case OCTypeLongLong:
            return (int64_t)*(int64_t *)self.pointer;
            break;
        case OCTypeDouble:
            return (int64_t)*(double *)self.pointer;
            break;
        default:
            return 0;
            break;
    }
}
- (double)doubleValue{
    switch (self.type) {
        case OCTypeLongLong:
            return (double)*(int64_t *)self.pointer;
            break;
        case OCTypeDouble:
            return (double)*(double *)self.pointer;
            break;
        default:
            return 0;
            break;
    }
}
@end
