//
//  EDIvarValueViewer.m
//  Pods
//
//  Created by Petro Korienev on 1/25/16.
//
//

#import "EDIvarValueViewer.h"
#import "EDIvarHelper.h"

@implementation EDIvarValueViewer

@synthesize structFormatter;
@synthesize objectFormatter;
@synthesize classFormatter;
@synthesize atomicTypesFormatter;

- (NSString *)showValueForIvar:(Ivar)ivar ofObject:(id)anObject {
    NSString *valueDescription = nil;
    NSValue *value = nil;
    
    @try {
        value = [EDIvarHelper valueOfIvar:ivar forObject:anObject];
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
