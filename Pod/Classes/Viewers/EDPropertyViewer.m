//
//  FUZPropertyViewer.m
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import "EDPropertyViewer.h"
#import "EDPropertyValueViewer.h"

@implementation EDPropertyViewer

+ (NSString *)descriptionOfProperty:(objc_property_t)property forObject:(id)object valueBuilder:(EDValueViewerBuilder *)builder indent:(NSInteger)indent
{
    NSString *resultDescription = @"";
    for (NSInteger i = 0; i < indent; i++)
    {
        resultDescription = [resultDescription stringByAppendingString:@"\t"];
    }
    resultDescription = [resultDescription stringByAppendingFormat:@"%s : ", property_getName(property)];
    
    NSString *getterName = [self getterNameForProperty:property];
    
    const char *encodedReturnType = property_copyAttributeValue(property, "T");
    
    if(![self returnTypeIsAllowed:encodedReturnType])
    {
        resultDescription = [resultDescription stringByAppendingString:@" type is unsupported by current version of ED_extendedDebug\n"];
    }
    else {
        EDPropertyValueViewer *viewer = [builder build];

        NSString *valueDescription = [viewer showValueWithReceiver:object key:getterName objCType:encodedReturnType];
        if (valueDescription) {
            resultDescription = [resultDescription stringByAppendingFormat:@"%@\n", valueDescription];
        }
        else {
            resultDescription = [resultDescription stringByAppendingString:@"property getter is not implemented - it's inherited as protocol member\n"];
        }
    }
    return resultDescription;
}

+ (NSString *)getterNameForProperty:(objc_property_t)property
{
    const char *getterName = property_copyAttributeValue(property, "G");
    if(getterName == nil)
    {
        return [self nameOfProperty:property];
    }
    return [NSString stringWithCString:getterName encoding:NSUTF8StringEncoding];
}

+ (NSString *)nameOfProperty:(objc_property_t)property
{
    return [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
}

+ (BOOL)returnTypeIsAllowed:(const char *)type
{
    return YES;
}

@end
