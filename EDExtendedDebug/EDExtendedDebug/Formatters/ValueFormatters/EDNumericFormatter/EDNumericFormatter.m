//
//  FUZStringValueFormatter.m
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import "EDNumericFormatter.h"

@implementation EDNumericFormatter

- (NSString *)formatNumericFromValue:(NSNumber *)value
{
    return [value stringValue];
}

- (NSString *)formatBoolFromValue:(NSNumber *)value
{
    return [value performSelector:@selector(boolValue)] ? @"YES" : nil;
}

- (NSString *)formatCharFromValue:(NSNumber *)value
{
    return [NSString stringWithFormat:@"%c (%@)",[value charValue], [value stringValue]];
}


@end
