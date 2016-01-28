//
//  EDExtendedDebugTests.m
//  EDExtendedDebugTests
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import <EDExtendedDebug/EDValueViewerBuilder.h>
#import <EDExtendedDebug/EDPropertyValueViewer.h>
#import <EDExtendedDebug/EDIvarValueViewer.h>

SpecBegin(EDValueViewerBuilder)

describe(@"build", ^{
    
    it(@"should return filled property viewer and call setupFormatters", ^{

        EDValueViewerBuilder *sut = [EDValueViewerBuilder valueViewerBuilderWithViewerClass:[EDPropertyValueViewer class]];
        
        id sutMock = OCMPartialMock(sut);
        [[sutMock expect] setupFormatter];
        
        EDPropertyValueViewer *viewer = [sut build];
        
        EXP_expect(viewer).notTo.beNil;
        [sutMock verify];
    });
    
    it(@"should return filled ivar viewer and call setupFormatters", ^{
        
        EDValueViewerBuilder *sut = [EDValueViewerBuilder valueViewerBuilderWithViewerClass:[EDIvarValueViewer class]];
        
        id sutMock = OCMPartialMock(sut);
        [[sutMock expect] setupFormatter];
        
        EDIvarValueViewer *viewer = [sut build];
        
        EXP_expect(viewer).notTo.beNil;
        [sutMock verify];
    });
});

describe(@"setupFormatter", ^{
    it(@"should set correct formatters to property viewer", ^{
        
        EDValueViewerBuilder *sut = [EDValueViewerBuilder valueViewerBuilderWithViewerClass:[EDPropertyValueViewer class]];
        id sutMock = OCMPartialMock(sut);
        id viewerMock = OCMClassMock([EDPropertyValueViewer class]);
        [[[sutMock stub] andReturn:viewerMock] viewer];
        
        [[viewerMock expect] setObjectFormatter:[OCMArg isKindOfClass:[EDDescriptionFormatter class]]];
        [[viewerMock expect] setAtomicTypesFormatter:[OCMArg isKindOfClass:[EDAtomicTypesFormatter class]]];
        [[viewerMock expect] setStructFormatter:[OCMArg isKindOfClass:[EDStructFormatter class]]];
        [[viewerMock expect] setClassFormatter:[OCMArg isKindOfClass:[EDDescriptionFormatter class]]];
        
        [sut setupFormatter];
        
        [viewerMock verify];
        [sutMock stopMocking];
    });
    
    it(@"should set correct formatters to property viewer", ^{
        
        EDValueViewerBuilder *sut = [EDValueViewerBuilder valueViewerBuilderWithViewerClass:[EDIvarValueViewer class]];
        id sutMock = OCMPartialMock(sut);
        id viewerMock = OCMClassMock([EDIvarValueViewer class]);
        [[[sutMock stub] andReturn:viewerMock] viewer];
        
        [[viewerMock expect] setObjectFormatter:[OCMArg isKindOfClass:[EDDescriptionFormatter class]]];
        [[viewerMock expect] setAtomicTypesFormatter:[OCMArg isKindOfClass:[EDAtomicTypesFormatter class]]];
        [[viewerMock expect] setStructFormatter:[OCMArg isKindOfClass:[EDStructFormatter class]]];
        [[viewerMock expect] setClassFormatter:[OCMArg isKindOfClass:[EDDescriptionFormatter class]]];
        
        [sut setupFormatter];
        
        [viewerMock verify];
        [sutMock stopMocking];
    });
});

SpecEnd
