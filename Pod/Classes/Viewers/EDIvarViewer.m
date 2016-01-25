//
//  EDIvarViewer.m
//  Pods
//
//  Created by Petro Korienev on 1/25/16.
//
//

#import "EDIvarViewer.h"
#import "EDIvarValueViewer.h"
#import "EDIvarHelper.h"

@implementation EDIvarViewer

+ (NSString *)descriptionOfIvar:(Ivar)ivar forObject:(id)object valueBuilder:(EDValueViewerBuilder *)builder indent:(NSInteger)indent
{
    NSString *resultDescription = @"";
    for (NSInteger i = 0; i < indent; i++)
    {
        resultDescription = [resultDescription stringByAppendingString:@"\t"];
    }
    resultDescription = [resultDescription stringByAppendingFormat:@"%@ : ", [EDIvarHelper nameOfIvar:ivar]];
    
    NSString *encodedReturnType = [EDIvarHelper encodedTypeForIvar:ivar];
    
    if(![self returnTypeIsAllowed:encodedReturnType])
    {
        resultDescription = [resultDescription stringByAppendingString:@" type is unsupported by current version of ED_extendedDebug\n"];
    }
    else {
        EDIvarValueViewer *viewer = [builder build];
        
        NSString *valueDescription = [viewer showValueForIvar:ivar ofObject:object];
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
