//
//  FUZObjectAddressFormatter.m
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import "EDAddressFormatter.h"

@implementation EDAddressFormatter

- (NSString *)formatValue:(NSValue *)value
{
    if(value.objCType[0] == '@')
    {
        id __unsafe_unretained object;
        [value getValue:&object];
        NSString *className = NSStringFromClass([object class]);
        if ([className hasPrefix:@"__"])
        {
            className = [className stringByReplacingCharactersInRange:NSMakeRange(0, 2)  withString:@""];
        }
        return [NSString stringWithFormat:@"<%@: %p>", className, object];
    }
    return nil;
}

- (NSArray *)registeredTypeCodes
{
    return @[@('@')];
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
