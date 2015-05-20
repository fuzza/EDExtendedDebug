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
        case 'c': return @(*(char *)bytes).description;
        case 'C': return @(*(unsigned char *)bytes).description;
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
        case 'B': return @(*(_Bool *)bytes).description;
        case 'v': return @"(void)";
        case ':': return NSStringFromSelector(*(SEL *)bytes);
        case '*': return [NSString stringWithFormat:@"\"%s\"", bytes];
        case '?':
        case '^': {
            const void *ptr = *(const void **)bytes;
            if (ptr)
                return [NSString stringWithFormat:@"%p", ptr];
            else
                return @"(null)";
        }
        default: return nil;
    }

    return @"";
}


@end
