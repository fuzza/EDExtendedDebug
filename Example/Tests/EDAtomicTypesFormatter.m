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
    
    it(@"should return formatted NSInteger", ^{
        EDAtomicTypesFormatter *sut = [EDAtomicTypesFormatter new];
        
        NSInteger anInteger = 253;
        NSValue *wrappedInteger = [NSValue valueWithBytes:&anInteger objCType:@encode(NSInteger)];
        
        NSString *formattedString = [sut formatValue:wrappedInteger];
        
        EXP_expect(formattedString).to.equal(@"253");
    });
});

SpecEnd