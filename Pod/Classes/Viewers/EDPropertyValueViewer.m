//
//  FUZPropertyViewStrategy.m
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import "EDPropertyValueViewer.h"
#import "EDFormatters.h"
#import "EDPropertyHelper.h"

@interface EDPropertyValueViewer ()

@end

@implementation EDPropertyValueViewer

- (NSString *)showValueForProperty:(objc_property_t)property ofObject:(id)anObject
{
    NSString *valueDescription = nil;
    NSValue *value = nil;
    
    @try {
        value = [EDPropertyHelper valueOfProperty:property forObject:anObject];
    }
    @catch (NSException *exception) {
        valueDescription = @"Exception thrown while obtaining value";
    }
    @finally {}
    
    if(value)
    {
        switch (value.objCType[0]) {
            case '@':
                valueDescription = [self.objectFormatter formatValue:value];
                break;
            case 'i':
            case 's':
            case 'l':
            case 'q':
            case 'I':
            case 'S':
            case 'L':
            case 'Q':
            case 'f':
            case 'd':
            case 'c':
            case 'C':
            case 'B':
            case '*':
            case ':':
                valueDescription = [self.atomicTypesFormatter formatValue:value];
                break;
            case '#':
                valueDescription = [self.classFormatter formatValue:value];
                break;
            case '{':
                valueDescription = [self.structFormatter formatValue:value];
                break;
            default:
                valueDescription = @"???";
        }
    }
    return valueDescription;
}

@end
