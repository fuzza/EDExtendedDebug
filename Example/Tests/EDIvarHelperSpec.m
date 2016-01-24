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

SpecBegin(EDIvarHelper)

describe(@"Ivar type/name methods", ^{

#if !NS_BLOCK_ASSERTIONS
    it(@"should assert NULL argument when calling +nameOfIvar:", ^{
        EXP_expect(^() {[EDIvarHelper nameOfIvar:NULL];}).to.raise(nil);
    });
#endif
    
    it(@"should get name of Ivar", ^{
        EXP_expect([EDIvarHelper nameOfIvar:class_getInstanceVariable([EDTests_TestObject class], "_publicIvar")]).to.equal(@"_publicIvar");
    });

#if !NS_BLOCK_ASSERTIONS
    it(@"should assert NULL argument when calling +encodedTypeForIvar:", ^{
        EXP_expect(^() {[EDIvarHelper encodedTypeForIvar:NULL];}).to.raise(nil);
    });
#endif
    
    it(@"should get type of object Ivar", ^{
        EXP_expect([EDIvarHelper encodedTypeForIvar:class_getInstanceVariable([EDTests_TestObject class], "_publicIvar")]).to.equal(@"@");
    });
    
    it(@"should get type of primitive value Ivar", ^{
        EXP_expect([EDIvarHelper encodedTypeForIvar:class_getInstanceVariable([EDTests_TestObject class], "_packageIvar")]).to.equal(@"i");
    });
    
    it(@"should get type of struct Ivar", ^{
        EXP_expect([EDIvarHelper encodedTypeForIvar:class_getInstanceVariable([EDTests_TestObject class], "_privateIvar")]).to.beginWith(@"{CGRect");
    });
    
    it(@"should get type of block Ivar", ^{
        EXP_expect([EDIvarHelper encodedTypeForIvar:class_getInstanceVariable([EDTests_TestObject class], "_protectedIvar")]).to.equal(@"@?");
    });
    
#if !NS_BLOCK_ASSERTIONS
    it(@"should assert NULL argument when calling +valueOfIvar:forObject:", ^{
        EXP_expect(^() {[EDIvarHelper valueOfIvar:NULL forObject:[EDTests_TestObject new]];}).to.raise(nil);
    });
    
    it(@"should assert nil argument when calling +valueOfIvar:forObject:", ^{
        EXP_expect(^() {[EDIvarHelper valueOfIvar:class_getInstanceVariable([EDTests_TestObject class], "_publicIvar") forObject:nil];}).to.raise(nil);
    });
#endif
    
});

SpecEnd