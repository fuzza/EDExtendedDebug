//
//  FUZStructFormatter.m
//  FUZExtendedDebug
//
//  Created by Alexey Fayzullov on 5/14/15.
//  Copyright (c) 2015 Alexey Fayzullov. All rights reserved.
//

#import "EDStructFormatter.h"
#import <UIKit/UIKit.h>

@implementation EDStructFormatter

- (NSString *)formatValue:(NSValue *)value
{
    const char *objCType = [value objCType];
    
    if(strcmp(objCType, @encode(CGRect)) == 0)
    {
        return NSStringFromCGRect([value CGRectValue]);
    }
    if(strcmp(objCType, @encode(CGPoint)) == 0)
    {
        return NSStringFromCGPoint([value CGPointValue]);
    }
    if(strcmp(objCType, @encode(CGSize)) == 0)
    {
        return NSStringFromCGSize([value CGSizeValue]);
    }
    if(strcmp(objCType, @encode(UIEdgeInsets)) == 0)
    {
        return NSStringFromUIEdgeInsets([value UIEdgeInsetsValue]);
    }
    if(strcmp(objCType, @encode(UIOffset)) == 0)
    {
        return NSStringFromUIOffset([value UIOffsetValue]);
    }
    if(strcmp(objCType, @encode(CGAffineTransform)) == 0)
    {
        return NSStringFromCGAffineTransform([value CGAffineTransformValue]);
    }
    if(strcmp(objCType, @encode(NSRange)) == 0)
    {
        return NSStringFromRange([value rangeValue]);
    }
    return nil;
}

- (NSArray *)registeredTypeCodes
{
    return @[@('{')];
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
