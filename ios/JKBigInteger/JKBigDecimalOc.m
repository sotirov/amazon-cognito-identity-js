//
//  JKBigDecimalOc.m
//  JKBigIntegerOc
//
//  Created by Midfar Sun on 5/4/15.
//  Copyright (c) 2015 Midfar Sun. All rights reserved.
//

// Licensed under the MIT License

#import "JKBigDecimalOc.h"

@implementation JKBigDecimalOc
@synthesize bigInteger, figure;

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (id)init
{
    return [self initWithString:@"0"];
}

- (id)initWithString:(NSString *)string
{
    self = [super init];
    if (self) {
        figure = 0;
        if ([string containsString:@"."]) {
            NSRange range = [string rangeOfString:@"."];
            figure = string.length-range.location-range.length;
            string = [string stringByReplacingCharactersInRange:range withString:@""];
        }
        bigInteger = [[JKBigIntegerOc alloc] initWithString:string];
    }
    return self;
}

+ (id)decimalWithString:(NSString *)string
{
    return [[JKBigDecimalOc alloc] initWithString:string];
}

-(id)initWithBigInteger:(JKBigIntegerOc *)i figure:(NSInteger)f
{
    self = [super init];
    if (self) {
        bigInteger = i;
        figure = f;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        bigInteger = [[JKBigIntegerOc alloc] initWithCoder:decoder];
        figure = [decoder decodeInt32ForKey:@"JKBigDecimalOcFigure"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)encoder
{
    [bigInteger encodeWithCoder:encoder];
    [encoder encodeInteger:figure forKey:@"JKBigDecimalOcFigure"];
}

- (id)add:(JKBigDecimalOc *)bigDecimal
{
    NSInteger maxFigure = 0;
    if (figure>=bigDecimal.figure) {
        maxFigure = figure;
        NSInteger exponent = maxFigure-bigDecimal.figure;
        JKBigIntegerOc *mInteger = [[JKBigIntegerOc alloc] initWithString:@"10"];
        JKBigIntegerOc *newInteger = [mInteger pow:(unsigned int)exponent];
        bigDecimal.bigInteger = [bigDecimal.bigInteger multiply:newInteger];
        bigDecimal.figure = maxFigure;
        
    }else{
        maxFigure = bigDecimal.figure;
        NSInteger exponent = maxFigure-figure;
        JKBigIntegerOc *mInteger = [[JKBigIntegerOc alloc] initWithString:@"10"];
        JKBigIntegerOc *newInteger = [mInteger pow:(unsigned int)exponent];
        bigInteger = [bigInteger multiply:newInteger];
        figure = maxFigure;
        
    }
    JKBigIntegerOc *newBigInteger = [bigInteger add:bigDecimal.bigInteger];
    JKBigDecimalOc *newBigDecimal = [[JKBigDecimalOc alloc] initWithBigInteger:newBigInteger figure:maxFigure];
    return newBigDecimal;
}

- (id)subtract:(JKBigDecimalOc *)bigDecimal
{
    NSInteger maxFigure = 0;
    if (figure>=bigDecimal.figure) {
        maxFigure = figure;
        NSInteger exponent = maxFigure-bigDecimal.figure;
        JKBigIntegerOc *mInteger = [[JKBigIntegerOc alloc] initWithString:@"10"];
        JKBigIntegerOc *newInteger = [mInteger pow:(unsigned int)exponent];
        bigDecimal.bigInteger = [bigDecimal.bigInteger multiply:newInteger];
        bigDecimal.figure = maxFigure;
        
    }else{
        maxFigure = bigDecimal.figure;
        NSInteger exponent = maxFigure-figure;
        JKBigIntegerOc *mInteger = [[JKBigIntegerOc alloc] initWithString:@"10"];
        JKBigIntegerOc *newInteger = [mInteger pow:(unsigned int)exponent];
        bigInteger = [bigDecimal.bigInteger multiply:newInteger];
        figure = maxFigure;
        
    }
    JKBigIntegerOc *newBigInteger = [bigInteger subtract:bigDecimal.bigInteger];
    JKBigDecimalOc *newBigDecimal = [[JKBigDecimalOc alloc] initWithBigInteger:newBigInteger figure:maxFigure];
    return newBigDecimal;
}

- (id)multiply:(JKBigDecimalOc *)bigDecimal
{
    NSInteger totalFigure = figure+bigDecimal.figure;
    JKBigIntegerOc *newBigInteger = [bigInteger multiply:bigDecimal.bigInteger];
    JKBigDecimalOc *newBigDecimal = [[JKBigDecimalOc alloc] initWithBigInteger:newBigInteger figure:totalFigure];
    return newBigDecimal;
}

- (id)divide:(JKBigDecimalOc *)bigDecimal
{
    NSInteger totalFigure = figure-bigDecimal.figure;
    if (totalFigure<0) {
        NSInteger exponent = -totalFigure;
        totalFigure=0;
        JKBigIntegerOc *mInteger = [[JKBigIntegerOc alloc] initWithString:@"10"];
        JKBigIntegerOc *newInteger = [mInteger pow:(unsigned int)exponent];
        bigInteger = [bigInteger multiply:newInteger];
    }
    JKBigIntegerOc *newBigInteger = [bigInteger divide:bigDecimal.bigInteger];
    JKBigDecimalOc *newBigDecimal = [[JKBigDecimalOc alloc] initWithBigInteger:newBigInteger figure:totalFigure];
    return newBigDecimal;
}

- (id)remainder:(JKBigDecimalOc *)bigDecimal
{
    NSInteger totalFigure = figure-bigDecimal.figure;
    if (totalFigure<0) {
        NSInteger exponent = -totalFigure;
        totalFigure=0;
        JKBigIntegerOc *mInteger = [[JKBigIntegerOc alloc] initWithString:@"10"];
        JKBigIntegerOc *newInteger = [mInteger pow:(unsigned int)exponent];
        bigInteger = [bigInteger multiply:newInteger];
    }
    JKBigIntegerOc *newBigInteger = [bigInteger remainder:bigDecimal.bigInteger];
    JKBigDecimalOc *newBigDecimal = [[JKBigDecimalOc alloc] initWithBigInteger:newBigInteger figure:bigDecimal.figure];
    return newBigDecimal;
}

//- (NSArray *)divideAndRemainder:(JKBigDecimalOc *)bigInteger
//{
//    
//}

-(NSComparisonResult) compare:(JKBigDecimalOc *)other {
    JKBigDecimalOc *tens = [[JKBigDecimalOc alloc] initWithString:@"10"];
    JKBigIntegerOc *scaledNum;
    JKBigIntegerOc *scaledCompareTo;
    
    if (figure > other.figure){
        tens = [tens pow:(int)figure];
    } else {
        tens = [tens pow:(int)other.figure];
    }
    //scale my value to integer value
    scaledNum = [[JKBigIntegerOc alloc] initWithString:[[self multiply:tens] stringValue]];
    //scale other value to integer
    scaledCompareTo = [[JKBigIntegerOc alloc] initWithString:[[other multiply:tens] stringValue]];
    NSComparisonResult compareBigInteger = [scaledNum compare:scaledCompareTo];
    return compareBigInteger;
}

- (id)pow:(unsigned int)exponent
{
    NSInteger totalFigure = figure*exponent;
    JKBigIntegerOc *newBigInteger = [bigInteger pow:exponent];
    JKBigDecimalOc *newBigDecimal = [[JKBigDecimalOc alloc] initWithBigInteger:newBigInteger figure:totalFigure];
    return newBigDecimal;
}

- (id)negate
{
    JKBigIntegerOc *newBigInteger = [bigInteger negate];
    JKBigDecimalOc *newBigDecimal = [[JKBigDecimalOc alloc] initWithBigInteger:newBigInteger figure:figure];
    return newBigDecimal;
}

- (id)abs
{
    JKBigIntegerOc *newBigInteger = [bigInteger abs];
    JKBigDecimalOc *newBigDecimal = [[JKBigDecimalOc alloc] initWithBigInteger:newBigInteger figure:figure];
    return newBigDecimal;
}

- (NSString *)stringValue
{
    NSString *string = [bigInteger stringValue];
    if (figure==0) {
        return string;
    }
    NSMutableString *mString = [NSMutableString stringWithString:string];
    NSInteger newFigure = string.length-figure;
    while (newFigure<=0) {
        [mString insertString:@"0" atIndex:0];
        newFigure++;
    }
    [mString insertString:@"." atIndex:newFigure];
    return mString;
}

- (NSString *)description
{
    return [self stringValue];
}

@end
