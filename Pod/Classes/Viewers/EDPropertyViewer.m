//
//  FUZPropertyViewer.m
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import "EDPropertyViewer.h"
#import "EDPropertyValueViewer.h"
#import "EDPropertyHelper.h"

@implementation EDPropertyViewer

+ (NSString *)descriptionOfProperty:(objc_property_t)property forObject:(id)object valueBuilder:(EDValueViewerBuilder *)builder indent:(NSInteger)indent
{
    NSString *resultDescription = @"";
    for (NSInteger i = 0; i < indent; i++)
    {
        resultDescription = [resultDescription stringByAppendingString:@"\t"];
    }
    resultDescription = [resultDescription stringByAppendingFormat:@"%@ : ", [EDPropertyHelper nameOfProperty:property]];
    
    NSString *encodedReturnType = [EDPropertyHelper encodedReturnTypeStringOfProperty:property];
    
    if(![self returnTypeIsAllowed:encodedReturnType])
    {
        resultDescription = [resultDescription stringByAppendingString:@" type is unsupported by current version of ED_extendedDebug\n"];
    }
    else {
        EDPropertyValueViewer *viewer = [builder build];

        NSString *valueDescription = [viewer showValueForProperty:property ofObject:object];
        if (valueDescription) {
            resultDescription = [resultDescription stringByAppendingFormat:@"%@\n", valueDescription];
        }
        else {
            resultDescription = [resultDescription stringByAppendingString:@"property getter is not implemented - it's inherited as protocol member\n"];
        }
    }
    return resultDescription;
}

+ (BOOL)returnTypeIsAllowed:(NSString *)type
{
    return YES;
}

@end
