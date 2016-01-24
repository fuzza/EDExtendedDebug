//
//  FUZPropertyObjectsViewer.m
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import "EDPropertyObjectsViewer.h"

@implementation EDPropertyObjectsViewer

+ (BOOL)returnTypeIsAllowed:(NSString *)type
{
    unichar firstSymbol = [type characterAtIndex:0];
    return (firstSymbol == '@' || firstSymbol == '#');
}

@end
