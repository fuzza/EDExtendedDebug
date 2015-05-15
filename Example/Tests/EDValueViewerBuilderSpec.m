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

SpecBegin(EDValueViewerBuilder)

describe(@"build", ^{
    
    it(@"Should return filled EDPropertyValueViewer and call setupFormatters", ^{

        EDValueViewerBuilder *sut = [EDValueViewerBuilder new];
        
        id sutMock = OCMPartialMock(sut);
        [[sutMock expect] setupFormatter];
        
        EDPropertyValueViewer *viewer = [sut build];
        
        XCTAssertNotNil(viewer);
        [sutMock verify];
    });

    it(@"setupFormatter should call setup methods", ^{
        
        EDValueViewerBuilder *sut = [EDValueViewerBuilder new];
        id sutMock = OCMPartialMock(sut);
        
        [[sutMock expect] setupObjectFormatter];
        [[sutMock expect] setupClassFormatter];
        [[sutMock expect] setupNumericFormatter];
        [[sutMock expect] setupCStringFormatter];
        [[sutMock expect] setupSelectorFormatter];
        [[sutMock expect] setupStructFormatter];
        
        [sut setupFormatter];
        [sutMock verify];
    });
});

SpecEnd
