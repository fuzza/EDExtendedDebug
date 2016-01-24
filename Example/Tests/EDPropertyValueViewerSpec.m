//
//  EDPropertyValueViewerSpec.m
//  EDExtendedDebug
//
//  Created by Alexey Fayzullov on 5/21/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import <EDExtendedDebug/EDPropertyValueViewer.h>
#import <EDExtendedDebug/EDValueFormatterProtocol.h>
#import <EDExtendedDebug/EDPropertyHelper.h>

SpecBegin(EDPropertyValueViewer)

describe(@"showValue", ^{
    
    EDPropertyValueViewer __block *sut;
    id __block sutMock;
    id __block valueMock;
    
    id __block objectFormatterMock;
    id __block classFormatterMock;
    id __block atomicTypesFormatterMock;
    id __block structFormatterMock;
    id __block propertyHelperMock;

    beforeEach(^{
        sut = [EDPropertyValueViewer new];
        sutMock = OCMPartialMock(sut);
        valueMock = OCMClassMock([NSValue class]);
        
        objectFormatterMock = OCMProtocolMock(@protocol(EDValueFormatterProtocol));
        classFormatterMock = OCMProtocolMock(@protocol(EDValueFormatterProtocol));
        atomicTypesFormatterMock = OCMProtocolMock(@protocol(EDValueFormatterProtocol));
        structFormatterMock = OCMProtocolMock(@protocol(EDValueFormatterProtocol));
        propertyHelperMock = OCMClassMock([EDPropertyHelper class]);
        
        sut.objectFormatter = objectFormatterMock;
        sut.classFormatter = classFormatterMock;
        sut.atomicTypesFormatter = atomicTypesFormatterMock;
        sut.structFormatter = structFormatterMock;
    });
    
    afterEach(^{
        sut = nil;
        [sutMock stopMocking];
        [valueMock stopMocking];
        [objectFormatterMock stopMocking];
        [classFormatterMock stopMocking];
        [atomicTypesFormatterMock stopMocking];
        [structFormatterMock stopMocking];
        [propertyHelperMock stopMocking];
    });
    
    it(@"should return nil if args aren't passed", ^{
        
        NSString *resultString = [sut showValueForProperty:class_getProperty([self class], "description")
                                                  ofObject:self];
        EXP_expect(resultString).to.beNil;
    });
    
    it(@"should return formatted object", ^{
        
        [[[propertyHelperMock stub] andReturn:valueMock] valueOfProperty:class_getProperty([self class], "description") forObject:[OCMArg any]];
        
        const char *type = @encode(id);
    
        [[[valueMock stub] andReturnValue:OCMOCK_VALUE(type)] objCType];
        [[[objectFormatterMock stub] andReturn:@"formatted object"] formatValue:valueMock];
        
        NSString *resultString = [sut showValueForProperty:class_getProperty([self class], "description")
                                                  ofObject:self];
        EXP_expect(resultString).to.equal(@"formatted object");
    });
    
    it(@"should return formatted struct", ^{
        
        [[[propertyHelperMock stub] andReturn:valueMock] valueOfProperty:class_getProperty([self class], "description") forObject:[OCMArg any]];
        
        const char *type = "{";
        
        [[[valueMock stub] andReturnValue:OCMOCK_VALUE(type)] objCType];
        [[[structFormatterMock stub] andReturn:@"formatted struct"] formatValue:valueMock];
        
        NSString *resultString = [sut showValueForProperty:class_getProperty([self class], "description")
                                                  ofObject:self];
        EXP_expect(resultString).to.equal(@"formatted struct");
    });
    
    it(@"should return formatted class", ^{
        [[[propertyHelperMock stub] andReturn:valueMock] valueOfProperty:class_getProperty([self class], "description") forObject:[OCMArg any]];
        
        const char *type = @encode(Class);
        
        [[[valueMock stub] andReturnValue:OCMOCK_VALUE(type)] objCType];
        [[[classFormatterMock stub] andReturn:@"formatted class"] formatValue:valueMock];
        
        NSString *resultString = [sut showValueForProperty:class_getProperty([self class], "description")
                                                  ofObject:self];
        EXP_expect(resultString).to.equal(@"formatted class");
    });
    
    it(@"should return formatted class", ^{
        [[[propertyHelperMock stub] andReturn:valueMock] valueOfProperty:class_getProperty([self class], "description") forObject:[OCMArg any]];
        
        const char *type = @encode(Class);
        
        [[[valueMock stub] andReturnValue:OCMOCK_VALUE(type)] objCType];
        [[[classFormatterMock stub] andReturn:@"formatted class"] formatValue:valueMock];
        
        NSString *resultString = [sut showValueForProperty:class_getProperty([self class], "description")
                                                  ofObject:self];
        EXP_expect(resultString).to.equal(@"formatted class");
    });
    
    it(@"should return formatted atomic", ^{
        [[[propertyHelperMock stub] andReturn:valueMock] valueOfProperty:class_getProperty([self class], "description") forObject:[OCMArg any]];
        
        const char *type = @encode(int);
        
        [[[valueMock stub] andReturnValue:OCMOCK_VALUE(type)] objCType];
        [[[atomicTypesFormatterMock stub] andReturn:@"formatted atomic"] formatValue:valueMock];
        
        NSString *resultString = [sut showValueForProperty:class_getProperty([self class], "description")
                                                  ofObject:self];
        EXP_expect(resultString).to.equal(@"formatted atomic");
    });
});

SpecEnd
