//
//  FUZSelectorFormatter.m
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import "EDSelectorFormatter.h"

@implementation EDSelectorFormatter

- (NSString *)formatValue:(NSValue *)value
{
    SEL selector = NULL;
    [value getValue:&selector];
    return NSStringFromSelector(selector);
}

@end
