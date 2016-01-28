//
//  EDIvarHelperSpec.m
//  EDExtendedDebug
//
//  Created by Petro Korienev on 1/24/16.
//  Copyright © 2016 Alexey Fayzullov. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>

#import <EDExtendedDebug/EDIvarHelper.h>
#import "EDTests_TestObject.h"
#import <EDExtendedDebug/NSValue+EDExtendedDebug.h>

SpecBegin(EDIvarHelper)

describe(@"Ivar type/name methods", ^{

#if !NS_BLOCK_ASSERTIONS
    it(@"should assert NULL argument when calling +nameOfIvar:", ^{
        EXP_expect(^() {[EDIvarHelper nameOfIvar:NULL];}).to.raise(nil);
    });
#endif
    
    it(@"should get name of Ivar", ^{
        EXP_expect([EDIvarHelper nameOfIvar:class_getInstanceVariable([EDTests_TestObject class], "_objectIvar")]).to.equal(@"_objectIvar");
    });

#if !NS_BLOCK_ASSERTIONS
    it(@"should assert NULL argument when calling +encodedTypeForIvar:", ^{
        EXP_expect(^() {[EDIvarHelper encodedTypeForIvar:NULL];}).to.raise(nil);
    });
#endif
    
    it(@"should get type of object Ivar", ^{
        EXP_expect([EDIvarHelper encodedTypeForIvar:class_getInstanceVariable([EDTests_TestObject class], "_objectIvar")]).to.equal(@"@");
    });
    
    it(@"should get type of primitive value Ivar", ^{
        EXP_expect([EDIvarHelper encodedTypeForIvar:class_getInstanceVariable([EDTests_TestObject class], "_intIvar")]).to.equal(@"i");
    });
    
    it(@"should get type of struct Ivar", ^{
        EXP_expect([EDIvarHelper encodedTypeForIvar:class_getInstanceVariable([EDTests_TestObject class], "_rectIvar")]).to.beginWith(@"{CGRect");
    });
    
    it(@"should get type of block Ivar", ^{
        EXP_expect([EDIvarHelper encodedTypeForIvar:class_getInstanceVariable([EDTests_TestObject class], "_blockIvar")]).to.equal(@"@?");
    });
    
#if !NS_BLOCK_ASSERTIONS
    it(@"should assert NULL argument when calling +valueOfIvar:forObject:", ^{
        EXP_expect(^() {[EDIvarHelper valueOfIvar:NULL forObject:[EDTests_TestObject new]];}).to.raise(nil);
    });
    
    it(@"should assert nil argument when calling +valueOfIvar:forObject:", ^{
        EXP_expect(^() {[EDIvarHelper valueOfIvar:class_getInstanceVariable([EDTests_TestObject class], "_objectIvar") forObject:nil];}).to.raise(nil);
    });
#endif
    
    it(@"should get value of object Ivar", ^{
        EDTests_TestObject *testObject = [EDTests_TestObject new];
        NSNumber *number = @(2);
        testObject->_objectIvar = number;
        EXP_expect([EDIvarHelper valueOfIvar:class_getInstanceVariable([EDTests_TestObject class], "_objectIvar") forObject:testObject].objectValue).to.beIdenticalTo(number);
    });
    
    it(@"should get type of primitive value Ivar", ^{
        EDTests_TestObject *testObject = [EDTests_TestObject new];
        int i = 3;
        NSValue *expectedResult = [NSValue valueWithBytes:&i objCType:@encode(int)];
        testObject->_intIvar = i;
        EXP_expect([EDIvarHelper valueOfIvar:class_getInstanceVariable([EDTests_TestObject class], "_intIvar") forObject:testObject] ).to.equal(expectedResult);
    });

    it(@"should get type of struct Ivar", ^{
        EDTests_TestObject *testObject = [EDTests_TestObject new];
        CGRect rect = CGRectMake(0, 0, 320, 480);
        testObject->_rectIvar = rect;
        EXP_expect(CGRectEqualToRect([[EDIvarHelper valueOfIvar:class_getInstanceVariable([EDTests_TestObject class], "_rectIvar") forObject:testObject] CGRectValue], rect)).to.beTruthy;
    });
    
    it(@"should get type of block Ivar", ^{
        EDTests_TestObject *testObject = [EDTests_TestObject new];
        BOOL __block called = NO;
        void(^block)() = ^() {
            called = YES;
        };
        testObject->_blockIvar = block;
        ((void(^)())[EDIvarHelper valueOfIvar:class_getInstanceVariable([EDTests_TestObject class], "_blockIvar") forObject:testObject].pointerValue)();
        EXP_expect(called).to.beTruthy;
    });
});

SpecEnd