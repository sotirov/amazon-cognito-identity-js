//
//  JKBigIntegerOc.h
//  JKBigIntegerOc
//
//  Created by Jānis Kiršteins on 5/21/13.
//  Copyright (c) 2013 Jānis Kiršteins. All rights reserved.
//

// Licensed under the MIT License

#import <Foundation/Foundation.h>
#include "tommath.h"

@interface JKBigIntegerOc : NSObject <NSSecureCoding>

- (id)initWithValue:(mp_int *)value;
- (mp_int *)value;

- (id)initWithUnsignedLong:(unsigned long)ul;
- (id)initWithString:(NSString *)string;
- (id)initWithString:(NSString *)string andRadix:(int)radix;
- (id)initWithCString:(char *)cString;
- (id)initWithCString:(char *)cString andRadix:(int)radix;

- (id)add:(JKBigIntegerOc *)bigInteger;
- (id)subtract:(JKBigIntegerOc *)bigInteger;
- (id)multiply:(JKBigIntegerOc *)bigInteger;
- (id)divide:(JKBigIntegerOc *)bigInteger;

- (id)remainder:(JKBigIntegerOc *)bigInteger;
- (NSArray *)divideAndRemainder:(JKBigIntegerOc *)bigInteger;

- (id)pow:(unsigned int)exponent;
- (id)pow:(JKBigIntegerOc*)exponent andMod:(JKBigIntegerOc*)modulus;
- (id)negate;
- (id)abs;

- (id)bitwiseXor:(JKBigIntegerOc *)bigInteger;
- (id)bitwiseOr:(JKBigIntegerOc *)bigInteger;
- (id)bitwiseAnd:(JKBigIntegerOc *)bigInteger;
- (id)shiftLeft:(unsigned int)n;
- (id)shiftRight:(unsigned int)n;

- (id)gcd:(JKBigIntegerOc *)bigInteger;

- (NSComparisonResult) compare:(JKBigIntegerOc *)bigInteger;

- (unsigned long)unsignedIntValue;
- (NSString *)stringValue;
- (NSString *)stringValueWithRadix:(int)radix;

- (NSString *)description;

- (unsigned int)countBytes;
- (void)toByteArraySigned: (unsigned char*) byteArray;
- (void)toByteArrayUnsigned: (unsigned char*) byteArray;

@end
