//
//  EDAddressFormatterSpec.m
//  EDExtendedDebug
//
//  Created by Alexey Fayzullov on 5/20/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import <EDExtendedDebug/EDAddressFormatter.h>
#import "EDFormatterTestObject.h"

SpecBegin(EDAddressFormatter)

describe(@"formatValue", ^{
    
    it(@"should return nil if non-object is passed", ^{
        EDAddressFormatter *sut = [EDAddressFormatter new];
        
        NSInteger anInteger = 5;
        NSValue *wrapedInteger = [NSValue valueWithBytes:&anInteger objCType:@encode(NSInteger)];
        
        NSString *formattedString = [sut formatValue:wrapedInteger];
        
        EXP_expect(formattedString).to.beNil;
    });
    
    it(@"should return nil if nil value is passed", ^{
        
        EDAddressFormatter *sut = [EDAddressFormatter new];
        id object = nil;
        
        NSValue *wrappedNilObject = [NSValue valueWithBytes:&object objCType:@encode(id)];
        
        NSString *formattedString = [sut formatValue:wrappedNilObject];
        
        EXP_expect(formattedString).to.beNil;
    });
    
    it(@"should return address of passed object", ^{
        EDAddressFormatter *sut = [EDAddressFormatter new];
        
        EDFormatterTestObject *object = [EDFormatterTestObject new];
        NSValue *wrappedObject = [NSValue valueWithBytes:&object objCType:@encode(id)];
        
        NSString *formattedString = [sut formatValue:wrappedObject];
        NSString *expectedString = [NSString stringWithFormat:@"<%@: %p>", [object class], object];
        EXP_expect(formattedString).to.equal(expectedString);
    });
    
    it(@"should truncate double underlines in class name", ^{
        EDAddressFormatter *sut = [EDAddressFormatter new];
        
        __EDUnderlinedTestObject *object = [__EDUnderlinedTestObject new];
        NSValue *wrappedObject = [NSValue valueWithBytes:&object objCType:@encode(id)];
        
        NSString *formattedString = [sut formatValue:wrappedObject];
        NSString *expectedString = [NSString stringWithFormat:@"<EDUnderlinedTestObject: %p>", object];
        EXP_expect(formattedString).to.equal(expectedString);
    });
    
    it(@"should not retain passed object", ^{
        EDAddressFormatter *sut = [EDAddressFormatter new];
        
        NSObject *object = [NSObject new];
        NSValue *wrappedObject = [NSValue valueWithBytes:&object objCType:@encode(id)];
        long countBefore = CFGetRetainCount((__bridge CFTypeRef)object);
        
        [sut formatValue:wrappedObject];
        long countAfter = CFGetRetainCount((__bridge CFTypeRef)object);
        
        EXP_expect(countBefore).to.equal(countAfter);
    });
});

SpecEnd