//
//  EDValueViewerAddressBuilderSpec.m
//  EDExtendedDebug
//
//  Created by Alexey Fayzullov on 5/20/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import <EDExtendedDebug/EDValueViewerAddressBuilder.h>
#import <EDExtendedDebug/EDPropertyValueViewer.h>
#import <EDExtendedDebug/EDIvarValueViewer.h>

SpecBegin(EDValueViewerAddressBuilder)

describe(@"build", ^{
    
    it(@"should return filled viewer and call setupFormatters for property value viewer", ^{
        
        EDValueViewerAddressBuilder *sut = [EDValueViewerAddressBuilder valueViewerBuilderWithViewerClass:[EDPropertyValueViewer class]];
        
        id sutMock = OCMPartialMock(sut);
        [[sutMock expect] setupFormatter];
        
        EDPropertyValueViewer *viewer = [sut build];
        
        EXP_expect(viewer).notTo.beNil;
        [sutMock verify];
    });
    
    it(@"should return filled viewer and call setupFormatters for ivar value viewer", ^{
        
        EDValueViewerAddressBuilder *sut = [EDValueViewerAddressBuilder valueViewerBuilderWithViewerClass:[EDIvarValueViewer class]];
        
        id sutMock = OCMPartialMock(sut);
        [[sutMock expect] setupFormatter];
        
        EDIvarValueViewer *viewer = [sut build];
        
        EXP_expect(viewer).notTo.beNil;
        [sutMock verify];
    });
});

describe(@"setupFormatter", ^{
    it(@"should set correct formatters to property viewer", ^{
        
        EDValueViewerAddressBuilder *sut = [EDValueViewerAddressBuilder valueViewerBuilderWithViewerClass:[EDPropertyValueViewer class]];
        id sutMock = OCMPartialMock(sut);
        id viewerMock = OCMClassMock([EDPropertyValueViewer class]);
        [[[sutMock stub] andReturn:viewerMock] viewer];
        
        [[viewerMock expect] setObjectFormatter:[OCMArg isKindOfClass:[EDAddressFormatter class]]];
        [[viewerMock expect] setAtomicTypesFormatter:[OCMArg isKindOfClass:[EDAtomicTypesFormatter class]]];
        [[viewerMock expect] setStructFormatter:[OCMArg isKindOfClass:[EDStructFormatter class]]];
        [[viewerMock expect] setClassFormatter:[OCMArg isKindOfClass:[EDDescriptionFormatter class]]];
        
        [sut setupFormatter];
        
        [viewerMock verify];
        [sutMock stopMocking];
    });
    
    it(@"should set correct formatters to ivar viewer", ^{
        
        EDValueViewerAddressBuilder *sut = [EDValueViewerAddressBuilder valueViewerBuilderWithViewerClass:[EDIvarValueViewer class]];
        id sutMock = OCMPartialMock(sut);
        id viewerMock = OCMClassMock([EDIvarValueViewer class]);
        [[[sutMock stub] andReturn:viewerMock] viewer];
        
        [[viewerMock expect] setObjectFormatter:[OCMArg isKindOfClass:[EDAddressFormatter class]]];
        [[viewerMock expect] setAtomicTypesFormatter:[OCMArg isKindOfClass:[EDAtomicTypesFormatter class]]];
        [[viewerMock expect] setStructFormatter:[OCMArg isKindOfClass:[EDStructFormatter class]]];
        [[viewerMock expect] setClassFormatter:[OCMArg isKindOfClass:[EDDescriptionFormatter class]]];
        
        [sut setupFormatter];
        
        [viewerMock verify];
        [sutMock stopMocking];
    });
});

SpecEnd

