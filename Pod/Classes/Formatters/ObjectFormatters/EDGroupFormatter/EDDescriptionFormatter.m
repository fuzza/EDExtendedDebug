//
//  FUZObjectDescriptionFormatter.m
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import "EDDescriptionFormatter.h"

@implementation EDDescriptionFormatter

- (NSString *)formatValue:(NSValue *)value
{
    id __unsafe_unretained object;
    [value getValue:&object];
    return [object description];
}

@end
