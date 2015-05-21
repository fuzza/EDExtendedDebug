//
//  EDAtomicTypesFormatter.m
//  EDExtendedDebug
//
//  Created by Alexey Fayzullov on 5/20/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import <EDExtendedDebug/EDAtomicTypesFormatter.h>

SpecBegin(EDAtomicTypesFormatter)

describe(@"formatValue", ^{
    
    it(@"should return nil if object is passed", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];
        
        id object = [NSObject new];
        NSValue *wrappedObject = [NSValue valueWithBytes:&object objCType:@encode(id)];
        
        NSString *formattedString = [sut formatValue:wrappedObject];
        
        EXP_expect(formattedString).to.beNil;
    });
    
    it(@"should return nil if struct is passed", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];
        
        CGRect aStruct = CGRectMake(0, 0, 250, 145);
        NSValue *wrappedStruct = [NSValue valueWithBytes:&aStruct objCType:@encode(CGRect)];
        
        NSString *formattedString = [sut formatValue:wrappedStruct];
        
        EXP_expect(formattedString).to.beNil;
    });
    
    it(@"should return formatted NSInteger (long)", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];
        
        NSInteger anInteger = -253;
        NSValue *wrappedInteger = [NSValue valueWithBytes:&anInteger objCType:@encode(NSInteger)];
        
        NSString *formattedString = [sut formatValue:wrappedInteger];
        
        EXP_expect(formattedString).to.equal(@"-253");
    });
    
    it(@"should return formatted NSUInteger (unsigned long)", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];
        
        NSUInteger anInteger = 253;
        NSValue *wrappedInteger = [NSValue valueWithBytes:&anInteger objCType:@encode(NSInteger)];
        
        NSString *formattedString = [sut formatValue:wrappedInteger];
        
        EXP_expect(formattedString).to.equal(@"253");
    });
    
    it(@"should return formatted char", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];
        
        char aChar = 'a';
        NSValue *wrappedInteger = [NSValue valueWithBytes:&aChar objCType:@encode(char)];
        
        NSString *formattedString = [sut formatValue:wrappedInteger];
        
        EXP_expect(formattedString).to.equal(@"a");
    });
    
    it(@"should return formatted unsigned char", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];
        
        unsigned char aChar = 'y';
        NSValue *wrappedInteger = [NSValue valueWithBytes:&aChar objCType:@encode(unsigned char)];
        
        NSString *formattedString = [sut formatValue:wrappedInteger];
        
        EXP_expect(formattedString).to.equal(@"y");
    });
    
    it(@"should return formatted int", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];
        
        int anInt = -23456;
        NSValue *wrappedInteger = [NSValue valueWithBytes:&anInt objCType:@encode(int)];
        
        NSString *formattedString = [sut formatValue:wrappedInteger];
        
        EXP_expect(formattedString).to.equal(@"-23456");
    });
    
    it(@"should return formatted unsigned int", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];
        
        unsigned int anInt = 23456;
        NSValue *wrappedInteger = [NSValue valueWithBytes:&anInt objCType:@encode(unsigned int)];
        
        NSString *formattedString = [sut formatValue:wrappedInteger];
        
        EXP_expect(formattedString).to.equal(@"23456");
    });

    it(@"should return formatted short", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];
        
        short aShort = -127;
        NSValue *wrappedInteger = [NSValue valueWithBytes:&aShort objCType:@encode(short)];
        
        NSString *formattedString = [sut formatValue:wrappedInteger];
        
        EXP_expect(formattedString).to.equal(@"-127");
    });

    it(@"should return formatted unsigned short", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];
        
        unsigned short aShort = 255;
        NSValue *wrappedInteger = [NSValue valueWithBytes:&aShort objCType:@encode(unsigned short)];
        
        NSString *formattedString = [sut formatValue:wrappedInteger];
        
        EXP_expect(formattedString).to.equal(@"255");
    });

    it(@"should return formatted long long", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];
        
        long long aLongLong = -123456789;
        NSValue *wrappedInteger = [NSValue valueWithBytes:&aLongLong objCType:@encode(long long)];
        
        NSString *formattedString = [sut formatValue:wrappedInteger];
        
        EXP_expect(formattedString).to.equal(@"-123456789");
    });
    
    it(@"should return formatted unsigned long long", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];
        
        unsigned long long aLongLong = 123456789;
        NSValue *wrappedInteger = [NSValue valueWithBytes:&aLongLong objCType:@encode(unsigned long long)];
        
        NSString *formattedString = [sut formatValue:wrappedInteger];
        
        EXP_expect(formattedString).to.equal(@"123456789");
    });
    
    it(@"should return formatted CGFloat", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];

        CGFloat aCGFloat = -22.5;
        NSValue *wrappedInteger = [NSValue valueWithBytes:&aCGFloat objCType:@encode(CGFloat)];
        
        NSString *formattedString = [sut formatValue:wrappedInteger];
        
        EXP_expect(formattedString).to.equal(@"-22.5");
    });
    
    it(@"should return formatted float", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];

        float aFloat = 2678.245;
        NSValue *wrappedInteger = [NSValue valueWithBytes:&aFloat objCType:@encode(float)];
        
        NSString *formattedString = [sut formatValue:wrappedInteger];
        
        EXP_expect(formattedString).to.equal(@"2678.245");
    });

    it(@"should return formatted double", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];
        
        double aDouble = 12362.1415;
        NSValue *wrappedInteger = [NSValue valueWithBytes:&aDouble objCType:@encode(double)];
        
        NSString *formattedString = [sut formatValue:wrappedInteger];
        
        EXP_expect(formattedString).to.equal(@"12362.1415");
    });
    
    it(@"should return formatted bool", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];
        
        BOOL aBool = YES;
        NSValue *wrappedInteger = [NSValue valueWithBytes:&aBool objCType:@encode(BOOL)];
        NSString *formattedString = [sut formatValue:wrappedInteger];
        
        EXP_expect(formattedString).to.equal(@"YES");
    });

    it(@"should return formatted selector", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];
        
        SEL aSelector = @selector(viewDidAppear:);
        NSValue *wrappedInteger = [NSValue valueWithBytes:&aSelector objCType:@encode(SEL)];
        NSString *formattedString = [sut formatValue:wrappedInteger];
        
        EXP_expect(formattedString).to.equal(@"viewDidAppear:");
    });
    
    it(@"should return formatted C String", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];
        
        char *aCString = "test c string";
        NSValue *wrappedInteger = [NSValue valueWithBytes:&aCString objCType:@encode(char *)];
        NSString *formattedString = [sut formatValue:wrappedInteger];
        
        EXP_expect(formattedString).to.equal(@"test c string");
    });

    it(@"should return formatted pointer address", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];
        
        int a = 3;
        void *ptr = &a;
        
        NSValue *wrappedInteger = [NSValue valueWithBytes:&ptr objCType:@encode(void *)];
        NSString *formattedString = [sut formatValue:wrappedInteger];
        
        EXP_expect(formattedString).to.equal([NSString stringWithFormat:@"%p", &a]);
    });

    it(@"should return null string for null pointer", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];
        
        void *ptr = NULL;
        
        NSValue *wrappedInteger = [NSValue valueWithBytes:&ptr objCType:@encode(void *)];
        NSString *formattedString = [sut formatValue:wrappedInteger];
        
        EXP_expect(formattedString).to.beNil;
    });
});

SpecEnd