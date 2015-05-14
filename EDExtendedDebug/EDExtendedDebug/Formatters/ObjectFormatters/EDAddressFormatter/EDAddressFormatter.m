//
//  FUZObjectAddressFormatter.m
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import "EDAddressFormatter.h"

@implementation EDAddressFormatter

- (NSString *)formatValue:(id)value
{
    NSString *className = NSStringFromClass([value class]);
    if ([className hasPrefix:@"__"])
    {
        className = [className stringByReplacingCharactersInRange:NSMakeRange(0, 2)  withString:@""];
    }
    return [NSString stringWithFormat:@"<%@: %p>", className, value];
}

@end
