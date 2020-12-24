//
//  EvalScope.h
//  SimpleOCRunnerDemo
//
//  Created by Jiang on 2020/12/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ORValue;
@interface EvalScope : NSObject
@property (nonatomic, strong)NSMutableDictionary *vars;
@property (nonatomic, strong)EvalScope *next;
+ (EvalScope *)topScope;
- (EvalScope *)createSubScope;
- (nullable ORValue *)recursiveGetValueWithIdentifier:(NSString *)identifier;
- (nullable ORValue *)getValueWithIdentifier:(NSString *)identifier;
- (void)setValue:(ORValue *)value identifier:(NSString *)identifier;
- (void)assignValue:(ORValue *)value identifier:(NSString *)identifier;
@end

NS_ASSUME_NONNULL_END
