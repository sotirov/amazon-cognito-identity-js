//
//  JKBigDecimalOc.h
//  JKBigIntegerOc
//
//  Created by Midfar Sun on 5/4/15.
//  Copyright (c) 2015 Midfar Sun. All rights reserved.
//

// Licensed under the MIT License

#import <Foundation/Foundation.h>
#import "JKBigIntegerOc.h"

@interface JKBigDecimalOc : NSObject <NSSecureCoding>

@property(nonatomic, retain)JKBigIntegerOc *bigInteger;
@property(nonatomic, assign)NSUInteger figure;//小数位数

+ (id)decimalWithString:(NSString *)string;
- (id)initWithString:(NSString *)string;

- (id)add:(JKBigDecimalOc *)bigDecimal;
- (id)subtract:(JKBigDecimalOc *)bigDecimal;
- (id)multiply:(JKBigDecimalOc *)bigDecimal;
- (id)divide:(JKBigDecimalOc *)bigDecimal;

- (id)remainder:(JKBigDecimalOc *)bigInteger;
//- (NSArray *)divideAndRemainder:(JKBigDecimalOc *)bigInteger;

- (NSComparisonResult) compare:(JKBigDecimalOc *)other;
- (id)pow:(unsigned int)exponent;

- (id)negate;
- (id)abs;

- (NSString *)stringValue;

- (NSString *)description;

@end
