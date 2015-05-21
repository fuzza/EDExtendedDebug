//
//  EDDescriptionFormatter.m
//  EDExtendedDebug
//
//  Created by Alexey Fayzullov on 5/20/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import <EDExtendedDebug/EDDescriptionFormatter.h>
#import "EDFormatterTestObject.h"

SpecBegin(EDDescriptionFormatter)

describe(@"formatValue", ^{
    
    it(@"should return nil if non-object is passed", ^{
        EDDescriptionFormatter *sut = [EDDescriptionFormatter new];
        
        NSInteger anInteger = 5;
        NSValue *wrapedInteger = [NSValue valueWithBytes:&anInteger objCType:@encode(NSInteger)];
        
        NSString *formattedString = [sut formatValue:wrapedInteger];
        
        EXP_expect(formattedString).to.beNil;
    });
    
    it(@"should return nil if nil value is passed", ^{
        
        EDDescriptionFormatter *sut = [EDDescriptionFormatter new];
        id object = nil;
        
        NSValue *wrappedNilObject = [NSValue valueWithBytes:&object objCType:@encode(id)];
        
        NSString *formattedString = [sut formatValue:wrappedNilObject];
        
        EXP_expect(formattedString).to.beNil;
    });
    
    it(@"should return description of passed object", ^{
        EDDescriptionFormatter *sut = [EDDescriptionFormatter new];
        
        EDFormatterTestObject *object = [EDFormatterTestObject new];
        NSValue *wrappedObject = [NSValue valueWithBytes:&object objCType:@encode(id)];
        
        NSString *formattedString = [sut formatValue:wrappedObject];
        
        EXP_expect(formattedString).to.equal([object description]);
    });
    
    it(@"should return description of class object", ^{
        EDDescriptionFormatter *sut = [EDDescriptionFormatter new];
        
        Class object = [EDFormatterTestObject class];
        NSValue *wrappedObject = [NSValue valueWithBytes:&object objCType:@encode(Class)];
        
        NSString *formattedString = [sut formatValue:wrappedObject];
        
        EXP_expect(formattedString).to.equal(NSStringFromClass(object));
    });
    
    it(@"should not retain passed object", ^{
        EDDescriptionFormatter *sut = [EDDescriptionFormatter new];
        
        NSObject *object = [NSObject new];
        NSValue *wrappedObject = [NSValue valueWithBytes:&object objCType:@encode(id)];
        long countBefore = CFGetRetainCount((__bridge CFTypeRef)object);
        
        [sut formatValue:wrappedObject];
        long countAfter = CFGetRetainCount((__bridge CFTypeRef)object);
        
        EXP_expect(countBefore).to.equal(countAfter);
    });
});

SpecEnd
