//
//  FUZPropertyObjectsViewer.m
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import "EDPropertyObjectsViewer.h"

@implementation EDPropertyObjectsViewer

+ (BOOL)returnTypeIsAllowed:(const char *)type
{
    if(type[0] == '@')
    {
        return YES;
    }
    return NO;
}

@end
