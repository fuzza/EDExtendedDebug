//
//  FUZStringValueFormatter.m
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.

#import "EDAtomicTypesFormatter.h"

@implementation EDAtomicTypesFormatter

- (NSString *)formatValue:(NSValue *)value
{
    NSUInteger valueSize;
    NSUInteger align;
    
    NSGetSizeAndAlignment(value.objCType, &valueSize, &align);
    void *bytes = malloc(valueSize);
    [value getValue:bytes];
    
    switch (value.objCType[0]) {
        case 'c': return [NSString stringWithFormat:@"%c", @(*(char *)bytes).charValue];
        case 'C': return [NSString stringWithFormat:@"%c", @(*(unsigned char *)bytes).unsignedCharValue];
        case 'i': return @(*(int *)bytes).description;
        case 'I': return @(*(unsigned int *)bytes).description;
        case 's': return @(*(short *)bytes).description;
        case 'S': return @(*(unsigned short *)bytes).description;
        case 'l': return @(*(long *)bytes).description;
        case 'L': return @(*(unsigned long *)bytes).description;
        case 'q': return @(*(long long *)bytes).description;
        case 'Q': return @(*(unsigned long long *)bytes).description;
        case 'f': return @(*(float *)bytes).description;
        case 'd': return @(*(double *)bytes).description;
        case 'B': return @(*(_Bool *)bytes).boolValue ? @"YES" : nil;
        case 'v': return @"(void)";
        case ':': return NSStringFromSelector(*(SEL *)bytes);
        case '*':
        {
            char *cString = NULL;
            [value getValue:&cString];
            return [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];
        }
        case '?':
        case '^':
        {
            const void *ptr = *(const void **)bytes;
            if (ptr)
                return [NSString stringWithFormat:@"%p", ptr];
            else
                return nil;
        }
        default: return nil;
    }
    return nil;
}

- (NSArray *)registeredTypeCodes
{
    return @[@('c'), @('C'), @('i'), @('I'), @('s'), @('S'), @('l'), @('L'), @('q'), @('Q'), @('f'), @('d'), @('B'), @('v'), @(':'), @('*'), @('?'), @('^')];
}

- (BOOL)isRegisteredForType:(const char *)type
{
    for (NSNumber *registeredType in [self registeredTypeCodes])
    {
        if(registeredType.charValue == type[0])
        {
            return YES;
        }
    }
    return NO;
}

@end
