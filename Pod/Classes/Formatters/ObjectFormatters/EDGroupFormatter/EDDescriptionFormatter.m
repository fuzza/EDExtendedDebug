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
    if(value.objCType[0] == '@' || value.objCType[0] == '#')
    {
        id __unsafe_unretained object;
        [value getValue:&object];
        return [object description];
    }
    return nil;
}

@end
