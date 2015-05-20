//
//  EDStructFormatterSpec.m
//  EDExtendedDebug
//
//  Created by Alexey Fayzullov on 5/20/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import <EDExtendedDebug/EDStructFormatter.h>

SpecBegin(EDStructFormatter)

describe(@"formatValue", ^{
    
    it(@"should return nil if non-struct is passed", ^{
        EDStructFormatter *sut = [EDStructFormatter new];
        
        NSInteger anInteger = 5;
        NSValue *wrapedInteger = [NSValue valueWithBytes:&anInteger objCType:@encode(NSInteger)];
        
        NSString *formattedString = [sut formatValue:wrapedInteger];
        
        EXP_expect(formattedString).to.beNil;
    });
    
    it(@"should return nil if NULL struct is passed", ^{
        
        EDStructFormatter *sut = [EDStructFormatter new];
        
        CGRect rect;
        NSValue *wrappedNilObject = [NSValue valueWithBytes:&rect objCType:@encode(CGRect)];
        
        NSString *formattedString = [sut formatValue:wrappedNilObject];
        
        EXP_expect(formattedString).to.beNil;
    });
    
    it(@"should return formatted CGRect", ^{
       
        EDStructFormatter *sut = [EDStructFormatter new];
        
        CGRect rect = CGRectMake(0, 0, 320, 240);
        NSValue *wrappedStruct = [NSValue valueWithBytes:&rect objCType:@encode(CGRect)];
        
        NSString *formattedString = [sut formatValue:wrappedStruct];
        
        EXP_expect(formattedString).to.equal(NSStringFromCGRect(rect));
    });
    
    it(@"should return formatted CGPoint", ^{
        
        EDStructFormatter *sut = [EDStructFormatter new];
        
        CGPoint point = CGPointMake(320, 240);
        NSValue *wrappedStruct = [NSValue valueWithBytes:&point objCType:@encode(CGPoint)];
        
        NSString *formattedString = [sut formatValue:wrappedStruct];
        
        EXP_expect(formattedString).to.equal(NSStringFromCGPoint(point));
    });
    
    it(@"should return formatted CGSize", ^{
        
        EDStructFormatter *sut = [EDStructFormatter new];
        
        CGSize size = CGSizeMake(320, 240);
        NSValue *wrappedStruct = [NSValue valueWithBytes:&size objCType:@encode(CGSize)];
        
        NSString *formattedString = [sut formatValue:wrappedStruct];
        
        EXP_expect(formattedString).to.equal(NSStringFromCGSize(size));
    });
    
    it(@"should return formatted UIEdgeInsets", ^{
        
        EDStructFormatter *sut = [EDStructFormatter new];
        
        UIEdgeInsets insets = UIEdgeInsetsMake(20, 15, 15, 20);
        NSValue *wrappedStruct = [NSValue valueWithBytes:&insets objCType:@encode(UIEdgeInsets)];
        
        NSString *formattedString = [sut formatValue:wrappedStruct];
        
        EXP_expect(formattedString).to.equal(NSStringFromUIEdgeInsets(insets));
    });
    
    it(@"should return formatted UIOffset", ^{
        
        EDStructFormatter *sut = [EDStructFormatter new];
        
        UIOffset offset = UIOffsetMake(25, 20);
        NSValue *wrappedStruct = [NSValue valueWithBytes:&offset objCType:@encode(UIOffset)];
        
        NSString *formattedString = [sut formatValue:wrappedStruct];
        
        EXP_expect(formattedString).to.equal(NSStringFromUIOffset(offset));
    });
    
    it(@"should return formatted CGAfflineTransform", ^{
        
        EDStructFormatter *sut = [EDStructFormatter new];
        
        CGAffineTransform transform = CGAffineTransformMake(5, 5, 5, 5, 5, 5);
        NSValue *wrappedStruct = [NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)];
        
        NSString *formattedString = [sut formatValue:wrappedStruct];
        
        EXP_expect(formattedString).to.equal(NSStringFromCGAffineTransform(transform));
    });

    it(@"should return formatted NSRange", ^{
        
        EDStructFormatter *sut = [EDStructFormatter new];
        
        NSRange range = NSMakeRange(0, 15);
        NSValue *wrappedStruct = [NSValue valueWithBytes:&range objCType:@encode(NSRange)];
        
        NSString *formattedString = [sut formatValue:wrappedStruct];
        
        EXP_expect(formattedString).to.equal(NSStringFromRange(range));
    });
    
});

SpecEnd
