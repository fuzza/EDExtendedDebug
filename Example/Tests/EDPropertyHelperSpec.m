//
//  EDPropertyHelperSpec.m
//  EDExtendedDebug
//
//  Created by Petro Korienev on 1/24/16.
//  Copyright © 2016 Alexey Fayzullov. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>

#import <EDExtendedDebug/EDPropertyHelper.h>
#import "EDTests_TestObject.h"

SpecBegin(EDPropertyHelper)

describe(@"Property getter/setter/name/type methods", ^{
    
#if !NS_BLOCK_ASSERTIONS
    it(@"should assert NULL argument when calling +getterForProperty:", ^{
        EXP_expect(^() {NSStringFromSelector([EDPropertyHelper getterForProperty:NULL]);}).to.raise(nil);
    });
#endif
    
    it(@"should get property getter selector by property name", ^{
        objc_property_t property = class_getProperty([EDTests_TestObject class], "simpleProperty");
        EXP_expect(NSStringFromSelector([EDPropertyHelper getterForProperty:property])).to.equal(@"simpleProperty");
    });
    
    it(@"should get property getter selector by custom getter", ^{
        objc_property_t property = class_getProperty([EDTests_TestObject class], "customGetterProperty");
        EXP_expect(NSStringFromSelector([EDPropertyHelper getterForProperty:property])).to.equal(@"nameBreakingCocoaConventions");
    });
    
#if !NS_BLOCK_ASSERTIONS
    it(@"should assert NULL argument when calling +setterForProperty:", ^{
        EXP_expect(^() {NSStringFromSelector([EDPropertyHelper setterForProperty:NULL]);}).to.raise(nil);
    });
#endif
    
    it(@"should get property setter selector by property name", ^{
        objc_property_t property = class_getProperty([EDTests_TestObject class], "simpleProperty");
        EXP_expect(NSStringFromSelector([EDPropertyHelper setterForProperty:property])).to.equal(@"setSimpleProperty:");
    });
    
    it(@"should get property setter selector by custom setter", ^{
        objc_property_t property = class_getProperty([EDTests_TestObject class], "customSetterProperty");
        EXP_expect(NSStringFromSelector([EDPropertyHelper setterForProperty:property])).to.equal(@"nameBreakingCocoaConventions:");
    });

#if !NS_BLOCK_ASSERTIONS
    it(@"should assert NULL argument when calling +nameOfProperty:", ^{
        EXP_expect(^() {[EDPropertyHelper nameOfProperty:NULL];}).to.raise(nil);
    });
#endif
    
    it(@"should get +nameOfProperty:", ^{
        objc_property_t property = class_getProperty([EDTests_TestObject class], "simpleProperty");
        EXP_expect([EDPropertyHelper nameOfProperty:property]).to.equal(@"simpleProperty");
    });

#if !NS_BLOCK_ASSERTIONS
    it(@"should assert NULL argument when calling +encodedReturnTypeStringOfProperty:", ^{
        EXP_expect(^() {[EDPropertyHelper encodedReturnTypeStringOfProperty:NULL];}).to.raise(nil);
    });
#endif
    
    it(@"should get encoded return type", ^{
        objc_property_t property = class_getProperty([EDTests_TestObject class], "simpleProperty");
        EXP_expect([EDPropertyHelper encodedReturnTypeStringOfProperty:property]).to.equal(@"@");
    });
    
});

describe(@"property value obtainment", ^{
    
#if !NS_BLOCK_ASSERTIONS
    it(@"should assert NULL argument when calling +valueOfProperty:forObject:", ^{
        EXP_expect(^() {[EDPropertyHelper valueOfProperty:NULL forObject:nil];}).to.raise(nil);
    });
#endif
    
    it(@"should obtain property value", ^{
        EDTests_TestObject *testObject = [EDTests_TestObject new];
        NSUInteger hash = testObject.hash;
        NSValue *resultingValue = [NSValue valueWithBytes:&hash objCType:@encode(NSUInteger)];
        objc_property_t property = class_getProperty([EDTests_TestObject class], "hash");
        EXP_expect([EDPropertyHelper valueOfProperty:property forObject:testObject]).to.equal(resultingValue);
    });
    
    it(@"should get property with unrecognized selector", ^{
        EDTests_TestObject *testObject = [EDTests_TestObject new];
        objc_property_t property = class_getProperty([NSString class], "length");
        EXP_expect([EDPropertyHelper valueOfProperty:property forObject:testObject]).to.beNil;
    });
    
    it(@"should not throw exception for property with unrecognized selector", ^{
        EDTests_TestObject *testObject = [EDTests_TestObject new];
        objc_property_t property = class_getProperty([NSString class], "length");
        EXP_expect(^() {[EDPropertyHelper valueOfProperty:property forObject:testObject];}).notTo.raise(nil);
    });
    
    it(@"should throw when called exception-throwing getter", ^{
        EDTests_TestObject *testObject = [EDTests_TestObject new];
        objc_property_t property = class_getProperty([EDTests_TestObject class], "customGetterProperty");
        EXP_expect(^() {[EDPropertyHelper valueOfProperty:property forObject:testObject];}).to.raise(nil);
    });
});

SpecEnd