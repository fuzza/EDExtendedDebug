//
//  EDCycleDetectorSpec.m
//  EDExtendedDebug
//
//  Created by Alexey Fayzullov on 5/25/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>

#import <EDExtendedDebug/EDCycleDetector.h>
#import "EDFormatterTestObject.h"

SpecBegin(EDCycleDetector)

describe(@"objectHasRetainCycle", ^{
    
    it(@"should return default message if no cycles found", ^{
        
        EDCycleDetector *detector = [EDCycleDetector new];
        
        EDFormatterTestObject *testObject = [EDFormatterTestObject new];
        __EDUnderlinedTestObject *childObject = [__EDUnderlinedTestObject new];
        
        testObject.strongULObject = childObject;
        childObject.weakObject = testObject;
        
        NSString *resultString = [detector objectHasRetainCycles:testObject];
        
        EXP_expect(resultString).to.equal(@"Retain cycle not found");
    });
    
    it(@"shouldn't return default message if cycle found", ^{
        
        EDCycleDetector *detector = [EDCycleDetector new];
        
        EDFormatterTestObject *testObject = [EDFormatterTestObject new];
        __EDUnderlinedTestObject *childObject = [__EDUnderlinedTestObject new];
        
        testObject.strongULObject = childObject;
        childObject.strongObject = testObject;
        
        NSString *resultString = [detector objectHasRetainCycles:testObject];
        
        EXP_expect(resultString).toNot.equal(@"Retain cycle not found");
    });
});

SpecEnd
