//
//  FUZCStringFormatter.m
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import "EDCStringFormatter.h"

@implementation EDCStringFormatter

- (NSString *)formatValue:(NSValue *)value
{
    char *cString = NULL;
    [value getValue:&cString];
    return [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];
}

@end
